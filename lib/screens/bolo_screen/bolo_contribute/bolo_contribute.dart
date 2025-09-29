import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/actions_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_content_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoloContribute extends StatefulWidget {
  const BoloContribute({super.key});

  @override
  State<BoloContribute> createState() => _BoloContributeState();
}

class _BoloContributeState extends State<BoloContribute> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0).r,
              child: Column(
                children: [
                  ActionsSection(),
                  SizedBox(height: 16.w),
                  LanguageSelection(
                    description: AppLocalizations.of(context)!
                        .selectLanguageForContribution,
                  ),
                  SizedBox(height: 24.w),
                  BoloContentSection(),
                ],
              ),
            )
          ],
        ));
  }
}
