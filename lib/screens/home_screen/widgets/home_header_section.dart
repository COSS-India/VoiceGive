import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/auth/otp_login/otp_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16).r,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Empower India's \nLinguistic Diversity",
                style: GoogleFonts.notoSans(
                    color: AppColors.darkBlue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              ImageWidget(
                imageUrl: "assets/images/home_header_image.png",
                height: 110.w,
                width: 110.w,
              ),
              SizedBox(width: 24.w),
            ],
          ),
          SizedBox(height: 12.w),
          Text(
            "Join the movement to enhance language understanding and accessiblity for all 22 official languages in India",
            style: GoogleFonts.notoSans(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 12.w),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OtpLoginScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6).r,
              ),
            ),
            child: Text(
              "Let’s Get Started",
              style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(height: 8.w),
        ],
      ),
    );
  }
}
