import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloHeadersSection extends StatelessWidget {
  const BoloHeadersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12).r,
      decoration: BoxDecoration(color: AppColors.orange),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_circle_left_outlined,
              color: Colors.white,
              size: 36.sp,
            ),
          ),
          SizedBox(width: 24.w),
          ImageWidget(
              height: 38.w,
              width: 38.w,
              imageUrl: "assets/images/bolo_icon_white.svg"),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BOLO India",
                style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 18.sp,
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
    );
  }
}
