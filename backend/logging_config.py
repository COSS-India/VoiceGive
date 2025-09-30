"""
Enhanced logging configuration for AgriDaan FastAPI backend
Structured logging with JSON format for production monitoring
"""
import logging
import logging.config
import sys
from datetime import datetime
from typing import Dict, Any
import json
from pathlib import Path

class JSONFormatter(logging.Formatter):
    """Custom JSON formatter for structured logging"""
    
    def format(self, record: logging.LogRecord) -> str:
        log_entry = {
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "level": record.levelname,
            "logger": record.name,
            "message": record.getMessage(),
            "module": record.module,
            "function": record.funcName,
            "line": record.lineno,
            "thread": record.thread,
            "process": record.process
        }
        
        # Add exception info if present
        if record.exc_info:
            log_entry["exception"] = self.formatException(record.exc_info)
        
        # Add extra fields from record
        for key, value in record.__dict__.items():
            if key not in ['name', 'msg', 'args', 'levelname', 'levelno', 'pathname', 
                          'filename', 'module', 'lineno', 'funcName', 'created', 
                          'msecs', 'relativeCreated', 'thread', 'threadName', 
                          'processName', 'process', 'getMessage', 'exc_info', 
                          'exc_text', 'stack_info']:
                log_entry[key] = value
        
        return json.dumps(log_entry, ensure_ascii=False)

class RequestIDFilter(logging.Filter):
    """Filter to add request ID to log records"""
    
    def filter(self, record: logging.LogRecord) -> bool:
        # This would be populated by middleware
        record.request_id = getattr(record, 'request_id', 'no-request-id')
        return True

def setup_logging(environment: str = "development", log_level: str = "INFO") -> None:
    """Setup structured logging configuration"""
    
    # Create logs directory
    logs_dir = Path("logs")
    logs_dir.mkdir(exist_ok=True)
    
    # Determine log level
    numeric_level = getattr(logging, log_level.upper(), logging.INFO)
    
    # Configure logging
    logging_config = {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {
            "json": {
                "()": JSONFormatter,
            },
            "simple": {
                "format": "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
            },
            "detailed": {
                "format": "%(asctime)s - %(name)s - %(levelname)s - %(module)s - %(funcName)s - %(lineno)d - %(message)s"
            }
        },
        "filters": {
            "request_id": {
                "()": RequestIDFilter,
            }
        },
        "handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "level": log_level,
                "formatter": "simple" if environment == "development" else "json",
                "stream": sys.stdout,
                "filters": ["request_id"]
            },
            "file": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "INFO",
                "formatter": "json",
                "filename": "logs/agridaan.log",
                "maxBytes": 10485760,  # 10MB
                "backupCount": 5,
                "filters": ["request_id"]
            },
            "error_file": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "ERROR",
                "formatter": "json",
                "filename": "logs/agridaan_errors.log",
                "maxBytes": 10485760,  # 10MB
                "backupCount": 5,
                "filters": ["request_id"]
            },
            "access_file": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "INFO",
                "formatter": "json",
                "filename": "logs/agridaan_access.log",
                "maxBytes": 10485760,  # 10MB
                "backupCount": 5,
                "filters": ["request_id"]
            }
        },
        "loggers": {
            "agridaan": {
                "level": log_level,
                "handlers": ["console", "file", "error_file"],
                "propagate": False
            },
            "agridaan.access": {
                "level": "INFO",
                "handlers": ["access_file"],
                "propagate": False
            },
            "agridaan.auth": {
                "level": "INFO",
                "handlers": ["console", "file"],
                "propagate": False
            },
            "agridaan.contributions": {
                "level": "INFO",
                "handlers": ["console", "file"],
                "propagate": False
            },
            "agridaan.validations": {
                "level": "INFO",
                "handlers": ["console", "file"],
                "propagate": False
            },
            "agridaan.certificates": {
                "level": "INFO",
                "handlers": ["console", "file"],
                "propagate": False
            },
            "agridaan.data": {
                "level": "INFO",
                "handlers": ["console", "file"],
                "propagate": False
            },
            "uvicorn": {
                "level": "INFO",
                "handlers": ["console", "file"],
                "propagate": False
            },
            "uvicorn.access": {
                "level": "INFO",
                "handlers": ["access_file"],
                "propagate": False
            }
        },
        "root": {
            "level": log_level,
            "handlers": ["console", "file"]
        }
    }
    
    logging.config.dictConfig(logging_config)

def get_logger(name: str) -> logging.Logger:
    """Get a logger instance with the specified name"""
    return logging.getLogger(f"agridaan.{name}")

# Logging decorators
def log_function_call(logger: logging.Logger):
    """Decorator to log function calls"""
    def decorator(func):
        def wrapper(*args, **kwargs):
            logger.info(f"Calling {func.__name__}", extra={
                "function": func.__name__,
                "args": str(args)[:200],  # Limit args length
                "kwargs": str(kwargs)[:200]
            })
            try:
                result = func(*args, **kwargs)
                logger.info(f"Successfully completed {func.__name__}", extra={
                    "function": func.__name__,
                    "result_type": type(result).__name__
                })
                return result
            except Exception as e:
                logger.error(f"Error in {func.__name__}: {str(e)}", extra={
                    "function": func.__name__,
                    "error": str(e),
                    "error_type": type(e).__name__
                })
                raise
        return wrapper
    return decorator

def log_api_call(logger: logging.Logger, endpoint: str, method: str, user_id: str = None):
    """Log API call details"""
    logger.info(f"API Call: {method} {endpoint}", extra={
        "endpoint": endpoint,
        "method": method,
        "user_id": user_id,
        "api_call": True
    })

def log_authentication(logger: logging.Logger, action: str, user_id: str = None, mobile: str = None):
    """Log authentication events"""
    logger.info(f"Authentication: {action}", extra={
        "auth_action": action,
        "user_id": user_id,
        "mobile": mobile,
        "authentication": True
    })

def log_contribution(logger: logging.Logger, action: str, user_id: str, language: str, contribution_id: str = None):
    """Log contribution events"""
    logger.info(f"Contribution: {action}", extra={
        "contribution_action": action,
        "user_id": user_id,
        "language": language,
        "contribution_id": contribution_id,
        "contribution": True
    })

def log_validation(logger: logging.Logger, action: str, user_id: str, language: str, validation_id: str = None):
    """Log validation events"""
    logger.info(f"Validation: {action}", extra={
        "validation_action": action,
        "user_id": user_id,
        "language": language,
        "validation_id": validation_id,
        "validation": True
    })

def log_certificate(logger: logging.Logger, action: str, user_id: str, certificate_id: str = None):
    """Log certificate events"""
    logger.info(f"Certificate: {action}", extra={
        "certificate_action": action,
        "user_id": user_id,
        "certificate_id": certificate_id,
        "certificate": True
    })

def log_data_management(logger: logging.Logger, action: str, data_type: str, details: Dict[str, Any] = None):
    """Log data management events"""
    logger.info(f"Data Management: {action}", extra={
        "data_action": action,
        "data_type": data_type,
        "details": details or {},
        "data_management": True
    })

def log_error(logger: logging.Logger, error: Exception, context: Dict[str, Any] = None):
    """Log errors with context"""
    logger.error(f"Error occurred: {str(error)}", extra={
        "error": str(error),
        "error_type": type(error).__name__,
        "context": context or {},
        "error_log": True
    }, exc_info=True)

def log_performance(logger: logging.Logger, operation: str, duration: float, details: Dict[str, Any] = None):
    """Log performance metrics"""
    logger.info(f"Performance: {operation} took {duration:.3f}s", extra={
        "operation": operation,
        "duration": duration,
        "details": details or {},
        "performance": True
    })
