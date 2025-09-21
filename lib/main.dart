import 'package:bhashadaan/constants/app_constants.dart';
import 'package:bhashadaan/l10n/l10n.dart';
import 'package:bhashadaan/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(
          AppConstants.defaultScreenWidth,
          AppConstants.defaultScreenHeight,
        ),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: L10n.supportedLocale,
            home: CustomSplashScreen(),
          );
        });
  }
}
