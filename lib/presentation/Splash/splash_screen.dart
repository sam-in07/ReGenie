import 'dart:async';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/User/Pages/login_screen.dart';
import 'package:regenie/presentation/widgets/app_text.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Simple fade-in animation for logo/text
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Navigate to login after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD1F1DD),

      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.6,
                height: height * 0.15,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: height * 0.015),
              Text(
                AppText.welcomeTo,
                textAlign: TextAlign.center,
                style: AppTextstyle.textStyle24greenW600,
              ),
              SizedBox(height: height * 0.02),
              Text(
                AppText.motive,
                textAlign: TextAlign.center,
                style: AppTextstyle.textStyle15BlackW700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
