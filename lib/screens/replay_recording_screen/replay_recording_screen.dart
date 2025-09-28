import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/pause_recording_screen/pause_recording_screen.dart';
import 'package:bhashadaan/screens/replay_success_screen/replay_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplayRecordingScreen extends StatefulWidget {
  final String recordedText;
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  final int? sentenceId;
  final String? audioUrl;
  final int? contributionId;

  const ReplayRecordingScreen({
    super.key,
    required this.recordedText,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
    this.sentenceId,
    this.audioUrl,
    this.contributionId,
  });

  @override
  State<ReplayRecordingScreen> createState() => _ReplayRecordingScreenState();
}

class _ReplayRecordingScreenState extends State<ReplayRecordingScreen> {
  bool isPlaying = false;
  bool isCorrect = false;
  bool isIncorrect = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PauseRecordingScreen(
              recordedText: widget.recordedText,
              selectedLanguage: widget.selectedLanguage,
              currentIndex: widget.currentIndex,
              totalItems: widget.totalItems,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Column(
          children: [
            // Header Section - Same as Bolo Screen
            Container(
              padding: EdgeInsets.all(16).r,
              decoration: BoxDecoration(color: AppColors.orange),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PauseRecordingScreen(
                            recordedText: widget.recordedText,
                            selectedLanguage: widget.selectedLanguage,
                            currentIndex: widget.currentIndex,
                            totalItems: widget.totalItems,
                            sentenceId: widget.sentenceId,
                            audioUrl: widget.audioUrl,
                            contributionId: widget.contributionId,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.white,
                      size: 36.sp,
                    ),
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
                        AppLocalizations.of(context)!.boloIndia,
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.enrichYourLanguage,
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
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0).r,
                child: Column(
                  children: [
                    _buildActionButtons(),
                    SizedBox(height: 24.w),
                    _buildLanguageSelection(),
                    SizedBox(height: 24.w),
                    _buildReplayRecordingContent(),
                    SizedBox(height: 16.w),
                  ],
                ),
              ),
            ),
          ],
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
            title: AppLocalizations.of(context)!.quickTips,
            icon: Icons.lightbulb_outline,
          ),
          _actionButton(
            onTap: () {},
            title: AppLocalizations.of(context)!.report,
            icon: Icons.report_outlined,
          ),
          _actionButton(
            onTap: () {},
            title: AppLocalizations.of(context)!.testSpeakers,
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
          AppLocalizations.of(context)!.selectLanguageForValidation,
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

  Widget _buildReplayRecordingContent() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.45,
      ),
      padding: EdgeInsets.all(20).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen3,
        borderRadius: BorderRadius.circular(16).r,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Indicator and Counter
          Row(
            children: [
              // Progress Bar
              Expanded(
                child: Container(
                  height: 5.w,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(3).r,
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
          SizedBox(height: 28.w),

          // Replay Recording Section
          _buildReplayRecordingSection(),
          SizedBox(height: 28.w),

          // Validation Buttons
          _buildValidationButtons(),
        ],
      ),
    );
  }

  Widget _buildReplayRecordingSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.lightGreen3.withOpacity(0.4),
            AppColors.lightGreen3.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.replayRecording,
            style: GoogleFonts.notoSans(
              fontSize: 18.sp,
              color: AppColors.darkGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.w),
          GestureDetector(
            onTap: () {
              setState(() {
                isPlaying = !isPlaying;
              });
              // Handle play/pause logic here
            },
            child: Container(
              height: 100.w,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.darkGreen,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkGreen.withOpacity(0.4),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 48.w,
            child: PrimaryButtonWidget(
              title: AppLocalizations.of(context)!.incorrect,
              textFontSize: 16.sp,
              onTap: () {
                setState(() {
                  isIncorrect = true;
                  isCorrect = false;
                });
                _showValidationResult(AppLocalizations.of(context)!.incorrect);
              },
              textColor: isIncorrect ? Colors.white : AppColors.orange,
              decoration: BoxDecoration(
                color: isIncorrect ? AppColors.orange : Colors.white,
                border: Border.all(
                  color: AppColors.orange,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0).r),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SizedBox(
            height: 48.w,
            child: PrimaryButtonWidget(
              title: AppLocalizations.of(context)!.correct,
              textFontSize: 16.sp,
              onTap: () {
                setState(() {
                  isCorrect = true;
                  isIncorrect = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReplaySuccessScreen(
                      recordedText: widget.recordedText,
                      selectedLanguage: widget.selectedLanguage,
                      currentIndex: widget.currentIndex,
                      totalItems: widget.totalItems,
                      sentenceId: widget.sentenceId,
                      audioUrl: widget.audioUrl,
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
                borderRadius: BorderRadius.all(Radius.circular(8.0).r),
              ),
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
            AppLocalizations.of(context)!.validationResult,
            style: GoogleFonts.notoSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!.youMarkedRecordingAs(result),
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
                AppLocalizations.of(context)!.continueButton,
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

