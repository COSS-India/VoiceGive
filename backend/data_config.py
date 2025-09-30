"""
Dynamic data configuration for AgriDaan API
All static data is now configurable through JSON files
"""
import json
import os
from typing import Dict, List, Any
from datetime import datetime

class DataConfig:
    """Dynamic data configuration system"""
    
    def __init__(self):
        self.data_dir = "data"
        self._ensure_data_directory()
        self._load_all_data()
    
    def _ensure_data_directory(self):
        """Create data directory if it doesn't exist"""
        if not os.path.exists(self.data_dir):
            os.makedirs(self.data_dir)
    
    def _load_all_data(self):
        """Load all data from JSON files"""
        self.countries = self._load_data("countries.json", self._get_default_countries())
        self.states = self._load_data("states.json", self._get_default_states())
        self.districts = self._load_data("districts.json", self._get_default_districts())
        self.languages = self._load_data("languages.json", self._get_default_languages())
        self.age_groups = self._load_data("age_groups.json", self._get_default_age_groups())
        self.genders = self._load_data("genders.json", self._get_default_genders())
        self.sentences = self._load_data("sentences.json", self._get_default_sentences())
        self.validation_items = self._load_data("validation_items.json", self._get_default_validation_items())
    
    def _load_data(self, filename: str, default_data: Any) -> Any:
        """Load data from JSON file or create with default data"""
        filepath = os.path.join(self.data_dir, filename)
        
        if os.path.exists(filepath):
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except Exception as e:
                print(f"Error loading {filename}: {e}")
                return default_data
        else:
            # Create file with default data
            with open(filepath, 'w', encoding='utf-8') as f:
                json.dump(default_data, f, indent=2, ensure_ascii=False)
            return default_data
    
    def _get_default_countries(self) -> List[Dict[str, str]]:
        """Default countries data"""
        return [
            {"countryId": "IN", "countryName": "India", "countryCode": "+91"},
            {"countryId": "US", "countryName": "United States", "countryCode": "+1"},
            {"countryId": "GB", "countryName": "United Kingdom", "countryCode": "+44"},
            {"countryId": "AU", "countryName": "Australia", "countryCode": "+61"},
            {"countryId": "CA", "countryName": "Canada", "countryCode": "+1"}
        ]
    
    def _get_default_states(self) -> Dict[str, List[Dict[str, str]]]:
        """Default states data organized by country"""
        return {
            "IN": [
                {"stateId": "MH", "stateName": "Maharashtra"},
                {"stateId": "KA", "stateName": "Karnataka"},
                {"stateId": "TN", "stateName": "Tamil Nadu"},
                {"stateId": "UP", "stateName": "Uttar Pradesh"},
                {"stateId": "WB", "stateName": "West Bengal"},
                {"stateId": "GJ", "stateName": "Gujarat"},
                {"stateId": "RJ", "stateName": "Rajasthan"},
                {"stateId": "MP", "stateName": "Madhya Pradesh"},
                {"stateId": "AP", "stateName": "Andhra Pradesh"},
                {"stateId": "KL", "stateName": "Kerala"}
            ],
            "US": [
                {"stateId": "CA", "stateName": "California"},
                {"stateId": "TX", "stateName": "Texas"},
                {"stateId": "FL", "stateName": "Florida"},
                {"stateId": "NY", "stateName": "New York"},
                {"stateId": "IL", "stateName": "Illinois"}
            ]
        }
    
    def _get_default_districts(self) -> Dict[str, List[Dict[str, str]]]:
        """Default districts data organized by state"""
        return {
            "MH": [
                {"districtId": "MH-AMR", "districtName": "Amravati"},
                {"districtId": "MH-MUM", "districtName": "Mumbai"},
                {"districtId": "MH-PUN", "districtName": "Pune"},
                {"districtId": "MH-NAG", "districtName": "Nagpur"},
                {"districtId": "MH-NAS", "districtName": "Nashik"},
                {"districtId": "MH-AUR", "districtName": "Aurangabad"},
                {"districtId": "MH-SOL", "districtName": "Solapur"},
                {"districtId": "MH-KOL", "districtName": "Kolhapur"}
            ],
            "KA": [
                {"districtId": "KA-BLR", "districtName": "Bangalore"},
                {"districtId": "KA-MYS", "districtName": "Mysore"},
                {"districtId": "KA-HUB", "districtName": "Hubli"},
                {"districtId": "KA-MAN", "districtName": "Mangalore"}
            ],
            "TN": [
                {"districtId": "TN-CHN", "districtName": "Chennai"},
                {"districtId": "TN-COI", "districtName": "Coimbatore"},
                {"districtId": "TN-MAD", "districtName": "Madurai"},
                {"districtId": "TN-TIR", "districtName": "Tiruchirapalli"}
            ]
        }
    
    def _get_default_languages(self) -> List[Dict[str, Any]]:
        """Default languages data"""
        return [
            {
                "languageCode": "mr",
                "languageName": "Marathi",
                "nativeName": "मराठी",
                "isActive": True,
                "region": "Maharashtra",
                "speakers": "83 million"
            },
            {
                "languageCode": "hi",
                "languageName": "Hindi",
                "nativeName": "हिन्दी",
                "isActive": True,
                "region": "North India",
                "speakers": "600 million"
            },
            {
                "languageCode": "en",
                "languageName": "English",
                "nativeName": "English",
                "isActive": True,
                "region": "Global",
                "speakers": "1.5 billion"
            },
            {
                "languageCode": "te",
                "languageName": "Telugu",
                "nativeName": "తెలుగు",
                "isActive": True,
                "region": "Andhra Pradesh, Telangana",
                "speakers": "75 million"
            },
            {
                "languageCode": "ta",
                "languageName": "Tamil",
                "nativeName": "தமிழ்",
                "isActive": True,
                "region": "Tamil Nadu",
                "speakers": "70 million"
            },
            {
                "languageCode": "gu",
                "languageName": "Gujarati",
                "nativeName": "ગુજરાતી",
                "isActive": True,
                "region": "Gujarat",
                "speakers": "55 million"
            },
            {
                "languageCode": "bn",
                "languageName": "Bengali",
                "nativeName": "বাংলা",
                "isActive": True,
                "region": "West Bengal",
                "speakers": "230 million"
            },
            {
                "languageCode": "kn",
                "languageName": "Kannada",
                "nativeName": "ಕನ್ನಡ",
                "isActive": True,
                "region": "Karnataka",
                "speakers": "44 million"
            }
        ]
    
    def _get_default_age_groups(self) -> List[Dict[str, str]]:
        """Default age groups data"""
        return [
            {"value": "Under 18", "label": "Under 18", "minAge": 0, "maxAge": 17},
            {"value": "18-25 years", "label": "18-25 years", "minAge": 18, "maxAge": 25},
            {"value": "26-30 years", "label": "26-30 years", "minAge": 26, "maxAge": 30},
            {"value": "31-40 years", "label": "31-40 years", "minAge": 31, "maxAge": 40},
            {"value": "41-50 years", "label": "41-50 years", "minAge": 41, "maxAge": 50},
            {"value": "51-60 years", "label": "51-60 years", "minAge": 51, "maxAge": 60},
            {"value": "Above 60", "label": "Above 60", "minAge": 61, "maxAge": 100}
        ]
    
    def _get_default_genders(self) -> List[Dict[str, str]]:
        """Default genders data"""
        return [
            {"value": "Male", "label": "Male"},
            {"value": "Female", "label": "Female"},
            {"value": "Other", "label": "Other"},
            {"value": "Prefer not to say", "label": "Prefer not to say"}
        ]
    
    def _get_default_sentences(self) -> Dict[str, List[Dict[str, Any]]]:
        """Default sentences data organized by language"""
        return {
            "Marathi": [
                {
                    "sentenceId": "mr-001",
                    "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
                    "category": "agriculture",
                    "difficulty": "medium",
                    "topic": "farming_techniques"
                },
                {
                    "sentenceId": "mr-002", 
                    "text": "शेतकऱ्यांना नवीन तंत्रज्ञानाची माहिती देणे हे आमचे उद्दिष्ट आहे.",
                    "category": "agriculture",
                    "difficulty": "easy",
                    "topic": "technology"
                },
                {
                    "sentenceId": "mr-003",
                    "text": "पावसाच्या पाण्याचे व्यवस्थापन करणे हे शेतीसाठी खूप महत्वाचे आहे.",
                    "category": "agriculture", 
                    "difficulty": "hard",
                    "topic": "water_management"
                }
            ],
            "Hindi": [
                {
                    "sentenceId": "hi-001",
                    "text": "किसानों को नई तकनीक की जानकारी देना हमारा उद्देश्य है।",
                    "category": "agriculture",
                    "difficulty": "medium",
                    "topic": "technology"
                },
                {
                    "sentenceId": "hi-002",
                    "text": "बारिश के पानी का प्रबंधन करना खेती के लिए बहुत महत्वपूर्ण है।",
                    "category": "agriculture",
                    "difficulty": "hard", 
                    "topic": "water_management"
                }
            ],
            "English": [
                {
                    "sentenceId": "en-001",
                    "text": "Our goal is to provide farmers with information about new agricultural techniques.",
                    "category": "agriculture",
                    "difficulty": "medium",
                    "topic": "technology"
                },
                {
                    "sentenceId": "en-002",
                    "text": "Water management is very important for successful farming.",
                    "category": "agriculture",
                    "difficulty": "easy",
                    "topic": "water_management"
                }
            ]
        }
    
    def _get_default_validation_items(self) -> Dict[str, List[Dict[str, Any]]]:
        """Default validation items data organized by language"""
        return {
            "Marathi": [
                {
                    "contributionId": "contrib-mr-001",
                    "sentenceId": "sent-mr-001",
                    "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
                    "audioUrl": "https://storage.example.com/audio/mr-001.mp3",
                    "duration": 15.5,
                    "contributorId": "user-001",
                    "quality": "good"
                },
                {
                    "contributionId": "contrib-mr-002",
                    "sentenceId": "sent-mr-002", 
                    "text": "शेतकऱ्यांना नवीन तंत्रज्ञानाची माहिती देणे हे आमचे उद्दिष्ट आहे.",
                    "audioUrl": "https://storage.example.com/audio/mr-002.mp3",
                    "duration": 12.3,
                    "contributorId": "user-002",
                    "quality": "excellent"
                }
            ],
            "Hindi": [
                {
                    "contributionId": "contrib-hi-001",
                    "sentenceId": "sent-hi-001",
                    "text": "किसानों को नई तकनीक की जानकारी देना हमारा उद्देश्य है।",
                    "audioUrl": "https://storage.example.com/audio/hi-001.mp3",
                    "duration": 14.2,
                    "contributorId": "user-003",
                    "quality": "good"
                }
            ]
        }
    
    # ==================== Data Access Methods ====================
    
    def get_countries(self) -> List[Dict[str, str]]:
        """Get all countries"""
        return self.countries
    
    def get_states(self, country_id: str) -> List[Dict[str, str]]:
        """Get states by country ID"""
        return self.states.get(country_id, [])
    
    def get_districts(self, state_id: str) -> List[Dict[str, str]]:
        """Get districts by state ID"""
        return self.districts.get(state_id, [])
    
    def get_languages(self) -> List[Dict[str, Any]]:
        """Get all languages"""
        return self.languages
    
    def get_age_groups(self) -> List[Dict[str, str]]:
        """Get all age groups"""
        return self.age_groups
    
    def get_genders(self) -> List[Dict[str, str]]:
        """Get all genders"""
        return self.genders
    
    def get_sentences(self, language: str, count: int = 5) -> List[Dict[str, Any]]:
        """Get sentences for a specific language"""
        sentences = self.sentences.get(language, [])
        return sentences[:count]
    
    def get_validation_items(self, language: str, count: int = 25) -> List[Dict[str, Any]]:
        """Get validation items for a specific language"""
        items = self.validation_items.get(language, [])
        return items[:count]
    
    def add_sentence(self, language: str, sentence_data: Dict[str, Any]) -> str:
        """Add a new sentence for a language"""
        if language not in self.sentences:
            self.sentences[language] = []
        
        sentence_id = f"{language.lower()}-{len(self.sentences[language]) + 1:03d}"
        sentence_data["sentenceId"] = sentence_id
        self.sentences[language].append(sentence_data)
        
        # Save to file
        self._save_data("sentences.json", self.sentences)
        return sentence_id
    
    def add_validation_item(self, language: str, item_data: Dict[str, Any]) -> str:
        """Add a new validation item for a language"""
        if language not in self.validation_items:
            self.validation_items[language] = []
        
        contribution_id = f"contrib-{language.lower()}-{len(self.validation_items[language]) + 1:03d}"
        item_data["contributionId"] = contribution_id
        self.validation_items[language].append(item_data)
        
        # Save to file
        self._save_data("validation_items.json", self.validation_items)
        return contribution_id
    
    def _save_data(self, filename: str, data: Any):
        """Save data to JSON file"""
        filepath = os.path.join(self.data_dir, filename)
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

# Global data config instance
data_config = DataConfig()
