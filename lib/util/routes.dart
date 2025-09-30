import 'package:bhashadaan/common_widgets/fade_route.dart';
import 'package:bhashadaan/constants/app_routes.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_screen.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../common_widgets/error_page.dart';
import '../screens/auth/otp_login/otp_login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      return _getRoute(routeSettings);
    } catch (e) {
      return errorRoute(routeSettings);
    }
  }

  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
        settings: routeSettings, builder: (_) => ErrorPage());
  }

  static Route<dynamic> _getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.bolo:
        return FadeRoute(page: BoloScreen.fromRoute(routeSettings));

      case AppRoutes.otpVerification:
        return MaterialPageRoute(builder: (context) => const OtpLoginScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return FadeRoute(page: const HomeScreen());
    }
  }
}
