class CertificateProgress {
  final int contributionsCompleted;
  final int contributionsRequired;
  final int validationsCompleted;
  final int validationsRequired;
  final bool isEligible;
  final bool certificateAvailable;

  CertificateProgress({
    required this.contributionsCompleted,
    required this.contributionsRequired,
    required this.validationsCompleted,
    required this.validationsRequired,
    required this.isEligible,
    required this.certificateAvailable,
  });

  factory CertificateProgress.fromJson(Map<String, dynamic> json) {
    return CertificateProgress(
      contributionsCompleted: json['contributionsCompleted'] as int,
      contributionsRequired: json['contributionsRequired'] as int,
      validationsCompleted: json['validationsCompleted'] as int,
      validationsRequired: json['validationsRequired'] as int,
      isEligible: json['isEligible'] as bool,
      certificateAvailable: json['certificateAvailable'] as bool,
    );
  }
}

class SessionCompletedData {
  final String sessionId;
  final int totalValidations;
  final int userTotalValidations;
  final CertificateProgress certificateProgress;

  SessionCompletedData({
    required this.sessionId,
    required this.totalValidations,
    required this.userTotalValidations,
    required this.certificateProgress,
  });

  factory SessionCompletedData.fromJson(Map<String, dynamic> json) {
    return SessionCompletedData(
      sessionId: json['sessionId'] as String,
      totalValidations: json['totalValidations'] as int,
      userTotalValidations: json['userTotalValidations'] as int,
      certificateProgress: CertificateProgress.fromJson(
          json['certificateProgress'] as Map<String, dynamic>),
    );
  }
}

class SessionCompletedModel {
  final bool success;
  final String message;
  final SessionCompletedData data;

  SessionCompletedModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SessionCompletedModel.fromJson(Map<String, dynamic> json) {
    return SessionCompletedModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SessionCompletedData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
