import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/actions_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_content_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/language_selection.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloScreen extends StatefulWidget {
  final String? initialText;
  final int? initialSentenceId;

  const BoloScreen({super.key, this.initialText, this.initialSentenceId});

  @override
  State<BoloScreen> createState() => _BoloScreenState();

  static fromRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>?;

    return BoloScreen(
      initialText: args != null ? args['initialText'] as String? : null,
      initialSentenceId: args != null ? args['initialSentenceId'] as int? : null,
    );
  }
}

class _BoloScreenState extends State<BoloScreen> {
  String selectedLanguage = "English";
  int currentIndex = 1;
  int totalItems = 5;
  String recordedText = "";
  int? sentenceId;

  Future<bool> _navigateBackToHome() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _navigateBackToHome,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16).r,
                decoration: BoxDecoration(color: AppColors.orange),
                child: Row(
                  children: [
                    InkWell(
                      onTap: _navigateBackToHome,
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
                        imageUrl: "assets/images/bolo_icon_white.svg"),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BOLO India",
                          style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Enrich your language by donating your voice. ",
                          style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0).r,
                child: Column(
                  children: [
                    ActionsSection(),
                    SizedBox(height: 16.w),
                    LanguageSelection(),
                    SizedBox(height: 24.w),
                    BoloContentSection(
                      selectedLanguage: selectedLanguage,
                      currentIndex: currentIndex,
                      totalItems: totalItems,
                      recordedText: recordedText.isNotEmpty ? recordedText : '...',
                      sentenceId: sentenceId ?? 0,
                      onLanguageChanged: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              )
            ],
          )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Use default text instead of fetching from API
    recordedText = "Welcome to Bhashadaan! Please record your voice to contribute to the language dataset.";
    sentenceId = 1;
  }
}
