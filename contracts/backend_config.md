# AgriDaan Backend Configuration Guide

## 🚀 FastAPI Backend Implementation - Configuration System

This document provides the complete configuration system for your FastAPI backend implementation. All hardcoded values have been made configurable through environment variables and a dynamic configuration endpoint.

---

## 📋 Environment Variables

Create a `.env` file with the following configuration:

```bash
# ==================== Certificate Requirements ====================
CERT_CONTRIBUTIONS_REQUIRED=5
CERT_VALIDATIONS_REQUIRED=25
CERT_TITLE="Agri Bhasha Samarthak"

# ==================== Session Limits ====================
SESSION_CONTRIBUTIONS_LIMIT=5
SESSION_VALIDATIONS_LIMIT=25

# ==================== Timeouts (in seconds) ====================
OTP_EXPIRY_SECONDS=300
TOKEN_EXPIRY_SECONDS=86400
SESSION_TIMEOUT_SECONDS=1800
REFRESH_TOKEN_EXPIRY_DAYS=30

# ==================== File Limits ====================
MAX_AUDIO_SIZE_BYTES=10485760
MAX_AUDIO_DURATION_SECONDS=300
ALLOWED_AUDIO_FORMATS="mp3,wav,m4a,aac"

# ==================== Validation Rules ====================
NAME_MIN_LENGTH=2
NAME_MAX_LENGTH=50
MOBILE_NUMBER_PATTERN="^[6-9]\\d{9}$"
OTP_PATTERN="^\\d{6}$"

# ==================== Contact Information ====================
SUPPORT_EMAIL="support-bhashadaan.dibd@gmail.com"
SUPPORT_PHONE="+91-11-12345678"
WEBSITE="https://agridaan.gov.in"

# ==================== Server URLs ====================
PRODUCTION_URL="https://api.agridaan.gov.in/v1"
DEVELOPMENT_URL="https://dev-api.agridaan.gov.in/v1"
STAGING_URL="https://staging-api.agridaan.gov.in/v1"

# ==================== Rate Limiting ====================
OTP_REQUESTS_PER_HOUR=5
API_REQUESTS_PER_MINUTE=60
FILE_UPLOADS_PER_HOUR=20

# ==================== Feature Flags ====================
ENABLE_VOICE_CONTRIBUTIONS=true
ENABLE_AUDIO_VALIDATION=true
ENABLE_CERTIFICATE_GENERATION=true
ENABLE_MULTI_LANGUAGE=true
ENABLE_LOCATION_SERVICES=true

# ==================== Database Configuration ====================
DATABASE_URL="postgresql://user:password@localhost:5432/agridaan"
REDIS_URL="redis://localhost:6379"
STORAGE_BUCKET="agridaan-audio-files"

# ==================== JWT Configuration ====================
JWT_SECRET_KEY="your-super-secret-jwt-key-here"
JWT_ALGORITHM="HS256"
JWT_ACCESS_TOKEN_EXPIRE_MINUTES=1440
JWT_REFRESH_TOKEN_EXPIRE_DAYS=30

# ==================== SMS/OTP Configuration ====================
SMS_PROVIDER="twilio"  # or "aws-sns", "msg91"
SMS_API_KEY="your-sms-api-key"
SMS_API_SECRET="your-sms-api-secret"
SMS_FROM_NUMBER="+1234567890"

# ==================== File Storage ====================
STORAGE_PROVIDER="aws-s3"  # or "local", "gcp-storage"
AWS_ACCESS_KEY_ID="your-aws-access-key"
AWS_SECRET_ACCESS_KEY="your-aws-secret-key"
AWS_REGION="us-east-1"
AWS_S3_BUCKET="agridaan-audio-files"

# ==================== Environment ====================
ENVIRONMENT="development"  # development, staging, production
DEBUG=true
LOG_LEVEL="INFO"
```

---

## 🔧 FastAPI Configuration Implementation

### 1. Configuration Model (Pydantic)

```python
# config.py
from pydantic import BaseSettings, Field
from typing import List, Optional
import os

class SystemConfig(BaseSettings):
    # Certificate Requirements
    cert_contributions_required: int = Field(default=5, env="CERT_CONTRIBUTIONS_REQUIRED")
    cert_validations_required: int = Field(default=25, env="CERT_VALIDATIONS_REQUIRED")
    cert_title: str = Field(default="Agri Bhasha Samarthak", env="CERT_TITLE")
    
    # Session Limits
    session_contributions_limit: int = Field(default=5, env="SESSION_CONTRIBUTIONS_LIMIT")
    session_validations_limit: int = Field(default=25, env="SESSION_VALIDATIONS_LIMIT")
    
    # Timeouts
    otp_expiry_seconds: int = Field(default=300, env="OTP_EXPIRY_SECONDS")
    token_expiry_seconds: int = Field(default=86400, env="TOKEN_EXPIRY_SECONDS")
    session_timeout_seconds: int = Field(default=1800, env="SESSION_TIMEOUT_SECONDS")
    refresh_token_expiry_days: int = Field(default=30, env="REFRESH_TOKEN_EXPIRY_DAYS")
    
    # File Limits
    max_audio_size_bytes: int = Field(default=10485760, env="MAX_AUDIO_SIZE_BYTES")
    max_audio_duration_seconds: int = Field(default=300, env="MAX_AUDIO_DURATION_SECONDS")
    allowed_audio_formats: List[str] = Field(default=["mp3", "wav", "m4a", "aac"], env="ALLOWED_AUDIO_FORMATS")
    
    # Validation Rules
    name_min_length: int = Field(default=2, env="NAME_MIN_LENGTH")
    name_max_length: int = Field(default=50, env="NAME_MAX_LENGTH")
    mobile_number_pattern: str = Field(default="^[6-9]\\d{9}$", env="MOBILE_NUMBER_PATTERN")
    otp_pattern: str = Field(default="^\\d{6}$", env="OTP_PATTERN")
    
    # Contact Info
    support_email: str = Field(default="support-bhashadaan.dibd@gmail.com", env="SUPPORT_EMAIL")
    support_phone: str = Field(default="+91-11-12345678", env="SUPPORT_PHONE")
    website: str = Field(default="https://agridaan.gov.in", env="WEBSITE")
    
    # Server URLs
    production_url: str = Field(default="https://api.agridaan.gov.in/v1", env="PRODUCTION_URL")
    development_url: str = Field(default="https://dev-api.agridaan.gov.in/v1", env="DEVELOPMENT_URL")
    staging_url: str = Field(default="https://staging-api.agridaan.gov.in/v1", env="STAGING_URL")
    
    # Rate Limiting
    otp_requests_per_hour: int = Field(default=5, env="OTP_REQUESTS_PER_HOUR")
    api_requests_per_minute: int = Field(default=60, env="API_REQUESTS_PER_MINUTE")
    file_uploads_per_hour: int = Field(default=20, env="FILE_UPLOADS_PER_HOUR")
    
    # Feature Flags
    enable_voice_contributions: bool = Field(default=True, env="ENABLE_VOICE_CONTRIBUTIONS")
    enable_audio_validation: bool = Field(default=True, env="ENABLE_AUDIO_VALIDATION")
    enable_certificate_generation: bool = Field(default=True, env="ENABLE_CERTIFICATE_GENERATION")
    enable_multi_language: bool = Field(default=True, env="ENABLE_MULTI_LANGUAGE")
    enable_location_services: bool = Field(default=True, env="ENABLE_LOCATION_SERVICES")
    
    # Environment
    environment: str = Field(default="development", env="ENVIRONMENT")
    debug: bool = Field(default=True, env="DEBUG")
    log_level: str = Field(default="INFO", env="LOG_LEVEL")
    
    class Config:
        env_file = ".env"
        case_sensitive = False

# Global config instance
config = SystemConfig()
```

### 2. Configuration Endpoint

```python
# main.py or routers/system.py
from fastapi import APIRouter
from config import config
from datetime import datetime

router = APIRouter(prefix="/system", tags=["System"])

@router.get("/config")
async def get_system_config():
    """Get current system configuration"""
    return {
        "success": True,
        "data": {
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
    }
```

### 3. Usage in Business Logic

```python
# services/certificate_service.py
from config import config

class CertificateService:
    def check_eligibility(self, user_contributions: int, user_validations: int) -> bool:
        return (user_contributions >= config.cert_contributions_required and 
                user_validations >= config.cert_validations_required)
    
    def get_certificate_title(self) -> str:
        return config.cert_title

# services/contribution_service.py
from config import config

class ContributionService:
    def get_sentences_count(self) -> int:
        return config.session_contributions_limit
    
    def validate_audio_file(self, file_size: int, duration: float) -> bool:
        return (file_size <= config.max_audio_size_bytes and 
                duration <= config.max_audio_duration_seconds)

# services/validation_service.py
from config import config

class ValidationService:
    def get_validations_count(self) -> int:
        return config.session_validations_limit
```

---

## 🎯 Benefits for FastAPI Development

### 1. **Zero Hardcoded Values** ✅
- All business rules are configurable
- Easy to adjust for different environments
- No code changes needed for parameter updates

### 2. **Environment-Specific Configuration** ✅
- Development: Relaxed limits for testing
- Staging: Production-like settings
- Production: Optimized for performance

### 3. **Feature Flags** ✅
- Enable/disable features without deployment
- A/B testing capabilities
- Gradual feature rollouts

### 4. **Rate Limiting** ✅
- Configurable API limits
- OTP request throttling
- File upload restrictions

### 5. **Easy Testing** ✅
- Mock different configurations
- Test edge cases easily
- Environment-specific test data

---

## 🚀 Quick Start for FastAPI

1. **Copy the configuration model** to your FastAPI project
2. **Create `.env` file** with your values
3. **Import config** in your services: `from config import config`
4. **Use config values** instead of hardcoded numbers
5. **Test the `/system/config` endpoint** to verify configuration

This configuration system will save you significant development time and make your FastAPI backend highly maintainable and flexible! 🎉
