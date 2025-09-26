import 'package:bhashadaan/constants/app_constants.dart';
import 'package:bhashadaan/l10n/l10n.dart';
import 'package:bhashadaan/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bhashadaan/config/app_config.dart';
import 'package:bhashadaan/services/auth_manager.dart';
import 'package:provider/provider.dart';
import 'package:bhashadaan/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize environment configuration
  await AppConfig.initialize();
  
  // Validate configuration
  AppConfig.instance.validateConfig();
  
  // Initialize AuthManager
  await AuthManager.instance.initialize();
  
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
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: L10n.supportedLocale,
              home: CustomSplashScreen(),
            ),
          );
        });
  }
}
