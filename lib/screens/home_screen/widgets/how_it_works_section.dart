import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How it Works",
          style: GoogleFonts.notoSans(
            color: AppColors.darkGreen,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardWidget(
                title: "Contribute",
                description: "Speak clearly and record the displayed sentence",
                icon: Icons.touch_app_outlined),
            cardWidget(
                title: "Validate",
                description:
                    "Listen carefully and confirm if the recording matches the text",
                icon: Icons.check_circle_outline),
            cardWidget(
                title: "Earn ertificate",
                description:
                    "Earn your certificate after completing 5 contributions and 25 validations.",
                icon: Icons.badge_sharp)
          ],
        ),
      ],
    );
  }

  Widget cardWidget(
      {required String title,
      required String description,
      required IconData icon}) {
    return Container(
      width: 120.w,
      height: 156.w,
      padding: EdgeInsets.all(10).r,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreen),
        color: AppColors.lightGreen2,
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.darkGreen,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.sp,
              )),
          SizedBox(height: 6.w),
          Text(
            title,
            style: GoogleFonts.notoSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.w),
          Text(
            description,
            style: GoogleFonts.notoSans(
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
