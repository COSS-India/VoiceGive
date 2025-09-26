import '../services/token_storage_service.dart';

/// Singleton service for managing authentication tokens across the app
class AuthManager {
  static AuthManager? _instance;
  static AuthManager get instance {
    _instance ??= AuthManager._internal();
    return _instance!;
  }

  AuthManager._internal();

  String? _currentToken;

  /// Initialize the auth manager by loading stored token
  Future<void> initialize() async {
    try {
      _currentToken = await TokenStorageService.getToken();
    } catch (e) {
      _currentToken = null;
    }
  }

  /// Set the current authentication token
  void setToken(String token) {
    _currentToken = token;
  }

  /// Get the current authentication token
  String? getToken() {
    return _currentToken;
  }

  /// Clear the current token
  void clearToken() {
    _currentToken = null;
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _currentToken != null && _currentToken!.isNotEmpty;

  /// Get authorization header value
  String? get authorizationHeader {
    if (_currentToken == null || _currentToken!.isEmpty) return null;
    return 'Bearer $_currentToken';
  }
}
