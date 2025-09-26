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
      body: Lottie.asset(
        'assets/animations/bhashadaan_splash_screen.json',
        controller: _controller,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        onLoaded: (composition) {
          _controller.duration = composition.duration;
          _controller.forward();
        },
      ),
    );
  }
}
