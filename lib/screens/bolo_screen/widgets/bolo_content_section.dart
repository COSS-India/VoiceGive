import 'dart:io';

import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/constants/helper.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/recording_icon.dart';
import 'package:bhashadaan/screens/bolo_screen/validation_screen/validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';

class BoloContentSection extends StatefulWidget {
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;
  final String recordedText;
  final int sentenceId;
  final VoidCallback onLanguageChanged;

  const BoloContentSection({
    super.key,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
    required this.recordedText,
    required this.sentenceId,
    required this.onLanguageChanged,
  });

  @override
  State<BoloContentSection> createState() => _BoloContentSectionState();
}

class _BoloContentSectionState extends State<BoloContentSection> {
  ValueNotifier<bool> enableSubmit = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12).r,
      decoration: BoxDecoration(
          color: AppColors.lightGreen3,
          borderRadius: BorderRadius.circular(8).r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Text(
                "${widget.currentIndex}/${widget.totalItems}",
                style: GoogleFonts.notoSans(
                    fontSize: 12.sp,
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          SizedBox(
            height: 4.0,
            child: LinearProgressIndicator(
              value: 0.2,
              backgroundColor: AppColors.lightGreen4,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
            ),
          ),
          SizedBox(height: 24.w),
          Padding(
            padding: EdgeInsets.only(left: 32, right: 32).r,
            child: Text(
              widget.recordedText,
              style: GoogleFonts.notoSans(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50.w),
          RecordingButton(
            isRecording: (bool? recording) {
              debugPrint("Recording state changed: $recording");
            },
            getRecordedFile: (File? file) {
              debugPrint("Received recorded file: ${file?.path}");
              enableSubmit.value = file != null;
            },
          ),
          SizedBox(height: 50.w),
          actionButtons(),
          SizedBox(height: 50.w),
        ],
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.w,
          child: PrimaryButtonWidget(
            title: AppLocalizations.of(context).skip,
            textFontSize: 16.sp,
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(AppLocalizations.of(context).skippedSuccessfully)),
              );
            },
            textColor: AppColors.orange,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.orange),
              borderRadius: BorderRadius.all(Radius.circular(6.0).r),
            ),
          ),
        ),
        SizedBox(width: 24.w),
        ValueListenableBuilder(
            valueListenable: enableSubmit,
            builder: (context, value, child) {
              return SizedBox(
                width: 120.w,
                child: PrimaryButtonWidget(
                  title: AppLocalizations.of(context).submit,
                  textFontSize: 16.sp,
                  onTap: () {
                    debugPrint("Submit button tapped!");
                    debugPrint("Recorded text: ${widget.recordedText}");
                    debugPrint("Selected language: ${widget.selectedLanguage}");
                    value
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ValidationScreen(
                                recordedText: widget.recordedText,
                                selectedLanguage: widget.selectedLanguage,
                                currentIndex: widget.currentIndex,
                                totalItems: widget.totalItems,
                                sentenceId: widget.sentenceId,
                              ),
                            ),
                          )
                        : Helper.showSnackBarMessage(
                            context: context,
                            text:
                                "Please record your voice before submitting.");
                  },
                  textColor: Colors.white,
                  decoration: BoxDecoration(
                    color: value ? AppColors.orange : AppColors.grey16,
                    border: Border.all(
                        color: value ? AppColors.orange : AppColors.grey16),
                    borderRadius: BorderRadius.all(Radius.circular(6.0).r),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
