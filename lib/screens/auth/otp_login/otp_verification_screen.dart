import 'package:bhashadaan/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';

import '../../../common_widgets/custom_app_bar.dart';
import '../../../constants/app_colors.dart';
import 'widgets/gradient_header.dart';
import 'widgets/otp_input_field.dart';
import 'widgets/otp_timer.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isOtpValid = ValueNotifier<bool>(false);
  String _otp = '';
  String? _errorText;

  @override
  void dispose() {
    _isLoading.dispose();
    _isOtpValid.dispose();
    super.dispose();
  }

  void _onOtpChanged(String otp) {
    setState(() {
      _otp = otp;
      _errorText = null;
    });
    _isOtpValid.value = otp.length == 6;
  }

  void _verifyOtp() {
    if (_otp.length == 6) {
      _isLoading.value = true;
      // TODO: Implement OTP verification logic
      _isLoading.value = false;
      // Navigate to Profile Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } else {
      setState(() {
        _errorText = AppLocalizations.of(context).invalidOtp;
      });
    }
  }

  void _resendOtp() {
    // TODO: Implement resend OTP logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).otpSentSuccessfullyMessage),
        backgroundColor: AppColors.lightGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const GradientHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      Text(
                        AppLocalizations.of(context).otpVerification,
                        style: GoogleFonts.notoSans(
                          color: AppColors.greys87,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "${AppLocalizations.of(context).enterOtpFromSms} ${widget.phoneNumber}",
                        style: GoogleFonts.notoSans(
                          color: AppColors.greys60,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      OtpTimer(
                        onResend: _resendOtp,
                      ),
                      SizedBox(height: 24.h),
                      OtpInputField(
                        onChanged: _onOtpChanged,
                        errorText: _errorText,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.w),
              child: Center(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isOtpValid,
                  builder: (context, isOtpValid, child) {
                    return SizedBox(
                      width: 280.w,
                      child: ElevatedButton(
                        onPressed: isOtpValid ? _verifyOtp : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOtpValid
                              ? AppColors.orange
                              : AppColors.lightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                        ),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isLoading,
                          builder: (context, isLoading, child) {
                            if (isLoading) {
                              return SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              );
                            }
                            return Text(
                              AppLocalizations.of(context).submit,
                              style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
