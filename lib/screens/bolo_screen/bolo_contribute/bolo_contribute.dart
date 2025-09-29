import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/actions_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_content_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_headers_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoloContribute extends StatefulWidget {
  const BoloContribute({super.key});

  @override
  State<BoloContribute> createState() => _BoloContributeState();
}

class _BoloContributeState extends State<BoloContribute> {
  String selectedLanguage = "Marathi";
  int currentIndex = 1;
  int totalItems = 5;
  String recordedText = "";
  int? sentenceId;

  @override
  void initState() {
    super.initState();
    recordedText =
        "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.";
    sentenceId = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      description: AppLocalizations.of(context)
                          .selectLanguageForContribution,
                    ),
                    SizedBox(height: 24.w),
                    BoloContentSection(
                      selectedLanguage: selectedLanguage,
                      currentIndex: currentIndex,
                      totalItems: totalItems,
                      recordedText:
                          recordedText.isNotEmpty ? recordedText : '...',
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
    );
  }
}
