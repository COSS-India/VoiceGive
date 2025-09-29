import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bhashadaan/screens/bolo_screen/validation_screen/widgets/audio_player_buttons.dart';
import 'package:bhashadaan/screens/congratulations_screen/congratulations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloValidateSection extends StatefulWidget {
  final Function() onComplete;
  const BoloValidateSection({super.key, required this.onComplete});

  @override
  State<BoloValidateSection> createState() => _BoloValidateSectionState();
}

class _BoloValidateSectionState extends State<BoloValidateSection> {
  ValueNotifier<bool> enableActionButtons = ValueNotifier<bool>(false);

  List<String> recordedTexts = [
    "बचपन में मेरी दादी मुझे हर रात सोने से पहले एक नई कहानी सुनाया करती थीं, जिसकी वजह से मुझे कहानियाँ सुनना बहुत पसंद है।",
    "गर्मियों की छुट्टियों में हम सब परिवार के साथ पहाड़ों पर घूमने जाते हैं और वहाँ की ठंडी हवा और सुंदर दृश्य का आनंद लेते हैं।",
    "जब भी मुझे कोई कठिनाई आती है, मेरे माता-पिता हमेशा मेरा हौसला बढ़ाते हैं और मुझे सही रास्ता दिखाते हैं।",
    "पिछले महीने हमारे स्कूल में विज्ञान प्रदर्शनी का आयोजन हुआ था, जिसमें छात्रों ने बहुत सारी रोचक परियोजनाएँ प्रस्तुत कीं।",
    "मेरे दोस्त और मैं हर रविवार को पास के पार्क में क्रिकेट खेलते हैं, जिससे हमें बहुत खुशी और ताजगी मिलती है।",
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / recordedTexts.length;

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
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.w),
          AudioPlayerButtons(
            audioUrl: recordedTexts[currentIndex],
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
