import 'dart:io';

import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/constants/helper.dart';
import 'package:bhashadaan/screens/bolo_india/widgets/recording_icon.dart';
import 'package:bhashadaan/screens/bolo_india/bolo_contribute/bolo_contribute.dart';
import 'package:bhashadaan/screens/bolo_india/bolo_validation_screen/bolo_validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoloContentSection extends StatefulWidget {
  const BoloContentSection({
    super.key,
  });

  @override
  State<BoloContentSection> createState() => _BoloContentSectionState();
}

class _BoloContentSectionState extends State<BoloContentSection> {
  ValueNotifier<bool> enableSubmit = ValueNotifier<bool>(false);

  List<String> recordedTexts = [
    "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
    "माझ्या आईला तुझी भेट झाली होती.",
    "आज हवामान खूप छान आहे.",
    "आपण उद्या भेटू या.",
    "मला पुस्तक वाचायला आवडते.",
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / recordedTexts.length;

    return Container(
      padding: EdgeInsets.all(12).r,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/contribute_bg.png"),
            fit: BoxFit.cover,
          ),
          color: AppColors.lightGreen3,
          borderRadius: BorderRadius.circular(8).r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                "${currentIndex + 1}/${recordedTexts.length}",
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
              value: progress,
              backgroundColor: AppColors.lightGreen4,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
            ),
          ),
          SizedBox(height: 24.w),
          Padding(
            padding: EdgeInsets.only(left: 32, right: 32).r,
            child: Text(
              recordedTexts[currentIndex],
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
    if (currentIndex >= 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 165.w,
            child: PrimaryButtonWidget(
              title: "Contribute More",
              textFontSize: 16.sp,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BoloContribute(),
                  ),
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
          SizedBox(
            width: 140.w,
            child: PrimaryButtonWidget(
              title: "Validate",
              textFontSize: 16.sp,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoloValidationScreen(),
                  ),
                );
              },
              textColor: Colors.white,
              decoration: BoxDecoration(
                color: AppColors.orange,
                border: Border.all(color: AppColors.orange),
                borderRadius: BorderRadius.all(Radius.circular(6.0).r),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.w,
            child: PrimaryButtonWidget(
              title: AppLocalizations.of(context)!.skip,
              textFontSize: 16.sp,
              onTap: () => onSkip(),
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
                    title: AppLocalizations.of(context)!.submit,
                    textFontSize: 16.sp,
                    onTap: () => onSubmit(value),
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

  void onSkip() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(AppLocalizations.of(context)!.skippedSuccessfully)),
    );
    moveToNext();
  }

  void onSubmit(bool value) {
    if (value) {
      moveToNext();
      enableSubmit.value = false;
    } else {
      Helper.showSnackBarMessage(
        context: context,
        text: "Please record your voice before submitting.",
      );
    }
  }

  void moveToNext() {
    if (currentIndex < recordedTexts.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoloValidationScreen(),
        ),
      );
    }
    enableSubmit.value = false;
  }
}
