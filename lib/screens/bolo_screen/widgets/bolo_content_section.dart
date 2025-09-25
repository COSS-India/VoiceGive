import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/recording_icon.dart';
import 'package:bhashadaan/services/api_service.dart';
import 'package:bhashadaan/screens/validation_screen/validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloContentSection extends StatefulWidget {
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  final String recordedText;
  final int sentenceId;
  final VoidCallback onLanguageChanged;

  const BoloContentSection({
    super.key,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
    required this.recordedText,
    required this.sentenceId,
    required this.onLanguageChanged,
  });

  @override
  State<BoloContentSection> createState() => _BoloContentSectionState();
}

class _BoloContentSectionState extends State<BoloContentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12).r,
      decoration: BoxDecoration(
          color: AppColors.lightGreen3,
          borderRadius: BorderRadius.circular(8).r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Text(
                "${widget.currentIndex}/${widget.totalItems}",
                style: GoogleFonts.notoSans(
                    fontSize: 12.sp,
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          Container(
            height: 5.w,
            width: 1.sw,
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
              borderRadius: BorderRadius.circular(4).r,
            ),
          ),
          SizedBox(height: 24.w),
          Padding(
            padding: EdgeInsets.only(left: 32, right: 32).r,
            child: Text(
              widget.recordedText,
              style: GoogleFonts.notoSans(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50.w),
          RecordingButton(),
          SizedBox(height: 50.w),
          actionButtons(),
          SizedBox(height: 50.w),
        ],
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.w,
          width: 120.w,
          child: PrimaryButtonWidget(
            title: "Skip",
            textFontSize: 16.sp,
            onTap: () async {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Skipping current sentence...')),
              );

              try {
                final response = await ApiService.skip(
                  device: 'Linux null',
                  browser: 'Chrome 140.0.0.0',
                  userName: 'Supriya',
                  language: widget.selectedLanguage,
                  sentenceId: widget.sentenceId,
                  stateRegion: 'Karnataka',
                  userNum: 5742,
                  country: 'India',
                  latitude: 12.9753,
                  longitude: 77.591,
                  type: 'text',
                );

                if (!mounted) return;

                if (response.statusCode >= 200 && response.statusCode < 300) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Skipped successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Skip failed: ${response.statusCode}')),
                  );
                }
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            textColor: AppColors.orange,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.orange),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
        SizedBox(width: 24.w),
        SizedBox(
          height: 40.w,
          width: 120.w,
          child: PrimaryButtonWidget(
            title: "Submit",
            textFontSize: 16.sp,
            onTap: () {
              print("Submit button tapped!");
              print("Recorded text: ${widget.recordedText}");
              print("Selected language: ${widget.selectedLanguage}");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ValidationScreen(
                    recordedText: widget.recordedText,
                    selectedLanguage: widget.selectedLanguage,
                    currentIndex: widget.currentIndex,
                    totalItems: widget.totalItems,
                    sentenceId: widget.sentenceId,
                  ),
                ),
              ).then((_) {
                print("ValidationScreen navigation completed");
              }).catchError((error) {
                print("ValidationScreen navigation error: $error");
              });
            },
            textColor: Colors.white,
            decoration: BoxDecoration(
              color: AppColors.orange,
              border: Border.all(color: AppColors.orange),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
      ],
    );
  }
}
