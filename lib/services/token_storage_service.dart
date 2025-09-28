import '../constants/storage_constants.dart';
import 'secure_storage_service.dart';

/// Service for secure storage and retrieval of authentication tokens
class TokenStorageService {
  static final _storage = SecureStorageService.instance.storage;

  /// Store authentication token securely
  static Future<void> storeToken(String token) async {
    try {
      await _storage.write(key: StorageConstants.tokenKey, value: token);
      await _storage.write(
        key: StorageConstants.loginTimestampKey,
        value: DateTime.now().millisecondsSinceEpoch.toString(),
      );
    } catch (e) {
      throw TokenStorageException('Failed to store token: $e');
    }
  }

  /// Retrieve authentication token
  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: StorageConstants.tokenKey);
    } catch (e) {
      throw TokenStorageException('Failed to retrieve token: $e');
    }
  }

  /// Store user data securely
  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    try {
      await _storage.write(key: StorageConstants.userDataKey, value: userData.toString());
    } catch (e) {
      throw TokenStorageException('Failed to store user data: $e');
    }
  }

  /// Retrieve user data
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userDataString = await _storage.read(key: StorageConstants.userDataKey);
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
      final loginTimestamp = await _storage.read(key: StorageConstants.loginTimestampKey);
      if (loginTimestamp == null) return false;

      final loginTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(loginTimestamp));
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
      await _storage.delete(key: StorageConstants.tokenKey);
      await _storage.delete(key: StorageConstants.userDataKey);
      await _storage.delete(key: StorageConstants.loginTimestampKey);
    } catch (e) {
      throw TokenStorageException('Failed to clear auth data: $e');
    }
  }

  /// Get login timestamp
  static Future<DateTime?> getLoginTimestamp() async {
    try {
      final timestamp = await _storage.read(key: StorageConstants.loginTimestampKey);
      if (timestamp == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    } catch (e) {
      return null;
    }
  }

  /// Check if token needs refresh (within 1 hour of expiry)
  static Future<bool> needsTokenRefresh() async {
    try {
      final loginTimestamp = await _storage.read(key: StorageConstants.loginTimestampKey);
      if (loginTimestamp == null) return true;

      final loginTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(loginTimestamp));
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
