#!/usr/bin/env python3
"""
Complete End-to-End Flow Test for AgriDaan API
Tests the entire user journey from registration to certificate generation
"""

import requests
import json
import time
from datetime import datetime

class CompleteFlowTester:
    def __init__(self, base_url="http://localhost:9000"):
        self.base_url = base_url
        self.session = requests.Session()
        self.auth_token = None
        self.user_id = None
        self.session_id = None
        self.contribution_id = None
        self.validation_id = None
        self.certificate_id = None
        
    def log_step(self, step, status, details=None):
        """Log each step of the flow"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"\n🔄 [{timestamp}] {step}")
        print(f"📊 STATUS: {status}")
        if details:
            print(f"📄 DETAILS: {json.dumps(details, indent=2, ensure_ascii=False)}")
        print("=" * 80)
    
    def test_complete_user_journey(self):
        """Test the complete end-to-end user journey"""
        print("🚀 STARTING COMPLETE END-TO-END FLOW TEST")
        print("=" * 80)
        
        try:
            # Step 1: System Health Check
            self.log_step("STEP 1: System Health Check", "🔄 Testing...")
            response = self.session.get(f"{self.base_url}/system/health")
            if response.status_code == 200:
                self.log_step("STEP 1: System Health Check", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 1: System Health Check", "❌ FAILED", response.json())
                return False
            
            # Step 2: Get System Configuration
            self.log_step("STEP 2: Get System Configuration", "🔄 Testing...")
            response = self.session.get(f"{self.base_url}/system/config")
            if response.status_code == 200:
                config = response.json()
                self.log_step("STEP 2: Get System Configuration", "✅ PASSED", config)
            else:
                self.log_step("STEP 2: Get System Configuration", "❌ FAILED", response.json())
                return False
            
            # Step 3: Get Available Languages
            self.log_step("STEP 3: Get Available Languages", "🔄 Testing...")
            response = self.session.get(f"{self.base_url}/system/languages")
            if response.status_code == 200:
                languages = response.json()
                self.log_step("STEP 3: Get Available Languages", "✅ PASSED", languages)
            else:
                self.log_step("STEP 3: Get Available Languages", "❌ FAILED", response.json())
                return False
            
            # Step 4: Get Location Data
            self.log_step("STEP 4: Get Location Data", "🔄 Testing...")
            response = self.session.get(f"{self.base_url}/location/countries")
            if response.status_code == 200:
                countries = response.json()
                self.log_step("STEP 4: Get Countries", "✅ PASSED", countries)
            
            response = self.session.get(f"{self.base_url}/location/states")
            if response.status_code == 200:
                states = response.json()
                self.log_step("STEP 4: Get States", "✅ PASSED", states)
            
            response = self.session.get(f"{self.base_url}/location/districts?stateId=MH")
            if response.status_code == 200:
                districts = response.json()
                self.log_step("STEP 4: Get Districts", "✅ PASSED", districts)
            
            # Step 5: User Registration Flow
            self.log_step("STEP 5: User Registration Flow", "🔄 Testing...")
            
            # Send OTP
            otp_data = {
                "mobileNo": "9177454678",
                "language": "Marathi"
            }
            response = self.session.post(f"{self.base_url}/auth/send-otp", json=otp_data)
            if response.status_code == 200:
                otp_response = response.json()
                self.session_id = otp_response["data"]["sessionId"]
                self.log_step("STEP 5a: Send OTP", "✅ PASSED", otp_response)
            else:
                self.log_step("STEP 5a: Send OTP", "❌ FAILED", response.json())
                return False
            
            # Verify OTP
            verify_data = {
                "sessionId": self.session_id,
                "otp": "123456"
            }
            response = self.session.post(f"{self.base_url}/auth/verify-otp", json=verify_data)
            if response.status_code == 200:
                verify_response = response.json()
                self.auth_token = verify_response["data"]["accessToken"]
                self.user_id = verify_response["data"]["user"]["userId"]
                self.log_step("STEP 5b: Verify OTP", "✅ PASSED", verify_response)
            else:
                self.log_step("STEP 5b: Verify OTP", "❌ FAILED", response.json())
                return False
            
            # Accept Consent
            consent_data = {
                "termsAccepted": True,
                "privacyAccepted": True,
                "copyrightAccepted": True,
                "consentText": {
                    "terms": "I accept the terms and conditions",
                    "privacy": "I accept the privacy policy",
                    "copyright": "I accept the copyright terms"
                }
            }
            auth_headers = {"Authorization": f"Bearer {self.auth_token}"}
            response = self.session.post(f"{self.base_url}/auth/consent", json=consent_data, headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 5c: Accept Consent", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 5c: Accept Consent", "❌ FAILED", response.json())
                return False
            
            # Register User Profile
            profile_data = {
                "firstName": "Animesh",
                "lastName": "Patil",
                "ageGroup": "26-30 years",
                "gender": "Male",
                "country": "India",
                "state": "Maharashtra",
                "district": "Amravati",
                "preferredLanguage": "Marathi"
            }
            response = self.session.post(f"{self.base_url}/users/register", json=profile_data, headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 5d: Register User Profile", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 5d: Register User Profile", "❌ FAILED", response.json())
                return False
            
            # Step 6: Contribution Flow
            self.log_step("STEP 6: Contribution Flow", "🔄 Testing...")
            
            # Get Contribution Sentences
            contribution_data = {
                "language": "Marathi",
                "sessionId": self.session_id
            }
            response = self.session.post(f"{self.base_url}/contributions/get-sentences", json=contribution_data, headers=auth_headers)
            if response.status_code == 200:
                sentences = response.json()
                self.log_step("STEP 6a: Get Contribution Sentences", "✅ PASSED", sentences)
            else:
                self.log_step("STEP 6a: Get Contribution Sentences", "❌ FAILED", response.json())
                return False
            
            # Record Contribution
            record_data = {
                "sessionId": self.session_id,
                "sentenceId": "mr-001",
                "language": "Marathi",
                "sequenceNumber": 1,
                "duration": 5.2,
                "metadata": "Test contribution metadata"
            }
            response = self.session.post(f"{self.base_url}/contributions/record", json=record_data, headers=auth_headers)
            if response.status_code == 200:
                contribution_response = response.json()
                self.contribution_id = contribution_response["data"]["contributionId"]
                self.log_step("STEP 6b: Record Contribution", "✅ PASSED", contribution_response)
            else:
                self.log_step("STEP 6b: Record Contribution", "❌ FAILED", response.json())
                return False
            
            # Complete Contribution Session
            complete_data = {
                "sessionId": self.session_id,
                "totalContributions": "5"
            }
            response = self.session.post(f"{self.base_url}/contributions/session-complete", json=complete_data, headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 6c: Complete Contribution Session", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 6c: Complete Contribution Session", "❌ FAILED", response.json())
                return False
            
            # Step 7: Validation Flow
            self.log_step("STEP 7: Validation Flow", "🔄 Testing...")
            
            # Get Validation Queue
            validation_data = {
                "language": "Marathi"
            }
            response = self.session.get(f"{self.base_url}/validations/get-queue", params=validation_data, headers=auth_headers)
            if response.status_code == 200:
                validation_queue = response.json()
                self.log_step("STEP 7a: Get Validation Queue", "✅ PASSED", validation_queue)
            else:
                self.log_step("STEP 7a: Get Validation Queue", "❌ FAILED", response.json())
                return False
            
            # Submit Validation
            submit_validation_data = {
                "sessionId": self.session_id,
                "contributionId": "contrib-mr-001",
                "sentenceId": "sent-mr-001",
                "decision": "correct",
                "sequenceNumber": 1,
                "feedback": "Good pronunciation and clarity"
            }
            response = self.session.post(f"{self.base_url}/validations/submit", json=submit_validation_data, headers=auth_headers)
            if response.status_code == 200:
                validation_response = response.json()
                self.validation_id = validation_response["data"]["validationId"]
                self.log_step("STEP 7b: Submit Validation", "✅ PASSED", validation_response)
            else:
                self.log_step("STEP 7b: Submit Validation", "❌ FAILED", response.json())
                return False
            
            # Complete Validation Session
            complete_validation_data = {
                "sessionId": self.session_id,
                "totalValidations": "25"
            }
            response = self.session.post(f"{self.base_url}/validations/session-complete", json=complete_validation_data, headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 7c: Complete Validation Session", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 7c: Complete Validation Session", "❌ FAILED", response.json())
                return False
            
            # Step 8: Certificate Flow
            self.log_step("STEP 8: Certificate Flow", "🔄 Testing...")
            
            # Check Certificate Eligibility
            response = self.session.get(f"{self.base_url}/certificates/check-eligibility", headers=auth_headers)
            if response.status_code == 200:
                eligibility = response.json()
                self.log_step("STEP 8a: Check Certificate Eligibility", "✅ PASSED", eligibility)
            else:
                self.log_step("STEP 8a: Check Certificate Eligibility", "❌ FAILED", response.json())
                return False
            
            # Generate Certificate
            certificate_data = {
                "recipientName": "Animesh Patil"
            }
            response = self.session.post(f"{self.base_url}/certificates/generate", json=certificate_data, headers=auth_headers)
            if response.status_code == 200:
                certificate_response = response.json()
                self.certificate_id = certificate_response["data"]["certificateId"]
                self.log_step("STEP 8b: Generate Certificate", "✅ PASSED", certificate_response)
            else:
                self.log_step("STEP 8b: Generate Certificate", "❌ FAILED", response.json())
                return False
            
            # Download Certificate
            response = self.session.get(f"{self.base_url}/certificates/{self.certificate_id}/download", headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 8c: Download Certificate", "✅ PASSED", {"message": "Certificate downloaded successfully"})
            else:
                self.log_step("STEP 8c: Download Certificate", "❌ FAILED", response.json())
                return False
            
            # Step 9: User Profile Management
            self.log_step("STEP 9: User Profile Management", "🔄 Testing...")
            
            # Get User Profile
            response = self.session.get(f"{self.base_url}/users/profile", headers=auth_headers)
            if response.status_code == 200:
                profile = response.json()
                self.log_step("STEP 9a: Get User Profile", "✅ PASSED", profile)
            else:
                self.log_step("STEP 9a: Get User Profile", "❌ FAILED", response.json())
                return False
            
            # Get User Stats
            response = self.session.get(f"{self.base_url}/users/stats", headers=auth_headers)
            if response.status_code == 200:
                stats = response.json()
                self.log_step("STEP 9b: Get User Stats", "✅ PASSED", stats)
            else:
                self.log_step("STEP 9b: Get User Stats", "❌ FAILED", response.json())
                return False
            
            # Step 10: Storage Management
            self.log_step("STEP 10: Storage Management", "🔄 Testing...")
            
            # Get Storage Stats
            response = self.session.get(f"{self.base_url}/storage/stats", headers=auth_headers)
            if response.status_code == 200:
                storage_stats = response.json()
                self.log_step("STEP 10a: Get Storage Stats", "✅ PASSED", storage_stats)
            else:
                self.log_step("STEP 10a: Get Storage Stats", "❌ FAILED", response.json())
                return False
            
            # List Audio Files
            response = self.session.get(f"{self.base_url}/storage/files/audio", headers=auth_headers)
            if response.status_code == 200:
                files = response.json()
                self.log_step("STEP 10b: List Audio Files", "✅ PASSED", files)
            else:
                self.log_step("STEP 10b: List Audio Files", "❌ FAILED", response.json())
                return False
            
            # Step 11: Admin Functions
            self.log_step("STEP 11: Admin Functions", "🔄 Testing...")
            
            # Get Data Overview
            response = self.session.get(f"{self.base_url}/admin/data/overview", headers=auth_headers)
            if response.status_code == 200:
                overview = response.json()
                self.log_step("STEP 11a: Get Data Overview", "✅ PASSED", overview)
            else:
                self.log_step("STEP 11a: Get Data Overview", "❌ FAILED", response.json())
                return False
            
            # Add New Sentence
            new_sentence_data = {
                "text": "नवीन वाक्य जोडले गेले आहे",
                "category": "agriculture",
                "difficulty": "medium"
            }
            response = self.session.post(f"{self.base_url}/admin/data/sentences?language=Marathi", json=new_sentence_data, headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 11b: Add New Sentence", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 11b: Add New Sentence", "❌ FAILED", response.json())
                return False
            
            # Step 12: Logout
            self.log_step("STEP 12: User Logout", "🔄 Testing...")
            response = self.session.post(f"{self.base_url}/auth/logout", headers=auth_headers)
            if response.status_code == 200:
                self.log_step("STEP 12: User Logout", "✅ PASSED", response.json())
            else:
                self.log_step("STEP 12: User Logout", "❌ FAILED", response.json())
                return False
            
            # Final Summary
            self.log_step("FINAL SUMMARY", "🎉 COMPLETE END-TO-END FLOW SUCCESSFUL!", {
                "total_steps": 12,
                "user_id": self.user_id,
                "contribution_id": self.contribution_id,
                "validation_id": self.validation_id,
                "certificate_id": self.certificate_id,
                "flow_status": "COMPLETED_SUCCESSFULLY"
            })
            
            return True
            
        except Exception as e:
            self.log_step("ERROR", f"❌ FLOW FAILED: {str(e)}")
            return False

if __name__ == "__main__":
    tester = CompleteFlowTester()
    success = tester.test_complete_user_journey()
    
    if success:
        print("\n🎉 END-TO-END FLOW TEST COMPLETED SUCCESSFULLY!")
        print("✅ All user journey steps working perfectly")
        print("✅ Complete flow from registration to certificate generation")
        print("✅ All API endpoints integrated and functional")
    else:
        print("\n❌ END-TO-END FLOW TEST FAILED!")
        print("❌ Some steps in the user journey failed")
