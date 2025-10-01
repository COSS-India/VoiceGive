class ValidationSubmitData {
  final String validationId;
  final int sequenceNumber;
  final int totalInSession;
  final int remainingInSession;
  final int progressPercentage;

  ValidationSubmitData({
    required this.validationId,
    required this.sequenceNumber,
    required this.totalInSession,
    required this.remainingInSession,
    required this.progressPercentage,
  });

  factory ValidationSubmitData.fromJson(Map<String, dynamic> json) {
    return ValidationSubmitData(
      validationId: json['validationId'] as String,
      sequenceNumber: json['sequenceNumber'] as int,
      totalInSession: json['totalInSession'] as int,
      remainingInSession: json['remainingInSession'] as int,
      progressPercentage: json['progressPercentage'] as int,
    );
  }
}

class ValidationSubmitResponseModel {
  final bool success;
  final String message;
  final ValidationSubmitData data;

  ValidationSubmitResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ValidationSubmitResponseModel.fromJson(Map<String, dynamic> json) {
    return ValidationSubmitResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ValidationSubmitData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
