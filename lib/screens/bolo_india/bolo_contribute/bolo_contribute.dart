import 'package:VoiceGive/common_widgets/custom_app_bar.dart';
import 'package:VoiceGive/screens/bolo_india/models/language_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:VoiceGive/screens/bolo_india/widgets/actions_section.dart';
import 'package:VoiceGive/screens/bolo_india/bolo_contribute/widgets/bolo_content_section.dart';
import 'package:VoiceGive/screens/bolo_india/widgets/bolo_headers_section.dart';
import 'package:VoiceGive/screens/bolo_india/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoloContribute extends StatefulWidget {
  const BoloContribute({super.key});

  @override
  State<BoloContribute> createState() => _BoloContributeState();
}

class _BoloContributeState extends State<BoloContribute> {
  LanguageModel selectedLanguage = LanguageModel(
      languageName: "Hindi",
      nativeName: "हिन्दी",
      isActive: true,
      languageCode: "hi",
      region: "India",
      speakers: "");

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
                      description: AppLocalizations.of(context)!
                          .selectLanguageForContribution,
                      onLanguageChanged: (value) {
                        selectedLanguage = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 24.w),
                    BoloContentSection(
                      language: selectedLanguage,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
