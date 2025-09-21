import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/primary_button_widget.dart';
import '../../../constants/app_colors.dart';
import 'widgets/gradient_header.dart';
import 'widgets/phone_input_field.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.invalidPhoneNumber;
    }
    if (value.length != 10) {
      return AppLocalizations.of(context)!.invalidPhoneNumber;
    }
    return null;
  }

  void _requestOtp() {
    if (_formKey.currentState!.validate()) {
      _isLoading.value = true;
      // TODO: Implement OTP request logic
      Future.delayed(const Duration(seconds: 2), () {
        _isLoading.value = false;
        // TODO: Navigate to OTP verification screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GradientHeader(),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify your\nphone number",
                      style: GoogleFonts.notoSans(
                        color: AppColors.greys87,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    Text(
                      AppLocalizations.of(context)!.otpSentMessage,
                      style: GoogleFonts.notoSans(
                        color: AppColors.greys60,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 32.w),
                    PhoneInputField(
                      controller: _phoneController,
                      validator: _validatePhoneNumber,
                    ),
                    SizedBox(height: 32.w),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _requestOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6).r,
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
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              );
                            }
                            return Text(
                              AppLocalizations.of(context)!.getOtp,
                              style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
