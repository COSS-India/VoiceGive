import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/congratulations_screen/congratulations_screen.dart';
import 'package:bhashadaan/screens/replay_recording_screen/replay_recording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class ReplaySuccessScreen extends StatefulWidget {
  final String recordedText;
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  final int? sentenceId;
  final String? audioUrl;

  const ReplaySuccessScreen({
    super.key,
    required this.recordedText,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
    this.sentenceId,
    this.audioUrl,
  });

  @override
  State<ReplaySuccessScreen> createState() => _ReplaySuccessScreenState();
}

class _ReplaySuccessScreenState extends State<ReplaySuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _confettiController.repeat();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ReplayRecordingScreen(
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
        backgroundColor: Colors.grey[100],
        appBar: CustomAppBar(),
        body: Stack(
        children: [
          // Confetti Animation
          _buildConfetti(),

          // Main Content
          Column(
            children: [
              // Header Section - Same as other screens
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
                            builder: (_) => ReplayRecordingScreen(
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
                          AppLocalizations.of(context)!.enrichYourLanguageByDonatingVoice,
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
                      _buildTopActionButtons(),
                      SizedBox(height: 24.w),
                      _buildLanguageSelection(),
                      SizedBox(height: 24.w),
                      _buildSuccessContent(),
                      SizedBox(height: 16.w),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildConfetti() {
    return AnimatedBuilder(
      animation: _confettiController,
      builder: (context, child) {
        return CustomPaint(
          painter: ConfettiPainter(_confettiController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildTopActionButtons() {
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

  Widget _buildSuccessContent() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            padding: EdgeInsets.all(20).r,
            decoration: BoxDecoration(
              color: Colors.white,
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
          ),
        );
      },
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
              // Handle play/pause logic here
              // Could show success message or navigate
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
                Icons.play_arrow,
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
                // Show validation result
                _showValidationResult(AppLocalizations.of(context)!.incorrect);
              },
              textColor: AppColors.orange,
              decoration: BoxDecoration(
                color: Colors.white,
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
                // Navigate to Congratulations Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CongratulationsScreen(
                      recordedText: widget.recordedText,
                      selectedLanguage: widget.selectedLanguage,
                      currentIndex: widget.currentIndex,
                      totalItems: widget.totalItems,
                    ),
                  ),
                );
              },
              textColor: Colors.white,
              decoration: BoxDecoration(
                color: AppColors.orange,
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
                Navigator.of(context).popUntil((route) => route.isFirst);
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

class ConfettiPainter extends CustomPainter {
  final double animationValue;

  ConfettiPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = Random(42); // Fixed seed for consistent confetti

    for (int i = 0; i < 50; i++) {
      final x = (random.nextDouble() * size.width);
      final y = (random.nextDouble() * size.height) + (animationValue * 100);
      final color = _getRandomColor(random);
      final confettiSize = (random.nextDouble() * 8) + 4;

      paint.color = color;
      canvas.drawCircle(Offset(x, y), confettiSize, paint);
    }
  }

  Color _getRandomColor(Random random) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.pink,
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
