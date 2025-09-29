"""
Local storage service for AgriDaan FastAPI backend
Handles file uploads, downloads, and management
"""
import os
import shutil
import uuid
from pathlib import Path
from typing import Optional, List, Dict, Any
from datetime import datetime
import mimetypes
from config import config
from logging_config import get_logger

logger = get_logger("storage")

class LocalStorageService:
    """Local file storage service"""
    
    def __init__(self):
        self.storage_path = Path(config.storage_path)
        self.max_size_gb = config.max_storage_size_gb
        self._ensure_storage_directory()
    
    def _ensure_storage_directory(self):
        """Create storage directory if it doesn't exist"""
        try:
            self.storage_path.mkdir(parents=True, exist_ok=True)
            
            # Create subdirectories
            (self.storage_path / "audio").mkdir(exist_ok=True)
            (self.storage_path / "certificates").mkdir(exist_ok=True)
            (self.storage_path / "thumbnails").mkdir(exist_ok=True)
            (self.storage_path / "temp").mkdir(exist_ok=True)
            
            logger.info(f"Storage directory created: {self.storage_path}")
        except Exception as e:
            logger.error(f"Failed to create storage directory: {e}")
            raise
    
    def _get_file_path(self, file_type: str, filename: str) -> Path:
        """Get full file path for a given file type and filename"""
        return self.storage_path / file_type / filename
    
    def _generate_unique_filename(self, original_filename: str) -> str:
        """Generate unique filename to avoid conflicts"""
        file_extension = Path(original_filename).suffix
        unique_id = str(uuid.uuid4())
        return f"{unique_id}{file_extension}"
    
    def _get_file_size_mb(self, file_path: Path) -> float:
        """Get file size in MB"""
        try:
            return file_path.stat().st_size / (1024 * 1024)
        except Exception:
            return 0.0
    
    def _get_storage_usage_gb(self) -> float:
        """Get current storage usage in GB"""
        try:
            total_size = 0
            for file_path in self.storage_path.rglob("*"):
                if file_path.is_file():
                    total_size += file_path.stat().st_size
            return total_size / (1024 * 1024 * 1024)
        except Exception:
            return 0.0
    
    def upload_file(self, file_content: bytes, original_filename: str, file_type: str = "audio") -> Dict[str, Any]:
        """Upload file to local storage"""
        try:
            # Check storage usage
            current_usage = self._get_storage_usage_gb()
            if current_usage >= self.max_size_gb:
                raise Exception(f"Storage limit exceeded. Current: {current_usage:.2f}GB, Max: {self.max_size_gb}GB")
            
            # Generate unique filename
            unique_filename = self._get_unique_filename(original_filename)
            file_path = self._get_file_path(file_type, unique_filename)
            
            # Write file
            with open(file_path, 'wb') as f:
                f.write(file_content)
            
            # Get file info
            file_size_mb = self._get_file_size_mb(file_path)
            mime_type, _ = mimetypes.guess_type(str(file_path))
            
            result = {
                "file_name": unique_filename,
                "original_filename": original_filename,
                "file_path": str(file_path),
                "file_size_mb": file_size_mb,
                "mime_type": mime_type,
                "uploaded_at": datetime.utcnow().isoformat() + "Z",
                "file_type": file_type
            }
            
            logger.info(f"File uploaded successfully: {unique_filename}", extra={
                "file_name": unique_filename,
                "file_size_mb": file_size_mb,
                "file_type": file_type
            })
            
            return result
            
        except Exception as e:
            logger.error(f"Failed to upload file: {e}", extra={
                "original_filename": original_filename,
                "file_type": file_type
            })
            raise
    
    def download_file(self, filename: str, file_type: str = "audio") -> Optional[bytes]:
        """Download file from local storage"""
        try:
            file_path = self._get_file_path(file_type, filename)
            
            if not file_path.exists():
                logger.warning(f"File not found: {filename}", extra={
                    "file_name": filename,
                    "file_type": file_type
                })
                return None
            
            with open(file_path, 'rb') as f:
                content = f.read()
            
            logger.info(f"File downloaded successfully: {filename}", extra={
                "file_name": filename,
                "file_type": file_type,
                "file_size_mb": self._get_file_size_mb(file_path)
            })
            
            return content
            
        except Exception as e:
            logger.error(f"Failed to download file: {e}", extra={
                "file_name": filename,
                "file_type": file_type
            })
            return None
    
    def delete_file(self, filename: str, file_type: str = "audio") -> bool:
        """Delete file from local storage"""
        try:
            file_path = self._get_file_path(file_type, filename)
            
            if not file_path.exists():
                logger.warning(f"File not found for deletion: {filename}", extra={
                    "file_name": filename,
                    "file_type": file_type
                })
                return False
            
            file_path.unlink()
            
            logger.info(f"File deleted successfully: {filename}", extra={
                "file_name": filename,
                "file_type": file_type
            })
            
            return True
            
        except Exception as e:
            logger.error(f"Failed to delete file: {e}", extra={
                "file_name": filename,
                "file_type": file_type
            })
            return False
    
    def get_file_info(self, filename: str, file_type: str = "audio") -> Optional[Dict[str, Any]]:
        """Get file information"""
        try:
            file_path = self._get_file_path(file_type, filename)
            
            if not file_path.exists():
                return None
            
            stat = file_path.stat()
            mime_type, _ = mimetypes.guess_type(str(file_path))
            
            return {
                "file_name": filename,
                "file_path": str(file_path),
                "file_size_mb": self._get_file_size_mb(file_path),
                "mime_type": mime_type,
                "created_at": datetime.fromtimestamp(stat.st_ctime).isoformat() + "Z",
                "modified_at": datetime.fromtimestamp(stat.st_mtime).isoformat() + "Z",
                "file_type": file_type
            }
            
        except Exception as e:
            logger.error(f"Failed to get file info: {e}", extra={
                "file_name": filename,
                "file_type": file_type
            })
            return None
    
    def list_files(self, file_type: str = "audio") -> List[Dict[str, Any]]:
        """List all files of a specific type"""
        try:
            files = []
            file_dir = self._get_file_path(file_type, "")
            
            if not file_dir.exists():
                return files
            
            for file_path in file_dir.iterdir():
                if file_path.is_file():
                    file_info = self.get_file_info(file_path.name, file_type)
                    if file_info:
                        files.append(file_info)
            
            logger.info(f"Listed {len(files)} files", extra={
                "file_type": file_type,
                "count": len(files)
            })
            
            return files
            
        except Exception as e:
            logger.error(f"Failed to list files: {e}", extra={
                "file_type": file_type
            })
            return []
    
    def get_storage_stats(self) -> Dict[str, Any]:
        """Get storage statistics"""
        try:
            total_usage_gb = self._get_storage_usage_gb()
            max_size_gb = self.max_size_gb
            usage_percentage = (total_usage_gb / max_size_gb) * 100 if max_size_gb > 0 else 0
            
            # Count files by type
            file_counts = {}
            for file_type in ["audio", "certificates", "thumbnails", "temp"]:
                files = self.list_files(file_type)
                file_counts[file_type] = len(files)
            
            stats = {
                "total_usage_gb": round(total_usage_gb, 2),
                "max_size_gb": max_size_gb,
                "usage_percentage": round(usage_percentage, 2),
                "file_counts": file_counts,
                "storage_path": str(self.storage_path),
                "is_healthy": usage_percentage < 90  # Healthy if less than 90% full
            }
            
            logger.info(f"Storage stats retrieved", extra=stats)
            
            return stats
            
        except Exception as e:
            logger.error(f"Failed to get storage stats: {e}")
            return {
                "total_usage_gb": 0,
                "max_size_gb": self.max_size_gb,
                "usage_percentage": 0,
                "file_counts": {},
                "storage_path": str(self.storage_path),
                "is_healthy": False
            }
    
    def cleanup_temp_files(self, max_age_hours: int = 24) -> int:
        """Clean up temporary files older than specified hours"""
        try:
            temp_dir = self._get_file_path("temp", "")
            if not temp_dir.exists():
                return 0
            
            current_time = datetime.now().timestamp()
            max_age_seconds = max_age_hours * 3600
            deleted_count = 0
            
            for file_path in temp_dir.iterdir():
                if file_path.is_file():
                    file_age = current_time - file_path.stat().st_mtime
                    if file_age > max_age_seconds:
                        file_path.unlink()
                        deleted_count += 1
            
            logger.info(f"Cleaned up {deleted_count} temporary files", extra={
                "deleted_count": deleted_count,
                "max_age_hours": max_age_hours
            })
            
            return deleted_count
            
        except Exception as e:
            logger.error(f"Failed to cleanup temp files: {e}")
            return 0

# Global storage service instance
storage_service = LocalStorageService()
