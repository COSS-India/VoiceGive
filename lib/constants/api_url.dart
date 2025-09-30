class ApiUrl {
  static const String baseUrl = 'http://43.205.235.156:9000';

  static const String getSentancesForRecordingUrl =
      '$baseUrl/contributions/get-sentences';
  static const String sumbitAudioUrl = '$baseUrl/contributions/record';
  static const String reportIssueUrl = '$baseUrl/contributions/report';
  static const String contributeSessionCompleteUrl =
      '$baseUrl/contributions/session-complete';
  static const String sendOTPUrl = '$baseUrl/auth/send-otp';
  static const String resendOTPUrl = '$baseUrl/auth/resend-otp';
  static const String verifyOTPUrl = '$baseUrl/auth/verify-otp';
  static const String skipContributionUrl = '$baseUrl/v1/contributions/skip';
  static const String getValidationsQueUrl = '$baseUrl/validations/get-queue';
  static const String submitValidationUrl = '$baseUrl/validations/submit';
  static const String validationSessionCompleteUrl =
      '$baseUrl/validations/session-complete';
  static const String userRegisterUrl = '$baseUrl/users/register';
  static const String ageGroupUrl = '$baseUrl/admin/data/age-groups';
  static const String genderUrl = '$baseUrl/admin/data/genders';
  static const String countryUrl = '$baseUrl/admin/data/countries';
  static const String stateUrl = '$baseUrl/admin/data/states/';
  static const String districtUrl = '$baseUrl/admin/data/districts/';
  static const String languageUrl = '$baseUrl/admin/data/languages';
}
