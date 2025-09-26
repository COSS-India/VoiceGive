import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for secure storage and retrieval of authentication tokens
class TokenStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _loginTimestampKey = 'login_timestamp';

  /// Store authentication token securely
  static Future<void> storeToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(
        key: _loginTimestampKey,
        value: DateTime.now().millisecondsSinceEpoch.toString(),
      );
    } catch (e) {
      throw TokenStorageException('Failed to store token: $e');
    }
  }

  /// Retrieve authentication token
  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      throw TokenStorageException('Failed to retrieve token: $e');
    }
  }

  /// Store user data securely
  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    try {
      await _storage.write(key: _userDataKey, value: userData.toString());
    } catch (e) {
      throw TokenStorageException('Failed to store user data: $e');
    }
  }

  /// Retrieve user data
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userDataString = await _storage.read(key: _userDataKey);
      if (userDataString == null) return null;
      
      // Parse the stored user data
      // Note: In a real implementation, you might want to use JSON encoding/decoding
      // For now, we'll return null and handle user data through the auth state
      return null;
    } catch (e) {
      throw TokenStorageException('Failed to retrieve user data: $e');
    }
  }

  /// Check if user is logged in (has valid token)
  static Future<bool> isLoggedIn() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) return false;
      
      // Check if token is not expired (basic check)
      final loginTimestamp = await _storage.read(key: _loginTimestampKey);
      if (loginTimestamp == null) return false;
      
      final loginTime = DateTime.fromMillisecondsSinceEpoch(int.parse(loginTimestamp));
      final now = DateTime.now();
      
      // Token expires after 24 hours (you can adjust this based on your JWT expiry)
      final tokenAge = now.difference(loginTime);
      return tokenAge.inHours < 24;
    } catch (e) {
      return false;
    }
  }

  /// Clear all stored authentication data
  static Future<void> clearAuthData() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _userDataKey);
      await _storage.delete(key: _loginTimestampKey);
    } catch (e) {
      throw TokenStorageException('Failed to clear auth data: $e');
    }
  }

  /// Get login timestamp
  static Future<DateTime?> getLoginTimestamp() async {
    try {
      final timestamp = await _storage.read(key: _loginTimestampKey);
      if (timestamp == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    } catch (e) {
      return null;
    }
  }

  /// Check if token needs refresh (within 1 hour of expiry)
  static Future<bool> needsTokenRefresh() async {
    try {
      final loginTimestamp = await _storage.read(key: _loginTimestampKey);
      if (loginTimestamp == null) return true;
      
      final loginTime = DateTime.fromMillisecondsSinceEpoch(int.parse(loginTimestamp));
      final now = DateTime.now();
      
      // Consider token needs refresh if it's been more than 23 hours
      final tokenAge = now.difference(loginTime);
      return tokenAge.inHours >= 23;
    } catch (e) {
      return true;
    }
  }
}

/// Custom exception for token storage errors
class TokenStorageException implements Exception {
  final String message;

  const TokenStorageException(this.message);

  @override
  String toString() {
    return 'TokenStorageException: $message';
  }
}
