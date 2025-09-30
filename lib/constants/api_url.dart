class ApiUrl {
  static const String baseUrl = 'https://api.example.com';

  static const String getSentancesForRecordingUrl =
      '$baseUrl/contributions/get-sentences';
  static const String sumbitAudioUrl = '$baseUrl/contributions/record';
  static const String reportIssueUrl = '$baseUrl/contributions/report';
  static const String sessionCompleteUrl =
      '$baseUrl/contributions/session-complete';
  static const String sendOTPUrl = '$baseUrl/auth/send-otp';
}