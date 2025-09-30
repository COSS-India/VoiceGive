
class ConsentResponse {
  final bool success;
  final String? message;

  const ConsentResponse({
    required this.success,
    this.message,
  });

  factory ConsentResponse.fromJson(Map<String, dynamic> json) {
    return ConsentResponse(
      success: json['success'] as bool,
      message: json['message'] ?? ''
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message
    };
  }

  @override
  String toString() {
    return 'ConsentResponse(success: $success, message: $message)';
  }
}