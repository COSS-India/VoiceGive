import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NeedMoreInfo extends StatelessWidget {
  const NeedMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        // color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/need_help_banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Need More Info?',
            style: GoogleFonts.notoSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Write your concern to us and we will get back to you.',
            style: GoogleFonts.notoSans(fontSize: 14.sp, color: Colors.white),
          ),
          SizedBox(height: 16.w),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6).r,
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Contact Us",
                    style: GoogleFonts.notoSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
