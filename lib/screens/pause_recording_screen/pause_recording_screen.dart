import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/replay_recording_screen/replay_recording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PauseRecordingScreen extends StatefulWidget {
  final String recordedText;
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  
  const PauseRecordingScreen({
    super.key,
    required this.recordedText,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
  });

  @override
  State<PauseRecordingScreen> createState() => _PauseRecordingScreenState();
}

class _PauseRecordingScreenState extends State<PauseRecordingScreen> {
  bool isPlaying = true; // Start as playing to show pause button
  bool isCorrect = false;
  bool isIncorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 
                      MediaQuery.of(context).padding.top - 
                      kToolbarHeight,
          ),
          child: Column(
            children: [
            // Header Section - Same as Bolo Screen
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
                    imageUrl: "assets/images/bolo_icon_white.svg",
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BOLO India",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Enrich your language by donating your voice. ",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Content Section
            Padding(
              padding: const EdgeInsets.all(12.0).r,
              child: Column(
                children: [
                  _buildActionButtons(),
                  SizedBox(height: 24.w),
                  _buildLanguageSelection(),
                  SizedBox(height: 40.w),
                  _buildPauseRecordingContent(),
                  SizedBox(height: 40.w),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen2,
        border: Border.all(color: AppColors.lightGreen),
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _actionButton(
            onTap: () {},
            title: "Quick Tips",
            icon: Icons.lightbulb_outline,
          ),
          _actionButton(
            onTap: () {},
            title: "Report",
            icon: Icons.report_outlined,
          ),
          _actionButton(
            onTap: () {},
            title: "Test Speakers",
            icon: Icons.volume_up_outlined,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required VoidCallback? onTap,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8).r,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.darkGreen),
          borderRadius: BorderRadius.circular(8).r,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.darkGreen,
              size: 16.sp,
              weight: 600,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: GoogleFonts.notoSans(
                color: AppColors.darkGreen,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return Row(
      children: [
        Text(
          "Select the language for validation",
          style: GoogleFonts.notoSans(
            fontSize: 14.sp,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: Row(
            children: [
              Text(
                widget.selectedLanguage,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPauseRecordingContent() {
    return Container(
      padding: EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen3,
        borderRadius: BorderRadius.circular(12).r,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress Indicator and Counter
          Row(
            children: [
              // Progress Bar
              Expanded(
                child: Container(
                  height: 4.w,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(2).r,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "${widget.currentIndex}/${widget.totalItems}",
                style: GoogleFonts.notoSans(
                  fontSize: 14.sp,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.w),
          
          // Recorded Text
          Text(
            widget.recordedText,
            style: GoogleFonts.notoSans(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.w),
          
          // Pause Recording Section
          _buildPauseRecordingSection(),
          SizedBox(height: 32.w),
          
          // Validation Buttons
          _buildValidationButtons(),
        ],
      ),
    );
  }

  Widget _buildPauseRecordingSection() {
    return Column(
      children: [
        Text(
          "Pause Recording",
          style: GoogleFonts.notoSans(
            fontSize: 16.sp,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.w),
        GestureDetector(
          onTap: () {
            setState(() {
              isPlaying = !isPlaying;
            });
            // Handle pause/play logic here
          },
          child: Container(
            height: 70.w,
            width: 70.w,
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkGreen.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValidationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.w,
          width: 120.w,
          child: PrimaryButtonWidget(
            title: "Incorrect",
            textFontSize: 16.sp,
            onTap: () {
              setState(() {
                isIncorrect = true;
                isCorrect = false;
              });
              _showValidationResult("Incorrect");
            },
            textColor: isIncorrect ? Colors.white : AppColors.orange,
            decoration: BoxDecoration(
              color: isIncorrect ? AppColors.orange : Colors.white,
              border: Border.all(
                color: AppColors.orange,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
        SizedBox(width: 24.w),
        SizedBox(
          height: 40.w,
          width: 120.w,
          child: PrimaryButtonWidget(
            title: "Correct",
            textFontSize: 16.sp,
            onTap: () {
              setState(() {
                isCorrect = true;
                isIncorrect = false;
              });
              // Navigate to Replay Recording Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReplayRecordingScreen(
                    recordedText: widget.recordedText,
                    selectedLanguage: widget.selectedLanguage,
                    currentIndex: widget.currentIndex,
                    totalItems: widget.totalItems,
                  ),
                ),
              );
            },
            textColor: isCorrect ? Colors.white : Colors.white,
            decoration: BoxDecoration(
              color: isCorrect ? AppColors.orange : AppColors.orange,
              border: Border.all(
                color: AppColors.orange,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
      ],
    );
  }

  void _showValidationResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Validation Result",
            style: GoogleFonts.notoSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "You marked this recording as '$result'. Thank you for your validation!",
            style: GoogleFonts.notoSans(
              fontSize: 14.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to home
              },
              child: Text(
                "Continue",
                style: GoogleFonts.notoSans(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
