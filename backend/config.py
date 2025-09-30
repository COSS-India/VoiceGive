"""
Configuration system for AgriDaan FastAPI backend
All hardcoded values are now configurable through environment variables
"""
from pydantic_settings import BaseSettings
from pydantic import Field
from typing import List
import os

class SystemConfig(BaseSettings):
    """System configuration with environment variable support"""
    
    # API Configuration
    api_title: str = Field(default="Language Data Collection API", env="API_TITLE")
    api_version: str = Field(default="1.0.0", env="API_VERSION")
    api_description: str = Field(default="FastAPI Backend for Language Data Collection", env="API_DESCRIPTION")
    
    # Contact Information
    contact_name: str = Field(default="API Support", env="CONTACT_NAME")
    contact_email: str = Field(default="support@example.com", env="CONTACT_EMAIL")
    license_name: str = Field(default="Open Source", env="LICENSE_NAME")
    
    # Server URLs
    production_server_url: str = Field(default="https://api.example.com/v1", env="PRODUCTION_SERVER_URL")
    development_server_url: str = Field(default="http://localhost:9000", env="DEVELOPMENT_SERVER_URL")
    
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
    allowed_audio_formats: str = Field(default="mp3,wav,m4a,aac", env="ALLOWED_AUDIO_FORMATS")
    
    # Validation Rules
    name_min_length: int = Field(default=2, env="NAME_MIN_LENGTH")
    name_max_length: int = Field(default=50, env="NAME_MAX_LENGTH")
    mobile_number_pattern: str = Field(default="^[6-9]\\d{9}$", env="MOBILE_NUMBER_PATTERN")
    otp_pattern: str = Field(default="^\\d{6}$", env="OTP_PATTERN")
    
    # Contact Info
    support_email: str = Field(default="support-bhashadaan.dibd@gmail.com", env="SUPPORT_EMAIL")
    support_phone: str = Field(default="+91-11-12345678", env="SUPPORT_PHONE")
    website: str = Field(default="https://agridaan.gov.in", env="WEBSITE")
    
    # Mock Data Configuration
    mock_otp: str = Field(default="123456", env="MOCK_OTP")
    mock_mobile: str = Field(default="9177454678", env="MOCK_MOBILE")
    mock_email: str = Field(default="ragani.dibd@gmail.com", env="MOCK_EMAIL")
    mock_first_name: str = Field(default="Ragani", env="MOCK_FIRST_NAME")
    mock_last_name: str = Field(default="Shukla", env="MOCK_LAST_NAME")
    mock_state: str = Field(default="Maharashtra", env="MOCK_STATE")
    mock_district: str = Field(default="Amravati", env="MOCK_DISTRICT")
    mock_language: str = Field(default="Marathi", env="MOCK_LANGUAGE")
    mock_certificate_id: str = Field(default="DIC-20250917-0123", env="MOCK_CERTIFICATE_ID")
    
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
    
    # JWT Configuration
    jwt_secret_key: str = Field(default="your-super-secret-jwt-key-here", env="JWT_SECRET_KEY")
    jwt_algorithm: str = Field(default="HS256", env="JWT_ALGORITHM")
    jwt_access_token_expire_minutes: int = Field(default=1440, env="JWT_ACCESS_TOKEN_EXPIRE_MINUTES")
    jwt_refresh_token_expire_days: int = Field(default=30, env="JWT_REFRESH_TOKEN_EXPIRE_DAYS")
    
    # Database
    database_url: str = Field(default="sqlite:///./agridaan.db", env="DATABASE_URL")
    redis_url: str = Field(default="redis://localhost:6379", env="REDIS_URL")
    
    # Storage Configuration (Local Only)
    storage_provider: str = Field(default="local", env="STORAGE_PROVIDER")
    storage_path: str = Field(default="./uploads", env="STORAGE_PATH")
    max_storage_size_gb: int = Field(default=10, env="MAX_STORAGE_SIZE_GB")
    
    # SMS Configuration
    sms_provider: str = Field(default="mock", env="SMS_PROVIDER")
    sms_api_key: str = Field(default="", env="SMS_API_KEY")
    sms_api_secret: str = Field(default="", env="SMS_API_SECRET")
    sms_from_number: str = Field(default="+1234567890", env="SMS_FROM_NUMBER")
    
    def get_allowed_audio_formats(self) -> List[str]:
        """Get allowed audio formats as a list"""
        return [fmt.strip() for fmt in self.allowed_audio_formats.split(",")]
    
    model_config = {
        "env_file": ".env",
        "case_sensitive": False,
        "extra": "ignore"  # Ignore extra environment variables
    }

# Global config instance
config = SystemConfig()
