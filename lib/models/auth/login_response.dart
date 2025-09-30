import 'user.dart';

/// Login response model containing authentication result
class LoginResponse {
  final int statusCode;
  final bool status;
  final String message;
  final LoginResult result;

  const LoginResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.result,
  });

  /// Create LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'] as int,
      status: json['status'] as bool,
      message: json['message'] as String,
      result: json['result'] != null 
          ? LoginResult.fromJson(json['result'] as Map<String, dynamic>)
          : LoginResult.fromJson({}), // Empty result for error cases
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'status': status,
      'message': message,
      'result': result.toJson(),
    };
  }

  /// Check if login was successful
  bool get isSuccess => status && statusCode == 201;

  @override
  String toString() {
    return 'LoginResponse(statusCode: $statusCode, status: $status, message: $message)';
  }
}

/// Login result containing user data and authentication token
class LoginResult {
  final User user;
  final String token;

  const LoginResult({
    required this.user,
    required this.token,
  });

  /// Create LoginResult from JSON
  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      user: User.fromJson(json),
      token: json['token'] as String? ?? '',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      ...user.toJson(),
      'token': token,
    };
  }

  @override
  String toString() {
    return 'LoginResult(user: ${user.userName}, token: ${token.substring(0, 20)}...)';
  }
}
