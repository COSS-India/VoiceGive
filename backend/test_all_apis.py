#!/usr/bin/env python3
"""
COMPLETE API TESTING - ALL 38 ENDPOINTS
Tests every single API endpoint to ensure 100% functionality
"""
import requests
import json
import time
from typing import Dict, Any

# Configuration
BASE_URL = "http://localhost:9000"
HEADERS = {"Content-Type": "application/json", "accept": "application/json"}

class CompleteAPITester:
    def __init__(self, base_url: str = BASE_URL):
        self.base_url = base_url
        self.session = requests.Session()
        self.session.headers.update(HEADERS)
        self.auth_token = None
        self.user_id = None
        self.session_id = None
        self.contribution_id = None
        self.validation_id = None
        self.certificate_id = None
        
    def log_test(self, test_name: str, status: str, response_data: Any = None):
        """Log test results"""
        print(f"\n{'='*80}")
        print(f"🧪 TEST: {test_name}")
        print(f"📊 STATUS: {status}")
        if response_data:
            if isinstance(response_data, dict):
                print(f"📄 RESPONSE: {json.dumps(response_data, indent=2)}")
            else:
                print(f"📄 RESPONSE: {response_data}")
        print(f"{'='*80}")

    def test_root_endpoint(self):
        """Test root endpoint"""
        print("\n🏠 TESTING ROOT ENDPOINT")
        try:
            response = self.session.get(f"{self.base_url}/")
            self.log_test("Root Endpoint", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Root Endpoint", f"❌ ERROR: {str(e)}")

    def test_system_endpoints(self):
        """Test all system endpoints"""
        print("\n🔧 TESTING SYSTEM ENDPOINTS")
        
        # Health check
        try:
            response = self.session.get(f"{self.base_url}/system/health")
            self.log_test("System Health", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("System Health", f"❌ ERROR: {str(e)}")
        
        # Version
        try:
            response = self.session.get(f"{self.base_url}/system/version")
            self.log_test("System Version", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("System Version", f"❌ ERROR: {str(e)}")
        
        # Config
        try:
            response = self.session.get(f"{self.base_url}/system/config")
            self.log_test("System Config", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("System Config", f"❌ ERROR: {str(e)}")
        
        # Languages
        try:
            response = self.session.get(f"{self.base_url}/system/languages")
            self.log_test("System Languages", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("System Languages", f"❌ ERROR: {str(e)}")
        
        # Test speaker
        try:
            response = self.session.get(f"{self.base_url}/system/test-speaker")
            self.log_test("Test Speaker", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Test Speaker", f"❌ ERROR: {str(e)}")
        
        # Test microphone
        try:
            response = self.session.post(f"{self.base_url}/system/test-microphone")
            self.log_test("Test Microphone", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Test Microphone", f"❌ ERROR: {str(e)}")

    def test_authentication_flow(self):
        """Test complete authentication flow"""
        print("\n🔐 TESTING AUTHENTICATION FLOW")
        
        # Send OTP
        otp_data = {
            "mobileNo": "9177454678",
            "email": "test@example.com"
        }
        try:
            response = self.session.post(f"{self.base_url}/auth/send-otp", json=otp_data)
            if response.status_code == 200:
                otp_response = response.json()
                self.session_id = otp_response.get("data", {}).get("sessionId")
                self.log_test("Send OTP", "✅ PASSED", otp_response)
            else:
                self.log_test("Send OTP", "❌ FAILED", response.json())
                return False
        except Exception as e:
            self.log_test("Send OTP", f"❌ ERROR: {str(e)}")
            return False
        
        # Verify OTP
        if self.session_id:
            otp_verify_data = {
                "sessionId": self.session_id,
                "otp": "123456"
            }
            try:
                response = self.session.post(f"{self.base_url}/auth/verify-otp", json=otp_verify_data)
                if response.status_code == 200:
                    auth_data = response.json()
                    self.auth_token = auth_data.get("data", {}).get("accessToken")
                    self.user_id = auth_data.get("data", {}).get("user", {}).get("userId")
                    self.log_test("Verify OTP", "✅ PASSED", auth_data)
                else:
                    self.log_test("Verify OTP", "❌ FAILED", response.json())
                    return False
            except Exception as e:
                self.log_test("Verify OTP", f"❌ ERROR: {str(e)}")
                return False
        
        # Resend OTP
        if self.session_id:
            try:
                response = self.session.post(f"{self.base_url}/auth/resend-otp", json={"sessionId": self.session_id})
                self.log_test("Resend OTP", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
            except Exception as e:
                self.log_test("Resend OTP", f"❌ ERROR: {str(e)}")
        
        # Accept consent
        if self.auth_token:
            auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
            consent_data = {
                "termsAccepted": True,
                "privacyAccepted": True,
                "copyrightAccepted": True
            }
            try:
                response = self.session.post(f"{self.base_url}/auth/consent", json=consent_data, headers=auth_headers)
                self.log_test("Accept Consent", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
            except Exception as e:
                self.log_test("Accept Consent", f"❌ ERROR: {str(e)}")
        
        # Refresh token
        if self.auth_token:
            try:
                response = self.session.post(f"{self.base_url}/auth/refresh-token", headers=auth_headers)
                self.log_test("Refresh Token", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
            except Exception as e:
                self.log_test("Refresh Token", f"❌ ERROR: {str(e)}")
        
        return True

    def test_user_endpoints(self):
        """Test all user endpoints"""
        print("\n👤 TESTING USER ENDPOINTS")
        
        if not self.auth_token:
            self.log_test("User Endpoints", "❌ SKIPPED - No auth token")
            return False
        
        auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
        
        # Register user
        register_data = {
            "firstName": "Test",
            "lastName": "User",
            "ageGroup": "26-30 years",
            "gender": "Male",
            "mobileNo": "9177454678",
            "email": "test@example.com",
            "country": "India",
            "state": "Maharashtra",
            "district": "Amravati",
            "preferredLanguage": "Marathi"
        }
        try:
            response = self.session.post(f"{self.base_url}/users/register", json=register_data, headers=auth_headers)
            self.log_test("Register User", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Register User", f"❌ ERROR: {str(e)}")
        
        # Get user profile
        try:
            response = self.session.get(f"{self.base_url}/users/profile", headers=auth_headers)
            self.log_test("Get User Profile", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get User Profile", f"❌ ERROR: {str(e)}")
        
        # Update user profile
        profile_data = {
            "firstName": "Test",
            "lastName": "User",
            "country": "India",
            "state": "Maharashtra",
            "district": "Amravati",
            "preferredLanguage": "Marathi",
            "ageGroup": "26-30 years",
            "gender": "Male"
        }
        try:
            response = self.session.put(f"{self.base_url}/users/profile", json=profile_data, headers=auth_headers)
            self.log_test("Update User Profile", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Update User Profile", f"❌ ERROR: {str(e)}")
        
        # Get user stats
        try:
            response = self.session.get(f"{self.base_url}/users/stats", headers=auth_headers)
            self.log_test("Get User Stats", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get User Stats", f"❌ ERROR: {str(e)}")

    def test_location_endpoints(self):
        """Test all location endpoints"""
        print("\n🌍 TESTING LOCATION ENDPOINTS")
        
        # Countries
        try:
            response = self.session.get(f"{self.base_url}/location/countries")
            self.log_test("Get Countries", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get Countries", f"❌ ERROR: {str(e)}")
        
        # States
        try:
            response = self.session.get(f"{self.base_url}/location/states")
            self.log_test("Get States", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get States", f"❌ ERROR: {str(e)}")
        
        # Districts
        try:
            response = self.session.get(f"{self.base_url}/location/districts", params={"stateId": "MH"})
            self.log_test("Get Districts", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get Districts", f"❌ ERROR: {str(e)}")

    def test_contribution_endpoints(self):
        """Test all contribution endpoints"""
        print("\n🎤 TESTING CONTRIBUTION ENDPOINTS")
        
        if not self.auth_token:
            self.log_test("Contribution Endpoints", "❌ SKIPPED - No auth token")
            return False
        
        auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
        
        # Get sentences
        try:
            response = self.session.post(f"{self.base_url}/contributions/get-sentences", json={"language": "Marathi"}, headers=auth_headers)
            self.log_test("Get Contribution Sentences", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get Contribution Sentences", f"❌ ERROR: {str(e)}")
        
        # Record contribution
        contribution_data = {
            "sentenceId": "sent_001",
            "sessionId": "test_session_123",
            "sequenceNumber": 1,
            "audioFile": "mock_audio_data",
            "duration": 5.2,
            "language": "Marathi"
        }
        try:
            response = self.session.post(f"{self.base_url}/contributions/record", json=contribution_data, headers=auth_headers)
            if response.status_code == 200:
                contrib_data = response.json()
                self.contribution_id = contrib_data.get("data", {}).get("contributionId")
                self.log_test("Record Contribution", "✅ PASSED", contrib_data)
            else:
                self.log_test("Record Contribution", "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Record Contribution", f"❌ ERROR: {str(e)}")
        
        # Skip contribution
        try:
            response = self.session.post(f"{self.base_url}/contributions/skip", json={"sentenceId": "sent_002", "sessionId": "test_session_123", "reason": "too_difficult"}, headers=auth_headers)
            self.log_test("Skip Contribution", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Skip Contribution", f"❌ ERROR: {str(e)}")
        
        # Report contribution
        try:
            response = self.session.post(f"{self.base_url}/contributions/report", json={"contributionId": "contrib_001", "sentenceId": "sent_001", "reportType": "inappropriate", "reason": "inappropriate"}, headers=auth_headers)
            self.log_test("Report Contribution", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Report Contribution", f"❌ ERROR: {str(e)}")
        
        # Complete session
        try:
            response = self.session.post(f"{self.base_url}/contributions/session-complete", json={"sessionId": "test_session_123"}, headers=auth_headers)
            self.log_test("Complete Contribution Session", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Complete Contribution Session", f"❌ ERROR: {str(e)}")

    def test_validation_endpoints(self):
        """Test all validation endpoints"""
        print("\n✅ TESTING VALIDATION ENDPOINTS")
        
        if not self.auth_token:
            self.log_test("Validation Endpoints", "❌ SKIPPED - No auth token")
            return False
        
        auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
        
        # Get validation queue
        try:
            response = self.session.get(f"{self.base_url}/validations/get-queue", params={"language": "Marathi"}, headers=auth_headers)
            self.log_test("Get Validation Queue", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get Validation Queue", f"❌ ERROR: {str(e)}")
        
        # Submit validation
        validation_data = {
            "contributionId": "contrib_001",
            "sessionId": "test_session_123",
            "sentenceId": "sent_001",
            "decision": "correct",
            "sequenceNumber": 1,
            "isValid": True,
            "confidence": 0.85,
            "feedback": "Good pronunciation"
        }
        try:
            response = self.session.post(f"{self.base_url}/validations/submit", json=validation_data, headers=auth_headers)
            if response.status_code == 200:
                valid_data = response.json()
                self.validation_id = valid_data.get("data", {}).get("validationId")
                self.log_test("Submit Validation", "✅ PASSED", valid_data)
            else:
                self.log_test("Submit Validation", "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Submit Validation", f"❌ ERROR: {str(e)}")
        
        # Complete validation session
        try:
            response = self.session.post(f"{self.base_url}/validations/session-complete", json={"sessionId": "test_session_123"}, headers=auth_headers)
            self.log_test("Complete Validation Session", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Complete Validation Session", f"❌ ERROR: {str(e)}")

    def test_certificate_endpoints(self):
        """Test all certificate endpoints"""
        print("\n🏆 TESTING CERTIFICATE ENDPOINTS")
        
        if not self.auth_token:
            self.log_test("Certificate Endpoints", "❌ SKIPPED - No auth token")
            return False
        
        auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
        
        # Check eligibility
        try:
            response = self.session.get(f"{self.base_url}/certificates/check-eligibility", headers=auth_headers)
            self.log_test("Check Certificate Eligibility", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Check Certificate Eligibility", f"❌ ERROR: {str(e)}")
        
        # Generate certificate
        try:
            response = self.session.post(f"{self.base_url}/certificates/generate", headers=auth_headers)
            if response.status_code == 200:
                cert_data = response.json()
                self.certificate_id = cert_data.get("data", {}).get("certificateId")
                self.log_test("Generate Certificate", "✅ PASSED", cert_data)
            else:
                self.log_test("Generate Certificate", "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Generate Certificate", f"❌ ERROR: {str(e)}")
        
        # Download certificate
        if self.certificate_id:
            try:
                response = self.session.get(f"{self.base_url}/certificates/{self.certificate_id}/download", headers=auth_headers)
                self.log_test("Download Certificate", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
            except Exception as e:
                self.log_test("Download Certificate", f"❌ ERROR: {str(e)}")
        
        # Preview certificate
        if self.certificate_id:
            try:
                response = self.session.get(f"{self.base_url}/certificates/{self.certificate_id}/preview", headers=auth_headers)
                self.log_test("Preview Certificate", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
            except Exception as e:
                self.log_test("Preview Certificate", f"❌ ERROR: {str(e)}")
        
        # Get certificate details
        if self.certificate_id:
            try:
                response = self.session.get(f"{self.base_url}/certificates/{self.certificate_id}", headers=auth_headers)
                self.log_test("Get Certificate Details", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
            except Exception as e:
                self.log_test("Get Certificate Details", f"❌ ERROR: {str(e)}")

    def test_storage_endpoints(self):
        """Test all storage endpoints"""
        print("\n💾 TESTING STORAGE ENDPOINTS")
        
        if not self.auth_token:
            self.log_test("Storage Endpoints", "❌ SKIPPED - No auth token")
            return False
        
        auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
        
        # Get storage stats
        try:
            response = self.session.get(f"{self.base_url}/storage/stats", headers=auth_headers)
            self.log_test("Get Storage Stats", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Get Storage Stats", f"❌ ERROR: {str(e)}")
        
        # List files
        try:
            response = self.session.get(f"{self.base_url}/storage/files/audio", headers=auth_headers)
            self.log_test("List Audio Files", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("List Audio Files", f"❌ ERROR: {str(e)}")
        
        # Download file
        try:
            response = self.session.get(f"{self.base_url}/storage/files/audio/test.mp3", headers=auth_headers)
            if response.status_code == 200:
                # For binary files, check if we got content
                content_length = len(response.content)
                self.log_test("Download File", "✅ PASSED", {"message": f"File downloaded successfully, size: {content_length} bytes"})
            else:
                self.log_test("Download File", "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Download File", f"❌ ERROR: {str(e)}")
        
        # Delete file
        try:
            response = self.session.delete(f"{self.base_url}/storage/files/audio/test.mp3", headers=auth_headers)
            self.log_test("Delete File", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Delete File", f"❌ ERROR: {str(e)}")
        
        # Cleanup storage
        try:
            response = self.session.post(f"{self.base_url}/storage/cleanup", headers=auth_headers)
            self.log_test("Cleanup Storage", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Cleanup Storage", f"❌ ERROR: {str(e)}")

    def test_admin_endpoints(self):
        """Test all admin endpoints"""
        print("\n👨‍💼 TESTING ADMIN ENDPOINTS")
        
        # Data overview
        try:
            response = self.session.get(f"{self.base_url}/admin/data/overview")
            self.log_test("Admin Data Overview", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Admin Data Overview", f"❌ ERROR: {str(e)}")
        
        # Add sentences
        try:
            response = self.session.post(f"{self.base_url}/admin/data/sentences", 
                                       params={"language": "Marathi"},
                                       json={"language": "Marathi"})
            self.log_test("Admin Add Sentences", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Admin Add Sentences", f"❌ ERROR: {str(e)}")
        
        # Add validation items
        try:
            response = self.session.post(f"{self.base_url}/admin/data/validation-items",
                                       params={"language": "Marathi"},
                                       json={"language": "Marathi"})
            self.log_test("Admin Add Validation Items", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Admin Add Validation Items", f"❌ ERROR: {str(e)}")

    def test_logout(self):
        """Test logout endpoint"""
        print("\n🚪 TESTING LOGOUT")
        
        if not self.auth_token:
            self.log_test("Logout", "❌ SKIPPED - No auth token")
            return False
        
        auth_headers = {**HEADERS, "Authorization": f"Bearer {self.auth_token}"}
        
        try:
            response = self.session.post(f"{self.base_url}/auth/logout", headers=auth_headers)
            self.log_test("Logout", "✅ PASSED" if response.status_code == 200 else "❌ FAILED", response.json())
        except Exception as e:
            self.log_test("Logout", f"❌ ERROR: {str(e)}")

    def run_complete_test(self):
        """Run complete API testing for all 38 endpoints"""
        print("🚀 STARTING COMPLETE API TESTING - ALL 38 ENDPOINTS")
        print(f"🌐 Testing against: {self.base_url}")
        
        # Test all endpoints
        self.test_root_endpoint()
        self.test_system_endpoints()
        auth_success = self.test_authentication_flow()
        
        if auth_success:
            self.test_user_endpoints()
            self.test_location_endpoints()
            self.test_contribution_endpoints()
            self.test_validation_endpoints()
            self.test_certificate_endpoints()
            self.test_storage_endpoints()
            self.test_logout()
        
        self.test_admin_endpoints()
        
        print("\n🎉 COMPLETE API TESTING FINISHED!")
        print(f"🔑 Auth Token: {'✅ Available' if self.auth_token else '❌ Not Available'}")
        print(f"👤 User ID: {self.user_id}")
        print(f"🎤 Contribution ID: {self.contribution_id}")
        print(f"✅ Validation ID: {self.validation_id}")
        print(f"🏆 Certificate ID: {self.certificate_id}")

if __name__ == "__main__":
    tester = CompleteAPITester()
    tester.run_complete_test()
