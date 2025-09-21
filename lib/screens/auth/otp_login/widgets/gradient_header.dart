import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';

class GradientHeader extends StatelessWidget {
  const GradientHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16).r,
      decoration: BoxDecoration(color: AppColors.orange),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_circle_left_outlined,
              color: Colors.white,
              size: 36.sp,
            ),
          ),
          SizedBox(width: 24.w),
          Text(
            "Login",
            style: GoogleFonts.notoSans(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
