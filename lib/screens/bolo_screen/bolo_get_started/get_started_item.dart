import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const GetStartedItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 28.sp, color: AppColors.darkGreen),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.notoSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.w),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            description,
            style: GoogleFonts.notoSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey40,
            ),
          ),
        ),
      ],
    );
  }
}
