import 'package:bhashadaan/common_widgets/branding_alignment_widget.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeFooterSection extends StatelessWidget {
  const HomeFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // White logo section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLogo('assets/images/negd_logo.png'),
              _buildLogo('assets/images/meity_logo.png'),
              _buildLogo('assets/images/npi_logo.png'),
              _buildLogo('assets/images/mygov_logo.png'),
            ],
          ),
        ),
        // Dark blue footer section
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          color: Color.fromRGBO(15, 25, 65, 1), // Much darker navy blue
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main heading
              Text(
                AppLocalizations.of(context)!.digitalIndiaBhashiniDivision,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.w),
              // Branding alignment
              BrandingAlignmentWidget(
                fontSize: 14.sp,
                textColor: Colors.white,
              ),
              SizedBox(height: 12.w),
              // Address
              Text(
                AppLocalizations.of(context)!.electronicsNiketanAddress,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 16.w),
              // Powered by section
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.poweredBy,
                    style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  ImageWidget(
                    imageUrl: 'assets/images/digital_india_logo.png',
                    height: 40.w,
                    width: 80.w,
                  ),
                ],
              ),
              SizedBox(height: 16.w),
              // Additional information
              Text(
                AppLocalizations.of(context)!.digitalIndiaCorporation,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 4.w),
              Text(
                AppLocalizations.of(context)!.ministryOfElectronicsIt,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 4.w),
              Text(
                AppLocalizations.of(context)!.governmentOfIndia,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 40.w),
              // Separator line
              Container(
                height: 2.w,
                width: double.infinity,
                color: Colors.white,
              ),
              SizedBox(height: 20.w),
              // Copyright notice
              Center(
                child: Text(
                  AppLocalizations.of(context)!.copyrightNotice,
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(String imagePath) {
    return Container(
      height: 50.w,
      width: 60.w,
      child: ImageWidget(
        imageUrl: imagePath,
        boxFit: BoxFit.contain,
      ),
    );
  }
}
