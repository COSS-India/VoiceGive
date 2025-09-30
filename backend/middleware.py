"""
Custom middleware for AgriDaan FastAPI backend
Request/response logging, CORS, and performance monitoring
"""
import time
import uuid
from fastapi import Request, Response
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.middleware.cors import CORSMiddleware
from typing import Callable
from logging_config import get_logger
import json

logger = get_logger("middleware")

class RequestLoggingMiddleware(BaseHTTPMiddleware):
    """Middleware for logging requests and responses"""
    
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        # Generate request ID
        request_id = str(uuid.uuid4())
        request.state.request_id = request_id
        
        # Log request
        start_time = time.time()
        
        # Extract request details
        client_ip = request.client.host if request.client else "unknown"
        user_agent = request.headers.get("user-agent", "unknown")
        
        logger.info(f"Request started: {request.method} {request.url.path}", extra={
            "request_id": request_id,
            "method": request.method,
            "path": request.url.path,
            "query_params": str(request.query_params),
            "client_ip": client_ip,
            "user_agent": user_agent,
            "headers": dict(request.headers),
            "request_start": True
        })
        
        # Process request
        try:
            response = await call_next(request)
            
            # Calculate duration
            duration = time.time() - start_time
            
            # Log response
            logger.info(f"Request completed: {request.method} {request.url.path}", extra={
                "request_id": request_id,
                "method": request.method,
                "path": request.url.path,
                "status_code": response.status_code,
                "duration": duration,
                "response_headers": dict(response.headers),
                "request_completed": True
            })
            
            # Add request ID to response headers
            response.headers["X-Request-ID"] = request_id
            
            return response
            
        except Exception as e:
            # Calculate duration
            duration = time.time() - start_time
            
            # Log error
            logger.error(f"Request failed: {request.method} {request.url.path}", extra={
                "request_id": request_id,
                "method": request.method,
                "path": request.url.path,
                "duration": duration,
                "error": str(e),
                "error_type": type(e).__name__,
                "request_failed": True
            }, exc_info=True)
            
            raise

class PerformanceMiddleware(BaseHTTPMiddleware):
    """Middleware for performance monitoring"""
    
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        start_time = time.time()
        
        response = await call_next(request)
        
        duration = time.time() - start_time
        
        # Log performance metrics
        if duration > 1.0:  # Log slow requests
            logger.warning(f"Slow request detected: {request.method} {request.url.path}", extra={
                "method": request.method,
                "path": request.url.path,
                "duration": duration,
                "status_code": response.status_code,
                "slow_request": True
            })
        
        # Add performance headers
        response.headers["X-Response-Time"] = str(duration)
        
        return response

class SecurityMiddleware(BaseHTTPMiddleware):
    """Middleware for security headers"""
    
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        response = await call_next(request)
        
        # Add security headers
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["X-XSS-Protection"] = "1; mode=block"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        
        return response

class DatabaseMiddleware(BaseHTTPMiddleware):
    """Middleware for database connection management"""
    
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        # This would handle database connection pooling in production
        # For now, it's a placeholder for future database optimizations
        
        response = await call_next(request)
        
        return response

def setup_middleware(app):
    """Setup all middleware for the FastAPI app"""
    
    # Add request logging middleware
    app.add_middleware(RequestLoggingMiddleware)
    
    # Add performance monitoring middleware
    app.add_middleware(PerformanceMiddleware)
    
    # Add security middleware
    app.add_middleware(SecurityMiddleware)
    
    # Add database middleware
    app.add_middleware(DatabaseMiddleware)
    
    # Add CORS middleware
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],  # Configure this properly in production
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    
    logger.info("All middleware configured successfully")
