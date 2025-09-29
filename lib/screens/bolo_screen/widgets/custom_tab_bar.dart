import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  CustomTabBar({super.key, required this.tabController});
  List<String> tabTitles = ["Speak", "Validate"];
  List<String> tabIcons = [
    "assets/images/bolo_icon.svg",
    "assets/images/validatecolour.svg"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.only(top: 4, left: 16).r,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.w, color: AppColors.grey08),
        ),
      ),
      child: TabBar(
        tabAlignment: TabAlignment.start,
        onTap: (value) {},
        isScrollable: true,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkGreen,
              width: 2.0.w,
            ),
          ),
        ),
        indicatorColor: AppColors.appBarBackground,
        labelPadding: EdgeInsets.only(top: 0.0).w,
        unselectedLabelColor: AppColors.greys60,
        labelColor: AppColors.greys87,
        labelStyle: GoogleFonts.lato(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.lato(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.greys60,
        ),
        tabs: List.generate(
          tabTitles.length,
          (index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 16).r,
            child: Tab(
              child: Padding(
                  padding: EdgeInsets.all(5.0).r,
                  child: Row(
                    children: [
                      ImageWidget(
                        imageUrl: tabIcons[index],
                        height: 24.sp,
                        width: 24.sp,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        tabTitles[index],
                      ),
                    ],
                  )),
            ),
          ),
        ),
        controller: tabController,
      ),
    );
  }
}
