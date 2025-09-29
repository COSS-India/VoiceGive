"""
Database configuration and models for AgriDaan FastAPI backend
SQLAlchemy models with proper relationships and constraints
"""
from sqlalchemy import create_engine, Column, Integer, String, Boolean, DateTime, Text, Float, ForeignKey, Enum as SQLEnum
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, Session
from sqlalchemy.sql import func
from datetime import datetime
from enum import Enum
import uuid
from typing import Optional, List
import os

# Database configuration
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./agridaan.db")
engine = create_engine(DATABASE_URL, echo=False)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Enums
class UserGender(str, Enum):
    MALE = "Male"
    FEMALE = "Female"
    OTHER = "Other"
    PREFER_NOT_SAY = "Prefer not to say"

class UserAgeGroup(str, Enum):
    UNDER_18 = "Under 18"
    AGE_18_25 = "18-25 years"
    AGE_26_30 = "26-30 years"
    AGE_31_40 = "31-40 years"
    AGE_41_50 = "41-50 years"
    AGE_51_60 = "51-60 years"
    ABOVE_60 = "Above 60"

class ContributionStatus(str, Enum):
    PENDING = "pending"
    ACCEPTED = "accepted"
    REJECTED = "rejected"
    UNDER_REVIEW = "under_review"

class ValidationDecision(str, Enum):
    CORRECT = "correct"
    INCORRECT = "incorrect"

class CertificateStatus(str, Enum):
    ELIGIBLE = "eligible"
    ISSUED = "issued"
    DOWNLOADED = "downloaded"

# Database Models
class User(Base):
    __tablename__ = "users"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    mobile_no = Column(String(15), unique=True, nullable=False, index=True)
    country_code = Column(String(5), default="+91")
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    email = Column(String(100), nullable=True)
    age_group = Column(SQLEnum(UserAgeGroup), nullable=False)
    gender = Column(SQLEnum(UserGender), nullable=False)
    country = Column(String(50), nullable=False)
    state = Column(String(50), nullable=False)
    district = Column(String(50), nullable=False)
    preferred_language = Column(String(50), nullable=False)
    
    # Consent tracking
    consent_given = Column(Boolean, default=False)
    consent_timestamp = Column(DateTime, nullable=True)
    terms_accepted = Column(Boolean, default=False)
    privacy_accepted = Column(Boolean, default=False)
    copyright_accepted = Column(Boolean, default=False)
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())
    last_login = Column(DateTime, nullable=True)
    
    # Relationships
    contributions = relationship("Contribution", back_populates="user")
    validations = relationship("Validation", back_populates="user")
    certificates = relationship("Certificate", back_populates="user")
    sessions = relationship("UserSession", back_populates="user")

class UserSession(Base):
    __tablename__ = "user_sessions"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id = Column(String(36), ForeignKey("users.id"), nullable=True)
    session_id = Column(String(100), unique=True, nullable=False, index=True)
    mobile_no = Column(String(15), nullable=False)
    otp_code = Column(String(6), nullable=True)
    otp_expires_at = Column(DateTime, nullable=True)
    is_verified = Column(Boolean, default=False)
    access_token = Column(Text, nullable=True)
    refresh_token = Column(Text, nullable=True)
    token_expires_at = Column(DateTime, nullable=True)
    ip_address = Column(String(45), nullable=True)
    user_agent = Column(Text, nullable=True)
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())
    expires_at = Column(DateTime, nullable=True)
    last_activity = Column(DateTime, default=func.now())
    
    # Relationships
    user = relationship("User", back_populates="sessions")

class Contribution(Base):
    __tablename__ = "contributions"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id = Column(String(36), ForeignKey("users.id"), nullable=False)
    session_id = Column(String(100), nullable=False)
    sentence_id = Column(String(100), nullable=False)
    language = Column(String(50), nullable=False)
    text = Column(Text, nullable=False)
    audio_url = Column(String(500), nullable=False)
    audio_duration = Column(Float, nullable=False)
    file_size = Column(Integer, nullable=False)
    file_format = Column(String(10), nullable=False)
    sequence_number = Column(Integer, nullable=False)
    
    # Status and quality
    status = Column(SQLEnum(ContributionStatus), default=ContributionStatus.PENDING)
    quality_score = Column(Float, nullable=True)
    background_noise_level = Column(Float, nullable=True)
    volume_level = Column(Float, nullable=True)
    
    # Metadata
    device_info = Column(Text, nullable=True)
    browser_info = Column(Text, nullable=True)
    location_info = Column(Text, nullable=True)
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())
    reviewed_at = Column(DateTime, nullable=True)
    
    # Relationships
    user = relationship("User", back_populates="contributions")
    validations = relationship("Validation", back_populates="contribution")

class Validation(Base):
    __tablename__ = "validations"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id = Column(String(36), ForeignKey("users.id"), nullable=False)
    contribution_id = Column(String(36), ForeignKey("contributions.id"), nullable=False)
    session_id = Column(String(100), nullable=False)
    language = Column(String(50), nullable=False)
    decision = Column(SQLEnum(ValidationDecision), nullable=False)
    feedback = Column(Text, nullable=True)
    sequence_number = Column(Integer, nullable=False)
    
    # Validation details
    confidence_score = Column(Float, nullable=True)
    time_spent = Column(Float, nullable=True)  # Time spent on validation
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())
    
    # Relationships
    user = relationship("User", back_populates="validations")
    contribution = relationship("Contribution", back_populates="validations")

class Certificate(Base):
    __tablename__ = "certificates"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id = Column(String(36), ForeignKey("users.id"), nullable=False)
    certificate_id = Column(String(100), unique=True, nullable=False, index=True)
    status = Column(SQLEnum(CertificateStatus), default=CertificateStatus.ELIGIBLE)
    
    # Certificate details
    recipient_name = Column(String(100), nullable=False)
    badge_name = Column(String(100), nullable=False)
    contributions_count = Column(Integer, nullable=False)
    validations_count = Column(Integer, nullable=False)
    
    # File URLs
    certificate_url = Column(String(500), nullable=True)
    thumbnail_url = Column(String(500), nullable=True)
    share_url = Column(String(500), nullable=True)
    
    # Timestamps
    issued_date = Column(DateTime, default=func.now())
    downloaded_at = Column(DateTime, nullable=True)
    created_at = Column(DateTime, default=func.now())
    
    # Relationships
    user = relationship("User", back_populates="certificates")

class Sentence(Base):
    __tablename__ = "sentences"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    sentence_id = Column(String(100), unique=True, nullable=False, index=True)
    language = Column(String(50), nullable=False, index=True)
    text = Column(Text, nullable=False)
    category = Column(String(50), nullable=True)
    difficulty = Column(String(20), nullable=True)
    topic = Column(String(50), nullable=True)
    is_active = Column(Boolean, default=True)
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

class LocationData(Base):
    __tablename__ = "location_data"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    type = Column(String(20), nullable=False)  # country, state, district
    parent_id = Column(String(10), nullable=True)  # For states (country_id), districts (state_id)
    code = Column(String(10), nullable=False, index=True)
    name = Column(String(100), nullable=False)
    is_active = Column(Boolean, default=True)
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

class SystemLog(Base):
    __tablename__ = "system_logs"
    
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    level = Column(String(20), nullable=False)
    logger_name = Column(String(100), nullable=False)
    message = Column(Text, nullable=False)
    module = Column(String(100), nullable=True)
    function = Column(String(100), nullable=True)
    line_number = Column(Integer, nullable=True)
    user_id = Column(String(36), nullable=True)
    request_id = Column(String(100), nullable=True)
    endpoint = Column(String(200), nullable=True)
    method = Column(String(10), nullable=True)
    status_code = Column(Integer, nullable=True)
    duration = Column(Float, nullable=True)
    ip_address = Column(String(45), nullable=True)
    user_agent = Column(Text, nullable=True)
    extra_data = Column(Text, nullable=True)  # JSON string
    
    # Timestamps
    created_at = Column(DateTime, default=func.now())

# Database utility functions
def get_db() -> Session:
    """Get database session"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def create_tables():
    """Create all database tables"""
    Base.metadata.create_all(bind=engine)

def drop_tables():
    """Drop all database tables"""
    Base.metadata.drop_all(bind=engine)

def get_user_by_mobile(db: Session, mobile_no: str) -> Optional[User]:
    """Get user by mobile number"""
    return db.query(User).filter(User.mobile_no == mobile_no).first()

def get_user_by_id(db: Session, user_id: str) -> Optional[User]:
    """Get user by ID"""
    return db.query(User).filter(User.id == user_id).first()

def get_session_by_id(db: Session, session_id: str) -> Optional[UserSession]:
    """Get session by ID"""
    return db.query(UserSession).filter(UserSession.session_id == session_id).first()

def get_user_contributions(db: Session, user_id: str) -> List[Contribution]:
    """Get user contributions"""
    return db.query(Contribution).filter(Contribution.user_id == user_id).all()

def get_user_validations(db: Session, user_id: str) -> List[Validation]:
    """Get user validations"""
    return db.query(Validation).filter(Validation.user_id == user_id).all()

def get_user_certificate(db: Session, user_id: str) -> Optional[Certificate]:
    """Get user certificate"""
    return db.query(Certificate).filter(Certificate.user_id == user_id).first()

def get_sentences_by_language(db: Session, language: str, limit: int = 5) -> List[Sentence]:
    """Get sentences by language"""
    return db.query(Sentence).filter(
        Sentence.language == language,
        Sentence.is_active == True
    ).limit(limit).all()

def get_validation_queue(db: Session, language: str, limit: int = 25) -> List[Contribution]:
    """Get validation queue"""
    return db.query(Contribution).filter(
        Contribution.language == language,
        Contribution.status == ContributionStatus.ACCEPTED
    ).limit(limit).all()

def get_countries(db: Session) -> List[LocationData]:
    """Get all countries"""
    return db.query(LocationData).filter(LocationData.type == "country").all()

def get_states_by_country(db: Session, country_code: str) -> List[LocationData]:
    """Get states by country"""
    return db.query(LocationData).filter(
        LocationData.type == "state",
        LocationData.parent_id == country_code
    ).all()

def get_districts_by_state(db: Session, state_code: str) -> List[LocationData]:
    """Get districts by state"""
    return db.query(LocationData).filter(
        LocationData.type == "district",
        LocationData.parent_id == state_code
    ).all()

# Database initialization
def init_database():
    """Initialize database with default data"""
    create_tables()
    
    # Add default location data
    db = SessionLocal()
    try:
        # Check if data already exists
        if db.query(LocationData).count() == 0:
            # Add countries
            countries = [
                LocationData(type="country", code="IN", name="India"),
                LocationData(type="country", code="US", name="United States"),
                LocationData(type="country", code="GB", name="United Kingdom")
            ]
            db.add_all(countries)
            
            # Add states for India (configurable)
            indian_states = [
                LocationData(type="state", parent_id="IN", code="MH", name="Maharashtra"),
                LocationData(type="state", parent_id="IN", code="KA", name="Karnataka"),
                LocationData(type="state", parent_id="IN", code="TN", name="Tamil Nadu"),
                LocationData(type="state", parent_id="IN", code="UP", name="Uttar Pradesh")
            ]
            db.add_all(indian_states)
            
            # Add districts for Maharashtra (configurable)
            maharashtra_districts = [
                LocationData(type="district", parent_id="MH", code="MH-AMR", name="Amravati"),
                LocationData(type="district", parent_id="MH", code="MH-MUM", name="Mumbai"),
                LocationData(type="district", parent_id="MH", code="MH-PUN", name="Pune"),
                LocationData(type="district", parent_id="MH", code="MH-NAG", name="Nagpur")
            ]
            db.add_all(maharashtra_districts)
            
            # Add sample sentences (configurable through data files)
            sentences = [
                Sentence(
                    sentence_id="mr-001",
                    language="Marathi",
                    text="तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
                    category="agriculture",
                    difficulty="medium",
                    topic="farming_techniques"
                ),
                Sentence(
                    sentence_id="hi-001",
                    language="Hindi",
                    text="किसानों को नई तकनीक की जानकारी देना हमारा उद्देश्य है।",
                    category="agriculture",
                    difficulty="medium",
                    topic="technology"
                )
            ]
            db.add_all(sentences)
            
            db.commit()
            print("Database initialized with default data")
    except Exception as e:
        db.rollback()
        print(f"Error initializing database: {e}")
    finally:
        db.close()
