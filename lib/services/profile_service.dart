import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:bhashadaan/models/profile_model.dart';

class ProfileService {
  static const String _baseUrl = 'https://api-servic3.bhashini.co.in/api';

  static const String _authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjU4NzcsInVzZXJOYW1lIjoiR2VvIEpvc2VwaCAgIiwiaWF0IjoxNzU4Nzc4OTg5LCJleHAiOjE3NTg4NjUzODl9.Fqd2SBDT_bv7q2_Nvm5o3tCioPXA0X2KohDITm5Y4zw';
  static const int _userNum = 5877;

  static final Dio _dio = Dio();

  static void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['authorization'] = 'Bearer $_authToken';
          options.headers['accept'] = 'application/json, text/plain, */*';
          options.headers['content-type'] = 'application/json';
          options.headers['origin'] = 'https://bhashini.gov.in';
          options.headers['referer'] = 'https://bhashini.gov.in/';
          options.headers['user-agent'] = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36';
          handler.next(options);
        },
        onError: (error, handler) {
          // Log API errors for debugging
          debugPrint('API Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  /// Fetch user profile details
  static Future<ProfileResponse> fetchProfile() async {
    try {
      _setupInterceptors();
      
      final response = await _dio.post(
        '$_baseUrl/my-profile',
        data: {'userNum': _userNum},
      );

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('API Error: ${e.response?.data}');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Update user profile details
  static Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest request) async {
    try {
      _setupInterceptors();
      
      // Create FormData for multipart/form-data request
      final formData = FormData.fromMap({
        'profile_photo': request.profilePhoto ?? 'null',
        'firstName': request.firstName,
        'age': request.age,
        'gender': request.gender,
        'mobileNo': request.mobileNo,
        'country': request.country,
        'district': request.district,
        'preferredLanguage': request.preferredLanguage,
        'userNum': request.userNum,
        'email': request.email,
      });

      final response = await _dio.post(
        '$_baseUrl/update-profile',
        data: formData,
        options: Options(
          headers: {
            'content-type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return UpdateProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('API Error: ${e.response?.data}');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Helper method to convert age group string to age number
  static int convertAgeGroupToAge(String ageGroup) {
    switch (ageGroup) {
      case 'Under 18 years':
        return 17;
      case '18-24 years':
        return 21;
      case '25-34 years':
        return 30;
      case '35-44 years':
        return 40;
      case '45-54 years':
        return 50;
      case '55-64 years':
        return 60;
      case '65+ years':
        return 70;
      default:
        return 25; // Default age
    }
  }

  /// Helper method to convert age number to age group string
  static String convertAgeToAgeGroup(int age) {
    if (age < 18) return 'Under 18 years';
    if (age >= 18 && age <= 24) return '18-24 years';
    if (age >= 25 && age <= 34) return '25-34 years';
    if (age >= 35 && age <= 44) return '35-44 years';
    if (age >= 45 && age <= 54) return '45-54 years';
    if (age >= 55 && age <= 64) return '55-64 years';
    return '65+ years';
  }
}
