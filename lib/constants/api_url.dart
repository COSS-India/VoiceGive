class ApiUrl {
  static const String baseUrl = 'http://43.205.235.156:9000';

  static const String getSentancesForRecordingUrl =
      '$baseUrl/contributions/get-sentences';
  static const String sumbitAudioUrl = '$baseUrl/contributions/record';
  static const String reportIssueUrl = '$baseUrl/contributions/report';
  static const String contributeSessionCompleteUrl =
      '$baseUrl/contributions/session-complete';
  static const String skipContributionUrl = '$baseUrl/contributions/skip';
  static const String getValidationsQueUrl = '$baseUrl/validations/get-queue';
  static const String submitValidationUrl = '$baseUrl/validations/submit';
  static const String validationSessionCompleteUrl =
      '$baseUrl/validations/session-complete';
  static const String getLanguages = '$baseUrl/admin/data/languages';
}
