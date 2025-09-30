class CertificateProgress {
  final int contributionsCompleted;
  final int contributionsRequired;
  final int validationsCompleted;
  final int validationsRequired;
  final bool isEligible;
  final int percentageComplete;

  CertificateProgress({
    required this.contributionsCompleted,
    required this.contributionsRequired,
    required this.validationsCompleted,
    required this.validationsRequired,
    required this.isEligible,
    required this.percentageComplete,
  });

  factory CertificateProgress.fromJson(Map<String, dynamic> json) {
    return CertificateProgress(
      contributionsCompleted: json['contributionsCompleted'] as int,
      contributionsRequired: json['contributionsRequired'] as int,
      validationsCompleted: json['validationsCompleted'] as int,
      validationsRequired: json['validationsRequired'] as int,
      isEligible: json['isEligible'] as bool,
      percentageComplete: json['percentageComplete'] as int,
    );
  }
}

class SessionCompletedData {
  final String sessionId;
  final int totalContributions;
  final int userTotalContributions;
  final CertificateProgress certificateProgress;

  SessionCompletedData({
    required this.sessionId,
    required this.totalContributions,
    required this.userTotalContributions,
    required this.certificateProgress,
  });

  factory SessionCompletedData.fromJson(Map<String, dynamic> json) {
    return SessionCompletedData(
      sessionId: json['sessionId'] as String,
      totalContributions: json['totalContributions'] as int,
      userTotalContributions: json['userTotalContributions'] as int,
      certificateProgress: CertificateProgress.fromJson(
          json['certificateProgress'] as Map<String, dynamic>),
    );
  }
}

class BoloSessionCompletedModel {
  final bool success;
  final String message;
  final SessionCompletedData data;

  BoloSessionCompletedModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BoloSessionCompletedModel.fromJson(Map<String, dynamic> json) {
    return BoloSessionCompletedModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SessionCompletedData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
