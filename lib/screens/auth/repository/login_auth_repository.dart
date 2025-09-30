import 'package:flutter/material.dart';

import '../service/login_auth_service.dart';

class LoginAuthRepository {
  // Implementation of login authentication repository
  Future<dynamic> sendOtp(String mobileNo, String countryCode) async {
    // Call the LoginAuthService to send the OTP
    try{
      var response = await LoginAuthService.sendOtp(mobileNo: mobileNo, countryCode: countryCode);
    return response;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }

  }
}