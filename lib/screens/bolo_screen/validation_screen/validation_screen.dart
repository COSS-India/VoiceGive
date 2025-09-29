import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/screens/bolo_screen/validation_screen/widgets/bolo_validate_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/actions_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_headers_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({
    super.key,
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
