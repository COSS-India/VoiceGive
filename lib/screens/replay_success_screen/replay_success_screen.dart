import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/congratulations_screen/congratulations_screen.dart';
import 'package:bhashadaan/screens/replay_recording_screen/replay_recording_screen.dart';
import 'package:bhashadaan/services/api_service.dart';
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
              ),
              child: Column(
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
                  Padding(
                    padding: const EdgeInsets.all(12.0).r,
                    child: Column(
                      children: [
                        _buildTopActionButtons(),
                        SizedBox(height: 24.w),
                        _buildLanguageSelection(),
                        SizedBox(height: 40.w),
                        _buildSuccessContent(),
                        SizedBox(height: 40.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            padding: EdgeInsets.all(16).r,
            decoration: BoxDecoration(
              color: Colors.white,
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

                // Replay Recording Section
                _buildReplayRecordingSection(),
                SizedBox(height: 32.w),

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
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.replayRecording,
          style: GoogleFonts.notoSans(
            fontSize: 16.sp,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.w),
        GestureDetector(
          onTap: () {
            // Handle play/pause logic here
            // Could show success message or navigate
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
              Icons.play_arrow,
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
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
        SizedBox(width: 24.w),
        SizedBox(
          height: 40.w,
          width: 120.w,
          child: PrimaryButtonWidget(
            title: AppLocalizations.of(context)!.correct,
            textFontSize: 16.sp,
            onTap: () async {
              if (widget.sentenceId != null) {
                try {
                  final res = await ApiService.validateAccept(
                    validateId: 9760326, // TEMP hardcoded validateId for accept
                    device: 'Linux null',
                    browser: 'Chrome 140.0.0.0',
                    userName: 'Supriya',
                    fromLanguage: widget.selectedLanguage,
                    sentenceId: 2664743, // per requirement for accept
                    state: 'Karnataka',
                    country: 'India',
                    latitude: 12.9753,
                    longitude: 77.591,
                    type: 'text',
                    userNum: 5742,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(res.statusCode >= 200 && res.statusCode < 300 ? AppLocalizations.of(context)!.markedCorrect : '${AppLocalizations.of(context)!.acceptFailed}: ${res.statusCode}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
                  );
                }
              }
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
