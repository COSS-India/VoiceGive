import 'package:bhashadaan/screens/auth/otp_login/otp_login_screen.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  // bool _isLottieLoaded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // if (!_isLottieLoaded)
          //   Container(
          //     color: Colors.white,
          //   ),
          Center(
            child: Lottie.asset(
              'assets/animations/bhashadaan_splash_screen.json',
              controller: _controller,
              fit: BoxFit.fill,
              onLoaded: (composition) {
                // setState(() {
                //   _isLottieLoaded = true;
                // });
                _controller.duration = composition.duration;
                _controller.forward();
              },
            ),
          ),
        ],
      ),
    );
  }
}
