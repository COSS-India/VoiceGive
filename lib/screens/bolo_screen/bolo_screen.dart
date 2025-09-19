import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/actions_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_content_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/language_selection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloScreen extends StatefulWidget {
  const BoloScreen({super.key});

  @override
  State<BoloScreen> createState() => _BoloScreenState();
}

class _BoloScreenState extends State<BoloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16).r,
                  decoration: BoxDecoration(color: AppColors.orange),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.white,
                        size: 36.sp,
                      ),
                      SizedBox(width: 24.w),
                      ImageWidget(
                          height: 40.w,
                          width: 40.w,
                          imageUrl: "assets/images/bolo_icon_white.svg"),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BOLO India",
                            style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Enrich your language by donating your voice. ",
                            style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0).r,
                  child: Column(
                    children: [
                      ActionsSection(),
                      SizedBox(height: 16.w),
                      LanguageSelection(),
                      SizedBox(height: 24.w),
                      BoloContentSection(),
                    ],
                  ),
                ),
              ],
            )));
  }
}
