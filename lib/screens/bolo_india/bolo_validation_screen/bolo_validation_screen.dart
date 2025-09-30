import 'dart:math';
import 'package:VoiceGive/common_widgets/custom_app_bar.dart';
import 'package:VoiceGive/screens/bolo_india/bolo_validation_screen/widgets/bolo_validate_section.dart';
import 'package:VoiceGive/screens/bolo_india/models/language_model.dart';
import 'package:VoiceGive/screens/bolo_india/widgets/actions_section.dart';
import 'package:VoiceGive/screens/bolo_india/widgets/bolo_headers_section.dart';
import 'package:VoiceGive/screens/bolo_india/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoloValidationScreen extends StatefulWidget {
  const BoloValidationScreen({
    super.key,
  });

  @override
  State<BoloValidationScreen> createState() => _BoloValidationScreenState();
}

class _BoloValidationScreenState extends State<BoloValidationScreen>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool isCompleted = false;
  LanguageModel selectedLanguage = LanguageModel(
      languageName: "Marathi",
      nativeName: "मराठी",
      isActive: true,
      languageCode: "mr",
      region: "India",
      speakers: "");

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
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  BoloHeadersSection(),
                  Padding(
                    padding: const EdgeInsets.all(12.0).r,
                    child: Column(
                      children: [
                        ActionsSection(),
                        SizedBox(height: 16.w),
                        LanguageSelection(
                          description: "Select language for validation",
                          onLanguageChanged: (value) {
                            selectedLanguage = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 24.w),
                        BoloValidateSection(
                          languageModel: selectedLanguage,
                          onComplete: () {
                            setState(() {
                              isCompleted = true;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isCompleted
                ? Positioned(
                    child: _buildConfetti(),
                  )
                : SizedBox()
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
