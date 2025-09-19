import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/models/get_started_model.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_get_started/widgets/get_started_item.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoloGetStarted extends StatefulWidget {
  const BoloGetStarted({super.key});

  @override
  State<BoloGetStarted> createState() => _BoloGetStartedState();
}

class _BoloGetStartedState extends State<BoloGetStarted> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<GetStartedModel> getStartedData = [
    GetStartedModel(
      title: "Check Your Setup",
      illustrationImageUrl: "assets/images/bolo_illustration1.png",
      instructions: [
        GetStartedInstruction(
          title: "Please Test Your Speaker",
          description:
              "Play the sample audio and confirm you can hear it clearly before starting the task",
          icon: Icons.headphones,
        ),
        GetStartedInstruction(
          title: "Please Test Your Microphone",
          description:
              "Speak a few words to check if your voice is being recorded properly and without distortion",
          icon: Icons.mic,
        ),
        GetStartedInstruction(
          title: "No background noise",
          description:
              "Choose a quiet environment. Avoid background sounds like fans, traffic, or other voices while recording.",
          icon: Icons.volume_off,
        ),
      ],
    ),
    GetStartedModel(
      title: "Speak Naturally",
      illustrationImageUrl: "assets/images/bolo_illustration2.png",
      instructions: [
        GetStartedInstruction(
          title: "Record exactly as shown",
          description:
              "Speak clearly, exactly following the text displayed, so your contribution is accurate and usable",
          icon: Icons.record_voice_over,
        ),
        GetStartedInstruction(
          title: "Don’t record Punctuations",
          description:
              "Read only the words shown on screen. Do not say commas, full stops, or other punctuation marks.",
          icon: Icons.text_fields,
        ),
        GetStartedInstruction(
          title: "Tap record to start",
          description:
              "Press the record button once you are ready, and speak clearly and naturally.",
          icon: Icons.mic_none,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: getStartedData.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final data = getStartedData[index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          data.title,
                          style: GoogleFonts.notoSans(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.w),
                        ImageWidget(
                          imageUrl: data.illustrationImageUrl,
                          height: 220.w,
                          width: 220.w,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 24.0).r,
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < data.instructions.length;
                                  i++) ...[
                                GetStartedItem(
                                  icon: data.instructions[i].icon,
                                  title: data.instructions[i].title,
                                  description: data.instructions[i].description,
                                ),
                                if (i < data.instructions.length - 1)
                                  Divider(
                                    color: AppColors.grey08,
                                    height: 30.w,
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                getStartedData.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentPage == i ? 16.w : 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.darkGreen
                        : AppColors.grey16,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.w),
            actionButtons(),
            SizedBox(height: 16.w),
          ],
        ),
      ),
    );
  }

  Widget actionButtons() {
    return _currentPage == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110.w,
                child: PrimaryButtonWidget(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(color: AppColors.darkGreen),
                  ),
                  title: "Skip",
                  textColor: AppColors.darkGreen,
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoloScreen(),
                        ));
                  },
                ),
              ),
              SizedBox(width: 50.w),
              SizedBox(
                width: 110.w,
                child: PrimaryButtonWidget(
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.darkGreen),
                  ),
                  title: "Next",
                  textColor: Colors.white,
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110.w,
                child: PrimaryButtonWidget(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(color: AppColors.darkGreen),
                  ),
                  title: "Previous",
                  textColor: AppColors.darkGreen,
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
              SizedBox(width: 50.w),
              SizedBox(
                width: 110.w,
                child: PrimaryButtonWidget(
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.darkGreen),
                  ),
                  title: "Finish",
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoloScreen(),
                        ));
                  },
                ),
              ),
            ],
          );
  }
}
