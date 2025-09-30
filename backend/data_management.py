"""
Data management endpoints for AgriDaan API
Allows dynamic addition and management of data
"""
from fastapi import APIRouter, HTTPException
from typing import Dict, Any, List
from data_config import data_config
import uuid

router = APIRouter(prefix="/admin", tags=["Data Management"])

@router.get("/data/overview", response_model=Dict[str, Any])
async def get_data_overview():
    """Get overview of all data"""
    return {
        "success": True,
        "data": {
            "countries": len(data_config.get_countries()),
            "states": sum(len(states) for states in data_config.states.values()),
            "districts": sum(len(districts) for districts in data_config.districts.values()),
            "languages": len(data_config.get_languages()),
            "ageGroups": len(data_config.get_age_groups()),
            "genders": len(data_config.get_genders()),
            "sentences": {
                language: len(sentences) 
                for language, sentences in data_config.sentences.items()
            },
            "validationItems": {
                language: len(items) 
                for language, items in data_config.validation_items.items()
            }
        }
    }

@router.post("/data/sentences", response_model=Dict[str, Any])
async def add_sentence(language: str, sentence_data: Dict[str, Any]):
    """Add a new sentence for a language"""
    try:
        sentence_id = data_config.add_sentence(language, sentence_data)
        return {
            "success": True,
            "message": f"Sentence added successfully for {language}",
            "data": {
                "sentenceId": sentence_id,
                "language": language
            }
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error adding sentence: {str(e)}")

@router.post("/data/validation-items", response_model=Dict[str, Any])
async def add_validation_item(language: str, item_data: Dict[str, Any]):
    """Add a new validation item for a language"""
    try:
        contribution_id = data_config.add_validation_item(language, item_data)
        return {
            "success": True,
            "message": f"Validation item added successfully for {language}",
            "data": {
                "contributionId": contribution_id,
                "language": language
            }
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error adding validation item: {str(e)}")

@router.get("/data/sentences/{language}", response_model=Dict[str, Any])
async def get_sentences_by_language(language: str, count: int = None):
    """Get sentences for a specific language"""
    sentences = data_config.get_sentences(language, count or 10)
    return {
        "success": True,
        "data": {
            "language": language,
            "sentences": sentences,
            "totalCount": len(sentences)
        }
    }

@router.get("/data/validation-items/{language}", response_model=Dict[str, Any])
async def get_validation_items_by_language(language: str, count: int = None):
    """Get validation items for a specific language"""
    items = data_config.get_validation_items(language, count or 10)
    return {
        "success": True,
        "data": {
            "language": language,
            "validationItems": items,
            "totalCount": len(items)
        }
    }

@router.get("/data/languages", response_model=Dict[str, Any])
async def get_all_languages():
    """Get all languages with details"""
    languages = data_config.get_languages()
    return {
        "success": True,
        "data": languages
    }

@router.get("/data/countries", response_model=Dict[str, Any])
async def get_all_countries():
    """Get all countries"""
    countries = data_config.get_countries()
    return {
        "success": True,
        "data": countries
    }

@router.get("/data/states/{country_id}", response_model=Dict[str, Any])
async def get_states_by_country(country_id: str):
    """Get states for a specific country"""
    states = data_config.get_states(country_id)
    return {
        "success": True,
        "data": {
            "countryId": country_id,
            "states": states,
            "totalCount": len(states)
        }
    }

@router.get("/data/districts/{state_id}", response_model=Dict[str, Any])
async def get_districts_by_state(state_id: str):
    """Get districts for a specific state"""
    districts = data_config.get_districts(state_id)
    return {
        "success": True,
        "data": {
            "stateId": state_id,
            "districts": districts,
            "totalCount": len(districts)
        }
    }

@router.get("/data/age-groups", response_model=Dict[str, Any])
async def get_age_groups():
    """Get all age groups"""
    age_groups = data_config.get_age_groups()
    return {
        "success": True,
        "data": age_groups
    }

@router.get("/data/genders", response_model=Dict[str, Any])
async def get_genders():
    """Get all genders"""
    genders = data_config.get_genders()
    return {
        "success": True,
        "data": genders
    }

# ==================== Data Export/Import ====================

@router.get("/data/export", response_model=Dict[str, Any])
async def export_all_data():
    """Export all data as JSON"""
    return {
        "success": True,
        "data": {
            "countries": data_config.countries,
            "states": data_config.states,
            "districts": data_config.districts,
            "languages": data_config.languages,
            "ageGroups": data_config.age_groups,
            "genders": data_config.genders,
            "sentences": data_config.sentences,
            "validationItems": data_config.validation_items
        }
    }

@router.post("/data/import", response_model=Dict[str, Any])
async def import_data(data: Dict[str, Any]):
    """Import data from JSON"""
    try:
        # This would need to be implemented in data_config.py
        # For now, just return success
        return {
            "success": True,
            "message": "Data import functionality would be implemented here"
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error importing data: {str(e)}")

# ==================== Data Statistics ====================

@router.get("/data/stats", response_model=Dict[str, Any])
async def get_data_statistics():
    """Get detailed statistics about the data"""
    return {
        "success": True,
        "data": {
            "totalCountries": len(data_config.get_countries()),
            "totalStates": sum(len(states) for states in data_config.states.values()),
            "totalDistricts": sum(len(districts) for districts in data_config.districts.values()),
            "totalLanguages": len(data_config.get_languages()),
            "totalSentences": sum(len(sentences) for sentences in data_config.sentences.values()),
            "totalValidationItems": sum(len(items) for items in data_config.validation_items.values()),
            "sentencesByLanguage": {
                language: len(sentences) 
                for language, sentences in data_config.sentences.items()
            },
            "validationItemsByLanguage": {
                language: len(items) 
                for language, items in data_config.validation_items.items()
            }
        }
    }
