import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import 'password_encryption_service.dart';

/// Authentication service for handling login and user authentication
class AuthService {
  static AppConfig get _config => AppConfig.instance;

  /// Login user with email and password
  static Future<LoginResponse> login(LoginRequest request) async {
    final uri = Uri.parse('${_config.apiBaseUrl}/login-user');

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    // Encrypt the password before sending to API
    final encryptedPassword = PasswordEncryptionService.encryptPassword(request.password);
    
    // Create a new request with encrypted password
    final encryptedRequest = LoginRequest(
      email: request.email,
      password: encryptedPassword,
      secureId: request.secureId,
      captchaText: request.captchaText,
    );

    print('🌐 Making login API call to: $uri');
    print('📤 Request headers: $headers');
    print('📤 Request body: ${jsonEncode(encryptedRequest.toJson())}');

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(encryptedRequest.toJson()),
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      
      // Check if the API returned an error response
      if (responseData['status'] == false || responseData['statusCode'] != 201) {
        final errorMessage = responseData['message'] ?? 'Login failed';
        final statusCode = responseData['statusCode'] ?? response.statusCode;
        throw AuthException('Status: $statusCode - $errorMessage', statusCode);
      }

      return LoginResponse.fromJson(responseData);
    } catch (e) {
      print('❌ Login API error: $e');
      if (e is AuthException) {
        rethrow;
      }
      // Network errors should also trigger captcha refresh
      throw AuthException('Status: 0 - Network error during login: $e', 0);
    }
  }

  /// Get secure captcha for login
  static Future<Map<String, dynamic>> getSecureCaptcha() async {
    final uri = Uri.parse(_config.apiEndpoints['captcha']!);

    print('🔄 Making captcha API call to: $uri');

    // Try with minimal headers first to avoid CORS issues
    final headers = _config.minimalHeaders;

    try {
      print('📤 Trying captcha with minimal headers: $headers');
      final response = await http.get(uri, headers: headers);
      print('📥 Captcha response status: ${response.statusCode}');
      print('📥 Captcha response body: ${response.body}');
      
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw AuthException(
          'Captcha API failed: ${response.statusCode} ${response.body}',
          response.statusCode,
        );
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print('❌ Captcha API error with minimal headers: $e');
      // If still fails, try with more headers
      final fullHeaders = _config.defaultHeaders;
      
      try {
        print('📤 Trying captcha with full headers: $fullHeaders');
        final response = await http.get(uri, headers: fullHeaders);
        print('📥 Captcha response status: ${response.statusCode}');
        print('📥 Captcha response body: ${response.body}');
        
        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw AuthException(
            'Captcha API failed: ${response.statusCode} ${response.body}',
            response.statusCode,
          );
        }
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e2) {
        print('❌ Captcha API error with full headers: $e2');
        // Final fallback - try with no headers at all
        try {
          print('📤 Trying captcha with no headers');
          final response = await http.get(uri);
          print('📥 Captcha response status: ${response.statusCode}');
          print('📥 Captcha response body: ${response.body}');
          
          if (response.statusCode < 200 || response.statusCode >= 300) {
            throw AuthException(
              'Captcha API failed: ${response.statusCode} ${response.body}',
              response.statusCode,
            );
          }
          return jsonDecode(response.body) as Map<String, dynamic>;
        } catch (e3) {
          print('❌ Captcha API error with no headers: $e3');
          throw AuthException('Failed to get captcha: $e3', 0);
        }
      }
    }
  }

  /// Validate login credentials format
  static bool validateLoginRequest(LoginRequest request) {
    if (request.email.isEmpty || !request.email.contains('@')) {
      return false;
    }
    if (request.password.isEmpty) {
      return false;
    }
    if (request.secureId.isEmpty) {
      return false;
    }
    if (request.captchaText.isEmpty) {
      return false;
    }
    return true;
  }
}

/// Custom exception for authentication errors
class AuthException implements Exception {
  final String message;
  final int statusCode;

  const AuthException(this.message, this.statusCode);

  @override
  String toString() {
    return 'AuthException: $message (Status: $statusCode)';
  }
}
