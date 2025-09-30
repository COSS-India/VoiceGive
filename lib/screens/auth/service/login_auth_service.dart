import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constants/api_url.dart';
class LoginAuthService {
  static Future<dynamic> sendOtp({required String mobileNo, required String countryCode}) async {
    
    Map body = {
      'mobileNo': mobileNo,
      'countryCode': countryCode
    };

    final response = await http.post(
        Uri.parse(ApiUrl.sendOTPUrl),
        body: body);
    Map convertedResponse = json.decode(response.body);

    return convertedResponse;
  }
}