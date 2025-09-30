/// Login request model for authentication
class LoginRequest {
  final String email;
  final String password;
  final String secureId;
  final String captchaText;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.secureId,
    required this.captchaText,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'secureId': secureId,
      'captchaText': captchaText,
    };
  }

  /// Create from JSON (if needed for testing or debugging)
  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      secureId: json['secureId'] as String,
      captchaText: json['captchaText'] as String,
    );
  }

  @override
  String toString() {
    return 'LoginRequest(email: $email, secureId: $secureId, captchaText: $captchaText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginRequest &&
        other.email == email &&
        other.password == password &&
        other.secureId == secureId &&
        other.captchaText == captchaText;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        secureId.hashCode ^
        captchaText.hashCode;
  }
}
