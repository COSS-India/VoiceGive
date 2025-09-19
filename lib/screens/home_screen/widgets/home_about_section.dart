import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAboutSection extends StatefulWidget {
  const HomeAboutSection({super.key});

  @override
  State<HomeAboutSection> createState() => _HomeAboutSectionState();
}

class _HomeAboutSectionState extends State<HomeAboutSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is AgriDaan?",
          style: GoogleFonts.notoSans(
            color: AppColors.darkGreen,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.w),
        Text(
          "Agridaan is an initiative to crowdsource agriculture-related knowledge from citizens across India as part of Project BHASHINI. It calls upon people to contribute local terms, practices, and insights to build an open repository of agricultural data, helping to digitally enrich and preserve India’s diverse farming heritage.",
          style: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
