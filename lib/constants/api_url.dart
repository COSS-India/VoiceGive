class ApiUrl {
  static const String baseUrl = 'https://api.example.com';

  static const String getSentancesForRecordingUrl =
      '$baseUrl/contributions/get-sentences';
  static const String sumbitAudioUrl = '$baseUrl/contributions/record';
  static const String reportIssueUrl = '$baseUrl/contributions/report';
  static const String contributeSessionCompleteUrl =
      '$baseUrl/contributions/session-complete';
  static const String sendOTPUrl = '$baseUrl/auth/send-otp';
  static const String skipContributionUrl = '$baseUrl/v1/contributions/skip';
  static const String getValidationsQueUrl = '$baseUrl/validations/get-queue';
  static const String submitValidationUrl = '$baseUrl/validations/submit';
  static const String validationSessionCompleteUrl =
      '$baseUrl/validations/session-complete';
}
