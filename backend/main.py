"""
AgriDaan FastAPI Backend
Complete implementation with Swagger interface
"""
from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from datetime import datetime, timedelta
import uuid
import os
from typing import Dict, Any, List
import json

# Import models, config, and data
from models import *
from config import config
from data_config import data_config
from data_management import router as data_management_router
from database import get_db, init_database, get_user_by_mobile, get_session_by_id, Session, User, UserSession
from logging_config import setup_logging, get_logger, log_api_call, log_authentication, log_contribution, log_validation, log_certificate, log_error
from storage_service import storage_service

# Initialize FastAPI app
app = FastAPI(
    title="VoiceGive API",
    description="""
    VoiceGive is a mobile friendly application designed for language data (Voice based) collection 
    and crowdsourcing initiatives. This project provides a complete, customizable user interface 
    that can be adopted by organizations, government agencies, and developers to build their own 
    language voice data collection applications.

    **Certificate Requirements:**
    - 5 voice contributions
    - 25 validations
    """,
    version="1.0.0",
    contact={
        "name": "VoiceGive Support",
        "email": "voicegive.ai4x@gmail.com"
    },
    license_info={
        "name": "MIT"
    }
)

# Setup middleware
from middleware import setup_middleware
setup_middleware(app)

# Include data management router
app.include_router(data_management_router)

# Setup logging
setup_logging(config.environment, config.log_level)
logger = get_logger("main")

# Initialize database
init_database()

# Security
security = HTTPBearer()

# Mock data storage (in production, use database)
mock_data = {
    "users": {},
    "sessions": {},
    "contributions": {},
    "validations": {},
    "certificates": {}
}

# ==================== Authentication Endpoints ====================

@app.post("/auth/send-otp", response_model=SendOTPResponse, tags=["Authentication"])
async def send_otp(request: SendOTPRequest, db: Session = Depends(get_db)):
    """Send OTP to mobile number"""
    try:
        log_api_call(logger, "/auth/send-otp", "POST")
        
        session_id = str(uuid.uuid4())
        expires_at = datetime.utcnow() + timedelta(seconds=config.otp_expiry_seconds)
        
        # Check if user exists
        user = get_user_by_mobile(db, request.mobileNo)
        is_new_user = user is None
        
        # Store session in database
        session = UserSession(
            session_id=session_id,
            mobile_no=request.mobileNo,
            otp_code=config.mock_otp,  # In production, generate real OTP
            otp_expires_at=expires_at,
            expires_at=expires_at
        )
        db.add(session)
        db.commit()
        
        log_authentication(logger, "otp_sent", None, request.mobileNo)
        
        return SendOTPResponse(
            data={
                "sessionId": session_id,
                "expiresIn": config.otp_expiry_seconds,
                "expiresAt": expires_at.isoformat() + "Z",
                "isNewUser": is_new_user
            }
        )
    except Exception as e:
        log_error(logger, e, {"endpoint": "/auth/send-otp", "mobile": request.mobileNo})
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/auth/resend-otp", response_model=Dict[str, Any], tags=["Authentication"])
async def resend_otp(request: ResendOTPRequest, db: Session = Depends(get_db)):
    """Resend OTP"""
    try:
        log_api_call(logger, "/auth/resend-otp", "POST")
        
        # Find the most recent session for this mobile number
        session = db.query(UserSession).filter(
            UserSession.mobile_no == request.mobileNo
        ).order_by(UserSession.created_at.desc()).first()
        
        if not session:
            raise HTTPException(status_code=400, detail="No OTP session found for this mobile number")
        
        # Check if session is expired
        from datetime import timezone
        if session.otp_expires_at.replace(tzinfo=timezone.utc) < datetime.now(timezone.utc):
            raise HTTPException(status_code=400, detail="OTP session expired. Please request a new OTP.")
        
        # Update the session with new expiry time
        new_expires_at = datetime.utcnow() + timedelta(seconds=config.otp_expiry_seconds)
        session.otp_expires_at = new_expires_at
        session.expires_at = new_expires_at
        db.commit()
        
        log_authentication(logger, "otp_resent", None, request.mobileNo)
        
        return {
            "success": True,
            "message": "OTP resent successfully",
            "data": {
                "expiresIn": config.otp_expiry_seconds,
                "expiresAt": new_expires_at.isoformat() + "Z"
            }
        }
    except Exception as e:
        log_error(logger, e, {"endpoint": "/auth/resend-otp", "mobile": request.mobileNo})
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/auth/verify-otp", response_model=VerifyOTPResponse, tags=["Authentication"])
async def verify_otp(request: VerifyOTPRequest, db: Session = Depends(get_db)):
    """Verify OTP and login"""
    try:
        log_api_call(logger, "/auth/verify-otp", "POST")
        
        # Find the most recent session for this mobile number
        session = db.query(UserSession).filter(
            UserSession.mobile_no == request.mobileNo
        ).order_by(UserSession.created_at.desc()).first()
        
        if not session:
            raise HTTPException(status_code=400, detail="No OTP session found for this mobile number")
        
        # Check if session is expired
        from datetime import timezone
        if session.otp_expires_at.replace(tzinfo=timezone.utc) < datetime.now(timezone.utc):
            raise HTTPException(status_code=400, detail="OTP session expired. Please request a new OTP.")
        
        # Verify OTP
        if session.otp_code != request.otp:
            raise HTTPException(status_code=401, detail="Invalid OTP")
        
        # Generate JWT token (simplified)
        access_token = f"jwt_token_{uuid.uuid4()}"
        refresh_token = f"refresh_token_{uuid.uuid4()}"
        
        # Get or create user
        user = get_user_by_mobile(db, session.mobile_no)
        if not user:
            # Create new user with required fields
            from database import UserAgeGroup, UserGender
            user = User(
                mobile_no=session.mobile_no,
                first_name="User",
                last_name="Name",
                email=None,
                age_group=UserAgeGroup.AGE_26_30,
                gender=UserGender.OTHER,
                country="India",
                state="Maharashtra",
                district="Mumbai",
                preferred_language="Marathi"
            )
            db.add(user)
            db.commit()
            db.refresh(user)
        
        return VerifyOTPResponse(
            success=True,
            message="Login successful",
            data={
                "accessToken": access_token,
                "refreshToken": refresh_token,
                "tokenType": "Bearer",
                "expiresIn": config.token_expiry_seconds,
                "user": {
                    "userId": user.id,
                    "mobileNo": session.mobile_no
                },
                "requiresConsent": True,
                "requiresProfile": False
            }
        )
    except Exception as e:
        log_error(logger, e, {"endpoint": "/auth/verify-otp", "mobile": request.mobileNo})
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/auth/consent", response_model=ConsentResponse, tags=["Authentication"])
async def accept_consent(request: ConsentRequest):
    """Accept terms and conditions"""
    if not (request.termsAccepted and request.privacyAccepted and request.copyrightAccepted):
        raise HTTPException(status_code=400, detail="All consents must be accepted")
    
    return ConsentResponse(
        data={
            "consentId": str(uuid.uuid4()),
            "consentTimestamp": datetime.utcnow().isoformat() + "Z",
            "ipAddress": "192.168.1.1"
        }
    )

@app.post("/auth/logout", response_model=Dict[str, Any], tags=["Authentication"])
async def logout():
    """Logout user"""
    return {
        "success": True,
        "message": "Logged out successfully"
    }

@app.post("/auth/refresh-token", response_model=Dict[str, Any], tags=["Authentication"])
async def refresh_token():
    """Refresh access token"""
    return {
        "accessToken": f"new_jwt_token_{uuid.uuid4()}",
        "tokenType": "Bearer",
        "expiresIn": config.token_expiry_seconds
    }

# ==================== User Profile Endpoints ====================

@app.post("/users/register", response_model=Dict[str, Any], tags=["User Profile"])
async def register_user(request: UserRegistrationRequest):
    """Complete user registration"""
    user_id = str(uuid.uuid4())
    user_profile = UserProfile(
        userId=user_id,
        firstName=request.firstName,
        lastName=request.lastName,
        mobileNo=f"+91{request.mobileNo}" if request.mobileNo else f"+91{config.mock_mobile}",
        email=request.email,
        ageGroup=request.ageGroup,
        gender=request.gender,
        country=request.country,
        state=request.state,
        district=request.district,
        preferredLanguageCode=request.preferredLanguageCode
    )
    
    mock_data["users"][user_id] = user_profile.dict()
    
    return {
        "success": True,
        "message": "Profile completed successfully",
        "data": user_profile.dict()
    }

@app.get("/users/profile", response_model=Dict[str, Any], tags=["User Profile"])
async def get_user_profile():
    """Get current user profile"""
    # Mock user profile
    user_profile = {
        "userId": str(uuid.uuid4()),
        "firstName": config.mock_first_name,
        "lastName": config.mock_last_name,
        "mobileNo": f"+91{config.mock_mobile}",
        "email": config.mock_email,
        "ageGroup": "26-30 years",
        "gender": "Female",
        "country": "India",
        "state": config.mock_state,
        "district": config.mock_district,
        "preferredLanguage": config.mock_language,
        "contributionCount": 5,
        "validationCount": 25,
        "certificateEarned": True,
        "certificateId": config.mock_certificate_id,
        "consentGiven": True,
        "consentTimestamp": "2025-01-17T10:30:00Z",
        "createdAt": "2025-01-17T10:30:00Z",
        "updatedAt": "2025-01-17T10:30:00Z"
    }
    
    return {
        "success": True,
        "data": user_profile
    }

@app.put("/users/profile", response_model=Dict[str, Any], tags=["User Profile"])
async def update_user_profile(request: UserRegistrationRequest):
    """Update user profile"""
    return {
        "success": True,
        "message": "Profile updated successfully"
    }

@app.get("/users/stats", response_model=UserStatsResponse, tags=["User Profile"])
async def get_user_stats():
    """Get user contribution statistics"""
    return UserStatsResponse(
        data={
            "contributionCount": 5,
            "validationCount": 25,
            "certificateEligible": True,
            "certificateIssued": False,
            "certificateId": config.mock_certificate_id,
            "lastContributionDate": "2025-01-17T10:30:00Z",
            "lastValidationDate": "2025-01-17T10:30:00Z"
        }
    )

# ==================== Location Endpoints ====================

@app.get("/location/countries", response_model=Dict[str, Any], tags=["Location"])
async def get_countries():
    """Get country list"""
    countries = data_config.get_countries()
    
    return {
        "success": True,
        "data": countries
    }

@app.get("/location/states", response_model=Dict[str, Any], tags=["Location"])
async def get_states(countryId: str = "IN"):
    """Get state list"""
    states = data_config.get_states(countryId)
    
    return {
        "success": True,
        "data": states
    }

@app.get("/location/districts", response_model=Dict[str, Any], tags=["Location"])
async def get_districts(stateId: str):
    """Get district list"""
    districts = data_config.get_districts(stateId)
    
    return {
        "success": True,
        "data": districts
    }

# ==================== System Endpoints ====================

@app.get("/system/languages", response_model=Dict[str, Any], tags=["System"])
async def get_languages():
    """Get supported languages"""
    languages = data_config.get_languages()
    
    return {
        "success": True,
        "data": languages
    }

@app.get("/system/test-speaker", tags=["System"])
async def test_speaker():
    """Get sample audio for speaker test"""
    return {"message": "Sample audio file would be returned here"}

@app.post("/system/test-microphone", response_model=Dict[str, Any], tags=["System"])
async def test_microphone():
    """Test microphone quality"""
    return {
        "success": True,
        "data": {
            "quality": "good",
            "volumeLevel": 0.75,
            "backgroundNoise": 0.15,
            "recommendations": ["Reduce background noise", "Speak slightly louder"]
        }
    }

@app.get("/system/health", response_model=HealthResponse, tags=["System"])
async def health_check():
    """Health check endpoint"""
    return HealthResponse(
        data={
            "status": "healthy",
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "version": "1.0.0",
            "uptime": 86400,
            "services": {
                "database": "up",
                "storage": "up",
                "external_apis": "up"
            }
        }
    )

@app.get("/system/version", response_model=VersionResponse, tags=["System"])
async def get_version():
    """Get API version information"""
    return VersionResponse(
        data={
            "apiVersion": "1.0.0",
            "buildVersion": "1.0.0-build.123",
            "buildDate": "2025-01-17T08:15:30Z",
            "environment": config.environment,
            "features": [
                "voice_contributions",
                "audio_validation", 
                "certificate_generation",
                "multi_language_support"
            ],
            "supportedLanguages": [
                {"code": "mr", "name": "Marathi", "nativeName": "मराठी"},
                {"code": "hi", "name": "Hindi", "nativeName": "हिन्दी"}
            ],
            "limits": {
                "maxAudioSize": config.max_audio_size_bytes,
                "maxAudioDuration": config.max_audio_duration_seconds,
                "sessionTimeout": config.session_timeout_seconds
            },
            "dependencies": {
                "database": "PostgreSQL 14.5",
                "cache": "Redis 6.2",
                "storage": "AWS S3"
            }
        }
    )

@app.get("/system/config", response_model=SystemConfigResponse, tags=["System"])
async def get_system_config():
    """Get system configuration"""
    return SystemConfigResponse(
        data={
            "certificateRequirements": {
                "contributionsRequired": config.cert_contributions_required,
                "validationsRequired": config.cert_validations_required,
                "certificateTitle": config.cert_title
            },
            "sessionLimits": {
                "contributionsPerSession": config.session_contributions_limit,
                "validationsPerSession": config.session_validations_limit
            },
            "timeouts": {
                "otpExpirySeconds": config.otp_expiry_seconds,
                "tokenExpirySeconds": config.token_expiry_seconds,
                "sessionTimeoutSeconds": config.session_timeout_seconds,
                "refreshTokenExpiryDays": config.refresh_token_expiry_days
            },
            "fileLimits": {
                "maxAudioSizeBytes": config.max_audio_size_bytes,
                "maxAudioDurationSeconds": config.max_audio_duration_seconds,
                "allowedAudioFormats": config.allowed_audio_formats
            },
            "validationRules": {
                "nameMinLength": config.name_min_length,
                "nameMaxLength": config.name_max_length,
                "mobileNumberPattern": config.mobile_number_pattern,
                "otpPattern": config.otp_pattern
            },
            "contactInfo": {
                "supportEmail": config.support_email,
                "supportPhone": config.support_phone,
                "website": config.website
            },
            "serverUrls": {
                "productionUrl": config.production_url,
                "developmentUrl": config.development_url,
                "stagingUrl": config.staging_url
            },
            "rateLimits": {
                "otpRequestsPerHour": config.otp_requests_per_hour,
                "apiRequestsPerMinute": config.api_requests_per_minute,
                "fileUploadsPerHour": config.file_uploads_per_hour
            },
            "features": {
                "enableVoiceContributions": config.enable_voice_contributions,
                "enableAudioValidation": config.enable_audio_validation,
                "enableCertificateGeneration": config.enable_certificate_generation,
                "enableMultiLanguage": config.enable_multi_language,
                "enableLocationServices": config.enable_location_services
            },
            "lastUpdated": datetime.utcnow().isoformat() + "Z",
            "version": "1.0.0"
        }
    )

# ==================== Contribution Endpoints ====================

@app.post("/contributions/get-sentences", response_model=GetSentencesResponse, tags=["Contribution"])
async def get_sentences(request: GetSentencesRequest):
    """Get sentences for recording"""
    try:
        log_api_call(logger, "/contributions/get-sentences", "POST")
        
        session_id = str(uuid.uuid4())
        sentences_data = data_config.get_sentences(request.languageCode, request.count)
        
        # Format sentences with sequence numbers
        sentences = []
        for i, sentence_data in enumerate(sentences_data, 1):
            # Skip sentences without text field
            if "text" not in sentence_data:
                continue
                
            sentences.append({
                "sentenceId": sentence_data["sentenceId"],
                "text": sentence_data["text"],
                "sequenceNumber": i,
                "metadata": {
                    "category": sentence_data.get("category", "agriculture"),
                    "difficulty": sentence_data.get("difficulty", "medium"),
                    "topic": sentence_data.get("topic", "general")
                }
            })
        
        return GetSentencesResponse(
            data={
                "sessionId": session_id,
                "languageCode": request.languageCode,
                "sentences": sentences,
                "totalCount": len(sentences)
            }
        )
    except Exception as e:
        log_error(logger, e, {"endpoint": "/contributions/get-sentences", "languageCode": request.languageCode})
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/contributions/record", response_model=RecordContributionResponse, tags=["Contribution"])
async def record_contribution(request: RecordContributionRequest):
    """Submit audio recording with language code, Base64 audio data, and duration"""
    try:
        log_api_call(logger, "/contributions/record", "POST")
        
        contribution_id = str(uuid.uuid4())
        
        # Validate Base64 audio data
        try:
            import base64
            # Decode to validate it's valid Base64
            audio_bytes = base64.b64decode(request.audioContent)
            file_size = len(audio_bytes)
        except Exception as e:
            raise HTTPException(status_code=400, detail="Invalid Base64 audio data")
        
        # Validate duration
        if request.duration <= 0:
            raise HTTPException(status_code=400, detail="Duration must be greater than 0")
        
        if request.duration > 60:  # 1 minute max
            raise HTTPException(status_code=400, detail="Duration cannot exceed 60 seconds")
        
        # Log the contribution
        log_contribution(logger, "record_contribution", "anonymous", request.languageCode, contribution_id)
        
        return RecordContributionResponse(
            data={
                "contributionId": contribution_id,
                "duration": request.duration,
                "languageCode": request.languageCode,
                "status": "pending",
                "sequenceNumber": request.sequenceNumber,
                "totalInSession": config.session_contributions_limit,
                "remainingInSession": config.session_contributions_limit - request.sequenceNumber,
                "progressPercentage": int((request.sequenceNumber / config.session_contributions_limit) * 100),
                "fileSize": file_size,
                "timestamp": datetime.now().isoformat() + "Z"
            }
        )
        
    except HTTPException:
        raise
    except Exception as e:
        log_error(logger, e, {
            "endpoint": "/contributions/record",
            "languageCode": request.languageCode,
            "duration": request.duration,
            "sessionId": request.sessionId
        })
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/contributions/skip", response_model=Dict[str, Any], tags=["Contribution"])
async def skip_sentence(request: SkipSentenceRequest):
    """Skip a sentence"""
    return {
        "success": True,
        "message": "Sentence skipped successfully",
        "data": {
            "skippedSentenceId": request.sentenceId,
            "reason": request.reason,
            "nextSentence": {
                "sentenceId": f"sent-next",
                "text": f"Next sentence in sequence",
                "sequenceNumber": 1
            }
        }
    }

@app.post("/contributions/report", response_model=Dict[str, Any], tags=["Contribution"])
async def report_sentence(request: ReportSentenceRequest):
    """Report issue with sentence"""
    return {
        "success": True,
        "message": "Report submitted. Thank you for your feedback."
    }

@app.post("/contributions/session-complete", response_model=Dict[str, Any], tags=["Contribution"])
async def complete_contribution_session(request: Dict[str, str]):
    """Complete contribution session"""
    return {
        "success": True,
        "message": "Session completed successfully",
        "data": {
            "sessionId": request.get("sessionId"),
            "totalContributions": config.session_contributions_limit,
            "userTotalContributions": 5,
            "certificateProgress": {
                "contributionsCompleted": config.session_contributions_limit,
                "contributionsRequired": config.cert_contributions_required,
                "validationsCompleted": 0,
                "validationsRequired": config.cert_validations_required,
                "isEligible": False,
                "percentageComplete": 17
            }
        }
    }

# ==================== Validation Endpoints ====================

@app.get("/validations/get-queue", response_model=GetValidationQueueResponse, tags=["Validation"])
async def get_validation_queue(languageCode: str, count: int = 25):
    """Get validation queue"""
    try:
        log_api_call(logger, "/validations/get-queue", "GET")
        
        session_id = str(uuid.uuid4())
        validation_data = data_config.get_validation_items(languageCode, count)
        
        # Format validation items with sequence numbers
        validation_items = []
        for i, item_data in enumerate(validation_data, 1):
            # Skip items without required fields
            if "text" not in item_data or "contributionId" not in item_data:
                continue
                
            validation_items.append({
                "contributionId": item_data["contributionId"],
                "sentenceId": item_data.get("sentenceId", f"sent-{i}"),
                "text": item_data["text"],
                "audioContent": item_data.get("audioContent", ""),
                "duration": item_data.get("duration", 0),
                "sequenceNumber": i
            })
        
        return GetValidationQueueResponse(
            data={
                "sessionId": session_id,
                "languageCode": languageCode,
                "validationItems": validation_items,
                "totalCount": len(validation_items)
            }
        )
    except Exception as e:
        log_error(logger, e, {"endpoint": "/validations/get-queue", "languageCode": languageCode})
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/validations/submit", response_model=SubmitValidationResponse, tags=["Validation"])
async def submit_validation(request: SubmitValidationRequest):
    """Submit validation decision"""
    validation_id = str(uuid.uuid4())
    
    return SubmitValidationResponse(
        data={
            "validationId": validation_id,
            "sequenceNumber": request.sequenceNumber,
            "totalInSession": config.session_validations_limit,
            "remainingInSession": config.session_validations_limit - request.sequenceNumber,
            "progressPercentage": int((request.sequenceNumber / config.session_validations_limit) * 100)
        }
    )

@app.post("/validations/session-complete", response_model=Dict[str, Any], tags=["Validation"])
async def complete_validation_session(request: ValidationSessionCompleteRequest):
    """Complete validation session"""
    return {
        "success": True,
        "message": "Validation session completed",
        "data": {
            "sessionId": request.sessionId,
            "totalValidations": config.session_validations_limit,
            "userTotalValidations": 25,
            "certificateProgress": {
                "contributionsCompleted": config.cert_contributions_required,
                "contributionsRequired": config.cert_contributions_required,
                "validationsCompleted": config.session_validations_limit,
                "validationsRequired": config.cert_validations_required,
                "isEligible": True,
                "certificateAvailable": True
            }
        }
    }

# ==================== Certificate Endpoints ====================

@app.get("/certificates/check-eligibility", response_model=CertificateEligibilityResponse, tags=["Certificate"])
async def check_certificate_eligibility():
    """Check certificate eligibility"""
    return CertificateEligibilityResponse(
        data={
            "isEligible": True,
            "contributionsCompleted": config.cert_contributions_required,
            "contributionsRequired": config.cert_contributions_required,
            "validationsCompleted": config.cert_validations_required,
            "validationsRequired": config.cert_validations_required,
            "certificateIssued": False,
            "certificateId": config.mock_certificate_id,
            "percentageComplete": 100
        }
    )

@app.post("/certificates/generate", response_model=GenerateCertificateResponse, tags=["Certificate"])
async def generate_certificate():
    """Generate certificate"""
    certificate_id = f"DIC-{datetime.now().strftime('%Y%m%d')}-{str(uuid.uuid4())[:4].upper()}"
    
    return GenerateCertificateResponse(
        data={
            "certificateId": certificate_id,
            "recipientName": "Animesh Patil",
            "badgeName": config.cert_title,
            "issuedDate": datetime.now().strftime("%Y-%m-%d"),
            "contributionsCount": config.cert_contributions_required,
            "validationsCount": config.cert_validations_required,
            "certificateUrl": f"https://storage.example.com/certificates/{certificate_id}.pdf",
            "thumbnailUrl": f"https://storage.example.com/certificates/{certificate_id}.png",
            "shareUrl": f"https://agridaan.gov.in/certificate/{certificate_id}"
        }
    )

@app.get("/certificates/{certificate_id}/download", tags=["Certificate"])
async def download_certificate(certificate_id: str):
    """Download certificate PDF"""
    return {"message": f"Certificate {certificate_id} PDF would be downloaded here"}

@app.get("/certificates/{certificate_id}/preview", tags=["Certificate"])
async def preview_certificate(certificate_id: str):
    """Preview certificate"""
    return {"message": f"Certificate {certificate_id} preview image would be returned here"}

@app.get("/certificates/{certificate_id}", response_model=Dict[str, Any], tags=["Certificate"])
async def get_certificate_details(certificate_id: str):
    """Get certificate details"""
    return {
        "success": True,
        "data": {
            "certificateId": certificate_id,
            "recipientName": "Animesh Patil",
            "badgeName": config.cert_title,
            "issuedDate": "2025-01-17",
            "contributionsCount": config.cert_contributions_required,
            "validationsCount": config.cert_validations_required,
            "certificateUrl": f"https://storage.example.com/certificates/{certificate_id}.pdf",
            "thumbnailUrl": f"https://storage.example.com/certificates/{certificate_id}.png"
        }
    }

# ==================== Root Endpoint ====================

@app.get("/", tags=["Root"])
async def root():
    """Root endpoint with API information"""
    return {
        "message": "AgriDaan API",
        "version": "1.0.0",
        "description": "Crowdsourcing platform for agricultural knowledge",
        "documentation": "/docs",
        "redoc": "/redoc",
        "openapi": "/openapi.json"
    }

# ==================== Storage Endpoints ====================

@app.get("/storage/stats", response_model=Dict[str, Any], tags=["Storage"])
async def get_storage_stats():
    """Get storage statistics"""
    try:
        log_api_call(logger, "/storage/stats", "GET")
        stats = storage_service.get_storage_stats()
        return {"message": "Storage stats retrieved successfully", "data": stats}
    except Exception as e:
        log_error(logger, e, {"endpoint": "/storage/stats"})
        raise HTTPException(status_code=500, detail="Failed to get storage stats")

@app.get("/storage/files/{file_type}", response_model=Dict[str, Any], tags=["Storage"])
async def list_files(file_type: str = "audio"):
    """List files by type"""
    try:
        log_api_call(logger, f"/storage/files/{file_type}", "GET")
        files = storage_service.list_files(file_type)
        return {
            "message": f"Files listed successfully",
            "data": {
                "file_type": file_type,
                "files": files,
                "count": len(files)
            }
        }
    except Exception as e:
        log_error(logger, e, {"endpoint": f"/storage/files/{file_type}"})
        raise HTTPException(status_code=500, detail="Failed to list files")

@app.get("/storage/files/{file_type}/{filename}", tags=["Storage"])
async def download_file(file_type: str, filename: str):
    """Download file"""
    try:
        log_api_call(logger, f"/storage/files/{file_type}/{filename}", "GET")
        file_content = storage_service.download_file(filename, file_type)
        
        if file_content is None:
            raise HTTPException(status_code=404, detail="File not found")
        
        # Get file info for headers
        file_info = storage_service.get_file_info(filename, file_type)
        mime_type = file_info.get("mime_type", "application/octet-stream") if file_info else "application/octet-stream"
        
        return Response(
            content=file_content,
            media_type=mime_type,
            headers={
                "Content-Disposition": f"attachment; filename={filename}",
                "Content-Length": str(len(file_content))
            }
        )
    except HTTPException:
        raise
    except Exception as e:
        log_error(logger, e, {"endpoint": f"/storage/files/{file_type}/{filename}"})
        raise HTTPException(status_code=500, detail="Failed to download file")

@app.delete("/storage/files/{file_type}/{filename}", response_model=Dict[str, Any], tags=["Storage"])
async def delete_file(file_type: str, filename: str):
    """Delete file"""
    try:
        log_api_call(logger, f"/storage/files/{file_type}/{filename}", "DELETE")
        success = storage_service.delete_file(filename, file_type)
        
        if not success:
            raise HTTPException(status_code=404, detail="File not found")
        
        return {"message": "File deleted successfully", "data": {"filename": filename, "file_type": file_type}}
    except HTTPException:
        raise
    except Exception as e:
        log_error(logger, e, {"endpoint": f"/storage/files/{file_type}/{filename}"})
        raise HTTPException(status_code=500, detail="Failed to delete file")

@app.post("/storage/cleanup", response_model=Dict[str, Any], tags=["Storage"])
async def cleanup_temp_files(max_age_hours: int = 24):
    """Clean up temporary files"""
    try:
        log_api_call(logger, "/storage/cleanup", "POST")
        deleted_count = storage_service.cleanup_temp_files(max_age_hours)
        
        return {
            "message": "Cleanup completed successfully",
            "data": {
                "deleted_count": deleted_count,
                "max_age_hours": max_age_hours
            }
        }
    except Exception as e:
        log_error(logger, e, {"endpoint": "/storage/cleanup"})
        raise HTTPException(status_code=500, detail="Failed to cleanup files")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=9000, reload=True)
