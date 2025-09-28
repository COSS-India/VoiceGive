import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/pause_recording_screen/pause_recording_screen.dart';
import 'package:bhashadaan/screens/validation_screen/validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayRecordingScreen extends StatefulWidget {
  final String recordedText;
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  final int? sentenceId;
  final String? audioUrl;
  final int? contributionId;

  const PlayRecordingScreen({
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
  State<PlayRecordingScreen> createState() => _PlayRecordingScreenState();
}

class _PlayRecordingScreenState extends State<PlayRecordingScreen> {
  bool isPlaying = false;

  Future<bool> _navigateBackToValidation() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ValidationScreen(
          recordedText: widget.recordedText,
          selectedLanguage: widget.selectedLanguage,
          currentIndex: widget.currentIndex,
          totalItems: widget.totalItems,
          sentenceId: widget.sentenceId,
        ),
      ),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _navigateBackToValidation,
      child: Scaffold(
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
                      InkWell(
                        onTap: _navigateBackToValidation,
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
                            AppLocalizations.of(context).boloIndia,
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .enrichYourLanguageByDonatingVoice,
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
                      _buildPlayRecordingContent(),
                      SizedBox(height: 40.w),
                    ],
                  ),
                ),
              ],
            ),
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
            title: AppLocalizations.of(context).quickTips,
            icon: Icons.lightbulb_outline,
          ),
          _actionButton(
            onTap: () {},
            title: AppLocalizations.of(context).report,
            icon: Icons.report_outlined,
          ),
          _actionButton(
            onTap: () {},
            title: AppLocalizations.of(context).testSpeakers,
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
          AppLocalizations.of(context).selectLanguageForValidation,
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

  Widget _buildPlayRecordingContent() {
    return Container(
      padding: EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen3,
        borderRadius: BorderRadius.circular(12).r,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
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

          // Play Recording Section
          _buildPlayRecordingSection(),
          SizedBox(height: 32.w),

          // Validation Buttons (Disabled)
          _buildValidationButtons(),
        ],
      ),
    );
  }

  Widget _buildPlayRecordingSection() {
    return Column(
      children: [
        Text(
          widget.audioUrl != null && widget.audioUrl!.isNotEmpty
              ? AppLocalizations.of(context).playContribution
              : AppLocalizations.of(context).playRecording,
          style: GoogleFonts.notoSans(
            fontSize: 16.sp,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.w),
        GestureDetector(
          onTap: () {
            // Navigate to Pause Recording Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PauseRecordingScreen(
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
          child: Container(
            height: 70.w,
            width: 70.w,
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkGreen.withValues(alpha: 0.3),
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
            title: AppLocalizations.of(context).incorrect,
            textFontSize: 16.sp,
            onTap: () {
              // Handle incorrect validation without API call
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Marked Incorrect')),
              );
            },
            textColor: AppColors.grey84,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: AppColors.grey84.withValues(alpha: 0.5),
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
            title: AppLocalizations.of(context).correct,
            textFontSize: 16.sp,
            onTap: () {
              // Handle correct validation without API call
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Marked Correct')),
              );
            },
            textColor: AppColors.grey84,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: AppColors.grey84.withValues(alpha: 0.5),
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
      ],
    );
  }
}
