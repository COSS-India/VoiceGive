import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_app_bar.dart';
import '../../../constants/app_colors.dart';
import '../../bolo_screen/bolo_screen.dart';
import '../otp_login/widgets/gradient_header.dart';
import 'widgets/captcha_widget.dart';
import 'widgets/custom_text_field.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _captchaText = '';

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _captchaController.dispose();
    _isLoading.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  void _generateCaptcha() {
    setState(() {
      _captchaText = _generateRandomString(4);
      _captchaController.clear();
    });
  }

  String _generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(DateTime.now().millisecondsSinceEpoch % chars.length)),
    );
  }


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? _validateCaptcha(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter CAPTCHA";
    }
    if (value.toUpperCase() != _captchaText.toUpperCase()) {
      return "Invalid CAPTCHA";
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _isLoading.value = true;
      // TODO: Implement login logic
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _isLoading.value = false;
        // Navigate to Bolo screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BoloScreen()),
        );
        }
      });
    }
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void _forgotPassword() {
    // TODO: Implement forgot password logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Forgot password functionality coming soon!'),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login into your\nBhasha Daan Account",
                          style: GoogleFonts.notoSans(
                            color: AppColors.greys87,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Enter your ",
                                style: GoogleFonts.notoSans(
                                  color: AppColors.greys60,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "email and password",
                                style: GoogleFonts.notoSans(
                                  color: AppColors.greys60,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: " to access your account.",
                                style: GoogleFonts.notoSans(
                                  color: AppColors.greys60,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.w),
                        
                        // Email Field
                        CustomTextField(
                          controller: _emailController,
                          label: '*Email ID',
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        SizedBox(height: 20.h),
                        
                        // Password Field
                        ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordVisible,
                          builder: (context, isPasswordVisible, child) {
                            return CustomTextField(
                              controller: _passwordController,
                              label: '*Password',
                              obscureText: !isPasswordVisible,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _isPasswordVisible.value = !isPasswordVisible;
                                },
                                child: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: AppColors.grey40,
                                  size: 20.sp,
                                ),
                              ),
                              validator: _validatePassword,
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        
                        // CAPTCHA Section
                        CaptchaWidget(
                          captchaText: _captchaText,
                          controller: _captchaController,
                          onRefresh: _generateCaptcha,
                          validator: _validateCaptcha,
                        ),
                        SizedBox(height: 20.h),
                        
                        // Forgot Password and Sign Up Links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: _forgotPassword,
                              child: Text(
                                'Forgot Password',
                                style: GoogleFonts.notoSans(
                                  color: AppColors.darkBlue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Doesn't have an account? ",
                                  style: GoogleFonts.notoSans(
                                    color: AppColors.greys60,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _navigateToSignup,
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.notoSans(
                                      color: AppColors.darkBlue,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.w),
              child: Center(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isLoading,
                  builder: (context, isLoading, child) {
                    return SizedBox(
                      width: 280.w,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                'LOGIN',
                                style: GoogleFonts.notoSans(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
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
