import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_contribute/bolo_contribute.dart';
import 'package:bhashadaan/screens/bolo_screen/validation_screen/validation_screen.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/bolo_headers_section.dart';
import 'package:bhashadaan/screens/bolo_screen/widgets/custom_tab_bar.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoloScreen extends StatefulWidget {
  const BoloScreen({
    super.key,
  });

  @override
  State<BoloScreen> createState() => _BoloScreenState();

  static fromRoute(RouteSettings routeSettings) {
    return BoloScreen();
  }
}

class _BoloScreenState extends State<BoloScreen> with TickerProviderStateMixin {
  Future<bool> _navigateBackToHome() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
    return false;
  }

  List<String> tabTitles = ["Speak", "Validate"];

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: tabTitles.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _navigateBackToHome,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              BoloHeadersSection(),
              CustomTabBar(tabController: tabController),
              SizedBox(height: 8.h),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 800.h,
                      child: TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [BoloContribute(), ValidationScreen()],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
