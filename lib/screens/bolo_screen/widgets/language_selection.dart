import 'package:bhashadaan/common_widgets/searchable_bottom_sheet/searchable_boottosheet_content.dart';
import 'package:bhashadaan/constants/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelection extends StatefulWidget {
  final String description;
  const LanguageSelection({super.key, required this.description});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String selectedLanguage = "Marathi";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.description,
          style: GoogleFonts.notoSans(
              fontSize: 12.sp,
              color: AppColors.darkGreen,
              fontWeight: FontWeight.w500),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.close, color: AppColors.darkGreen),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SearchableBottomSheetContent(
                        items: [
                          AppLocalizations.of(context)!.english,
                          AppLocalizations.of(context)!.hindi,
                          AppLocalizations.of(context)!.kannada,
                          AppLocalizations.of(context)!.tamil,
                          AppLocalizations.of(context)!.telugu,
                          AppLocalizations.of(context)!.bengali,
                          AppLocalizations.of(context)!.marathi,
                          AppLocalizations.of(context)!.gujarati,
                          AppLocalizations.of(context)!.punjabi,
                          AppLocalizations.of(context)!.odia,
                          AppLocalizations.of(context)!.assamese
                        ],
                        onItemSelected: (value) {
                           selectedLanguage = value;
                      setState(() {});
                      Navigator.pop(context);
                        },
                        hasMore: false,
                        initialQuery: "",
                      ),
                    ],
                  );
                });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8).r,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(5).r,
            ),
            child: Row(
              children: [
                Text(
                  selectedLanguage,
                  style: GoogleFonts.notoSans(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 16.sp,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
