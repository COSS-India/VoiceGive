import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';

class CaptchaWidget extends StatelessWidget {
  final String captchaText;
  final TextEditingController controller;
  final VoidCallback onRefresh;
  final String? Function(String?)? validator;

  const CaptchaWidget({
    super.key,
    required this.captchaText,
    required this.controller,
    required this.onRefresh,
    this.validator,
  });

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
              child: Center(
                child: Stack(
                  children: [
                    // Strike-through line
                    Positioned(
                      top: 24.h,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2.h,
                        color: AppColors.greys87,
                      ),
                    ),
                    // CAPTCHA Text
                    Text(
                      captchaText,
                      style: GoogleFonts.notoSans(
                        color: AppColors.greys87,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // Refresh Button
            GestureDetector(
              onTap: onRefresh,
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
                  controller: controller,
                  validator: validator,
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
