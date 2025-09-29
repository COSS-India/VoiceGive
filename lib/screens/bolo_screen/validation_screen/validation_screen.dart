import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_contribute/bolo_contribute.dart';
import 'package:bhashadaan/screens/bolo_screen/validation_screen/widgets/bolo_validate_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/actions_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_headers_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "ValidationScreen build called with text: ${widget.recordedText}");
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
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
                    ),
                    SizedBox(height: 24.w),
                    BoloValidateSection()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
