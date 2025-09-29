import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_screen.dart';
import 'package:bhashadaan/screens/play_recording_screen/play_recording_screen.dart';
import 'package:bhashadaan/screens/pause_recording_screen/pause_recording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidationScreen extends StatefulWidget {
  final String recordedText;
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  final int? sentenceId;

  const ValidationScreen({
    super.key,
    required this.recordedText,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
    this.sentenceId,
  });

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = const Duration(seconds: 20);
  bool isRecording = false;

  Future<bool> _navigateBackToReRecord() async {
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
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "ValidationScreen build called with text: ${widget.recordedText}");
    return WillPopScope(
      onWillPop: _navigateBackToReRecord,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header Section - Same as Bolo Screen
              Container(
                padding: EdgeInsets.all(16).r,
                decoration: BoxDecoration(color: AppColors.orange),
                child: Row(
                  children: [
                    InkWell(
                      onTap: _navigateBackToReRecord,
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
                          AppLocalizations.of(context)!
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

              // Content Section - Same padding as Bolo Screen
              Padding(
                padding: const EdgeInsets.all(12.0).r,
                child: Column(
                  children: [
                    _buildActionButtons(),
                    SizedBox(height: 16.w),
                    _buildLanguageSelection(),
                    SizedBox(height: 24.w),
                    _buildValidationContent(),
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
          AppLocalizations.of(context)!.selectLanguageForContribution,
          style: GoogleFonts.notoSans(
            fontSize: 14.sp,
            color: Colors.black,
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

  Widget _buildValidationContent() {
    return Container(
      padding: EdgeInsets.all(12).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen3,
        borderRadius: BorderRadius.circular(8).r,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress Indicator - Same as Bolo Screen
          Row(
            children: [
              Spacer(),
              Text(
                "${widget.currentIndex}/${widget.totalItems}",
                style: GoogleFonts.notoSans(
                  fontSize: 12.sp,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                ),
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

          // Recorded Text - Same padding as Bolo Screen
          Padding(
            padding: EdgeInsets.only(left: 32, right: 32).r,
            child: Text(
              widget.recordedText,
              style: GoogleFonts.notoSans(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50.w),

          // Audio Player
          _buildAudioPlayer(),
          SizedBox(height: 30.w),

          // Re-Record Section
          _buildReRecordSection(),
          SizedBox(height: 50.w),

          // Action Buttons
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen3,
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to Play Recording Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayRecordingScreen(
                    recordedText: widget.recordedText,
                    selectedLanguage: widget.selectedLanguage,
                    currentIndex: widget.currentIndex,
                    totalItems: widget.totalItems,
                    sentenceId: widget.sentenceId,
                    audioUrl: null,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.play_arrow,
              color: AppColors.darkGreen,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              children: [
                // Progress Bar
                Container(
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: AppColors.grey24,
                    borderRadius: BorderRadius.circular(1).r,
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor:
                        currentPosition.inSeconds / totalDuration.inSeconds,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkGreen,
                        borderRadius: BorderRadius.circular(1).r,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.w),
                // Time Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(currentPosition),
                      style: GoogleFonts.notoSans(
                        fontSize: 10.sp,
                        color: AppColors.grey84,
                      ),
                    ),
                    Text(
                      _formatDuration(totalDuration),
                      style: GoogleFonts.notoSans(
                        fontSize: 10.sp,
                        color: AppColors.grey84,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Icon(
            Icons.more_vert,
            color: AppColors.grey84,
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildReRecordSection() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.reRecord,
          style: GoogleFonts.notoSans(
            fontSize: 16.sp,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.w),
        GestureDetector(
          onTap: () {
            setState(() {
              isRecording = !isRecording;
            });
            // Handle re-recording logic here
          },
          child: Container(
            height: 80.w,
            width: 80.w,
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
              shape: BoxShape.circle,
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
              isRecording ? Icons.stop : Icons.mic,
              color: Colors.white,
              size: 32.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.w,
          width: 150.w, // Increased width to accommodate larger font
          child: PrimaryButtonWidget(
            title: AppLocalizations.of(context)!.contributeMore,
            textFontSize: 12.sp, // Increased font size
            onTap: () {
              // Navigate to Bolo screen for new recording
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BoloScreen(),
                ),
              );
            },
            textColor: AppColors.orange,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.orange),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        SizedBox(
          height: 40.w,
          width: 120.w,
          child: PrimaryButtonWidget(
            title: AppLocalizations.of(context)!.validate,
            textFontSize: 16.sp,
            onTap: () {
              // Navigate to PlayRecordingScreen without API call
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayRecordingScreen(
                    recordedText: widget.recordedText,
                    selectedLanguage: widget.selectedLanguage,
                    currentIndex: widget.currentIndex,
                    totalItems: widget.totalItems,
                    sentenceId: widget.sentenceId,
                    audioUrl: null,
                    contributionId: null,
                  ),
                ),
              );
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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
