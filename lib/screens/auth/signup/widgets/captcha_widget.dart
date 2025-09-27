import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';

class CaptchaWidget extends StatefulWidget {
  final String captchaText;
  final VoidCallback onRefresh;
  final ValueChanged<String> onChanged;

  const CaptchaWidget({
    super.key,
    required this.captchaText,
    required this.onRefresh,
    required this.onChanged,
  });

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CAPTCHA",
          style: GoogleFonts.notoSans(
            color: AppColors.greys87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            // CAPTCHA Image Container
            Container(
              width: 120.w,
              height: 40.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lightGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6.r),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  widget.captchaText,
                  style: GoogleFonts.notoSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greys87,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // Refresh Button
            GestureDetector(
              onTap: widget.onRefresh,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.refresh,
                  color: AppColors.greys60,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // CAPTCHA Input Field
            Expanded(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.lightGrey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: GoogleFonts.notoSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greys87,
                  ),
                  decoration: InputDecoration(
                    hintText: "*Enter CAPTCHA",
                    hintStyle: GoogleFonts.notoSans(
                      color: AppColors.greys60,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    isDense: true,
                  ),
                  onChanged: (value) {
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
