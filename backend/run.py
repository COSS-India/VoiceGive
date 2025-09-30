#!/usr/bin/env python3
"""
Quick start script for AgriDaan FastAPI backend
Run this to start the server with Swagger interface
"""
import uvicorn
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

if __name__ == "__main__":
    print("🚀 Starting AgriDaan FastAPI Backend...")
    print("📚 Swagger UI will be available at: http://localhost:9000/docs")
    print("📖 ReDoc will be available at: http://localhost:9000/redoc")
    print("🔧 API endpoints available at: http://localhost:9000")
    print("⚙️  Configuration endpoint: http://localhost:9000/system/config")
    print("\n" + "="*60)
    
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=9000,
        reload=True,
        log_level="info"
    )
