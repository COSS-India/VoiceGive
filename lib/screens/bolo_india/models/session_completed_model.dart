class CertificateProgress {
  final int? contributionsCompleted;
  final int? contributionsRequired;
  final int? validationsCompleted;
  final int? validationsRequired;
  final bool? isEligible;
  final bool? certificateAvailable;

  CertificateProgress({
    this.contributionsCompleted,
    this.contributionsRequired,
    this.validationsCompleted,
    this.validationsRequired,
    this.isEligible,
    this.certificateAvailable,
  });

  factory CertificateProgress.fromJson(Map<String, dynamic> json) {
    return CertificateProgress(
      contributionsCompleted: json['contributionsCompleted'],
      contributionsRequired: json['contributionsRequired'],
      validationsCompleted: json['validationsCompleted'],
      validationsRequired: json['validationsRequired'],
      isEligible: json['isEligible'],
      certificateAvailable: json['certificateAvailable'],
    );
  }
}

class SessionCompletedData {
  final String sessionId;
  final int? totalValidations;
  final int? userTotalValidations;
  final CertificateProgress certificateProgress;

  SessionCompletedData({
    required this.sessionId,
    this.totalValidations,
    this.userTotalValidations,
    required this.certificateProgress,
  });

  factory SessionCompletedData.fromJson(Map<String, dynamic> json) {
    return SessionCompletedData(
      sessionId: json['sessionId'] as String,
      totalValidations: json['totalValidations'] ?? json['totalContributions'],
      userTotalValidations:
          json['userTotalValidations'] ?? json['userTotalContribution'],
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
