import 'package:VoiceGive/common_widgets/custom_app_bar.dart';
import 'package:VoiceGive/screens/home_screen/widgets/home_about_section.dart';
import 'package:VoiceGive/screens/home_screen/widgets/home_header_section.dart';
import 'package:VoiceGive/screens/home_screen/widgets/home_footer_section.dart';
import 'package:VoiceGive/screens/home_screen/widgets/how_it_works_section.dart';
import 'package:VoiceGive/screens/home_screen/widgets/need_more_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeaderSection(),
                    SizedBox(height: 16.w),
                    Padding(
                      padding: const EdgeInsets.all(16.0).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeAboutSection(),
                          SizedBox(height: 24.w),
                          HowItWorksSection(),
                          SizedBox(height: 36.w),
                        ],
                      ),
                    ),
                    NeedMoreInfo(),
                    HomeFooterSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
