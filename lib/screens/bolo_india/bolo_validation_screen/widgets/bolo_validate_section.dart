import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_india/models/bolo_validate_model.dart';
import 'package:bhashadaan/screens/bolo_india/models/language_model.dart';
import 'package:bhashadaan/screens/bolo_india/repository/bolo_validate_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bhashadaan/screens/bolo_india/bolo_validation_screen/widgets/audio_player_buttons.dart';
import 'package:bhashadaan/screens/congratulations_screen/congratulations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloValidateSection extends StatefulWidget {
  final Function() onComplete;
  final LanguageModel languageModel;
  const BoloValidateSection(
      {super.key, required this.onComplete, required this.languageModel});

  @override
  State<BoloValidateSection> createState() => _BoloValidateSectionState();
}

class _BoloValidateSectionState extends State<BoloValidateSection> {
  ValueNotifier<bool> enableActionButtons = ValueNotifier<bool>(false);

  List<ValidationItem> recordedTexts = [];

  int currentIndex = 0;
  late Future<ValidationQueueModel?> getValidationsQueue;

  @override
  void initState() {
    getValidationsQueue = BoloValidateRepository().getValidationsQueue(
        language: widget.languageModel.languageCode, count: 5);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BoloValidateSection oldWidget) {
    // TODO: implement
    if (oldWidget.languageModel.languageCode !=
        widget.languageModel.languageCode) {
      getValidationsQueue = BoloValidateRepository().getValidationsQueue(
          language: widget.languageModel.languageCode, count: 5);
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValidationQueueModel?>(
        future: getValidationsQueue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.validationItems.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                  child: Text('No data available for the selected language')),
            );
          }
          if (snapshot.data != null) {
            double progress =
                (currentIndex + 1) / snapshot.data!.validationItems.length;
            recordedTexts = snapshot.data!.validationItems;

            return Container(
              padding: EdgeInsets.all(12).r,
              decoration: BoxDecoration(
                color: AppColors.lightGreen3,
                borderRadius: BorderRadius.circular(8).r,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
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
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w),
                  SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.lightGreen4,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                    ),
                  ),
                  SizedBox(height: 24.w),
                  Padding(
                    padding: EdgeInsets.only(left: 32, right: 32).r,
                    child: Text(
                      recordedTexts[currentIndex].text,
                      style: GoogleFonts.notoSans(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.w),
                  AudioPlayerButtons(
                    audioUrl: recordedTexts[currentIndex].audioContent,
                    playerStatus: (value) {
                      if (value == AudioPlayerButtonState.completed ||
                          value == AudioPlayerButtonState.replay) {
                        enableActionButtons.value = true;
                      }
                    },
                  ),
                  SizedBox(height: 30.w),
                  actionButtons(),
                  SizedBox(height: 30.w),
                ],
              ),
            );
          }
          return SizedBox();
        });
  }

  Widget actionButtons() {
    return ValueListenableBuilder(
        valueListenable: enableActionButtons,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120.w,
                child: PrimaryButtonWidget(
                  title: AppLocalizations.of(context)!.incorrect,
                  textFontSize: 16.sp,
                  onTap: value ? () => onValidate(false) : null,
                  textColor: value ? AppColors.orange : AppColors.grey24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: value ? AppColors.orange : AppColors.grey24,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.0).r),
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              SizedBox(
                width: 120.w,
                child: PrimaryButtonWidget(
                  title: AppLocalizations.of(context)!.correct,
                  textFontSize: 16.sp,
                  onTap: value ? () => onValidate(true) : null,
                  textColor: Colors.white,
                  decoration: BoxDecoration(
                    color: value ? AppColors.orange : AppColors.grey24,
                    border: Border.all(
                      color: value ? AppColors.orange : AppColors.grey24,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.0).r),
                  ),
                ),
              )
            ],
          );
        });
  }

  void onValidate(bool isCorrect) {
    enableActionButtons.value = false;
    if (currentIndex < recordedTexts.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      widget.onComplete();
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CongratulationsScreen()));
      });
    }
  }
}
