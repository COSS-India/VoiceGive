import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_colors.dart';
import '../../../../services/api_service.dart';

class CaptchaWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String) onCaptchaIdChanged;

  const CaptchaWidget({
    super.key,
    required this.controller,
    required this.onCaptchaIdChanged,
    this.validator,
  });

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  String? _captchaSvg;
  String? _captchaId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCaptcha();
  }

  Future<void> _loadCaptcha() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.getSecureCaptcha();
      if (response['message'] == 'Successful' && response['data'] != null) {
        setState(() {
          _captchaSvg = response['data']['secureCapSvg'];
          _captchaId = response['data']['secureCapId'];
          _isLoading = false;
        });
        widget.onCaptchaIdChanged(_captchaId ?? '');
      } else {
        setState(() {
          _isLoading = false;
        });
        _showError('Failed to load captcha - Invalid response');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Error loading captcha. Please try again.');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.negativeLight,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // CAPTCHA Image
            Container(
              width: 120.w,
              height: 48.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGrey),
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.lightGrey.withOpacity(0.3),
              ),
              child: _isLoading
                  ? Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkBlue),
                        ),
                      ),
                    )
                  : _captchaSvg != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: SvgPicture.string(
                            _captchaSvg!,
                            width: 120.w,
                            height: 48.h,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.error_outline,
                            color: AppColors.negativeLight,
                            size: 20.sp,
                          ),
                        ),
            ),
            SizedBox(width: 12.w),
            
            // Refresh Button
            GestureDetector(
              onTap: _loadCaptcha,
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.refresh,
                  color: AppColors.grey40,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // CAPTCHA Input Field
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: TextFormField(
                  controller: widget.controller,
                  validator: widget.validator,
                  decoration: InputDecoration(
                    labelText: '*Enter CAPTCHA',
                    labelStyle: GoogleFonts.notoSans(
                      color: AppColors.greys87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: AppColors.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: AppColors.darkBlue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: AppColors.negativeLight),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: AppColors.negativeLight),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  style: GoogleFonts.notoSans(
                    color: AppColors.greys87,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
