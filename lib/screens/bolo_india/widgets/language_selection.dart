import 'package:bhashadaan/common_widgets/language_searchable_bottom_sheet/searchable_boottosheet_content.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_india/models/language_model.dart';
import 'package:bhashadaan/screens/bolo_india/service/bolo_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSelection extends StatefulWidget {
  final String description;
  final Function(LanguageModel) onLanguageChanged;
  const LanguageSelection(
      {super.key, required this.description, required this.onLanguageChanged});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  LanguageModel selectedLanguage = LanguageModel(
      languageName: "Hindi",
      nativeName: "हिन्दी",
      isActive: true,
      languageCode: "hi",
      region: "India",
      speakers: "");
  Future<List<LanguageModel>>? languagesFuture;

  @override
  void initState() {
    languagesFuture = BoloService().getLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LanguageModel>>(
        future: languagesFuture,
        builder: (context, snapshot) {
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.close,
                                    color: AppColors.darkGreen),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            LanguageSearchableBottomSheetContent(
                              items: snapshot.data ?? [],
                              onItemSelected: (value) {
                                selectedLanguage = value;
                                widget.onLanguageChanged(value);
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
                        selectedLanguage.languageName,
                        style: GoogleFonts.notoSans(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 8.w),
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
        });
  }
}
