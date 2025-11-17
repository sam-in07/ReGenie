import 'package:flutter/material.dart';
import 'package:regenie/presentation/Splash/splash_screen.dart';


import 'package:regenie/presentation/User/Pages/login_screen.dart';
import 'package:regenie/presentation/User/Pages/onboarding_screen.dart';
import 'package:regenie/presentation/User/Pages/registration_screen.dart';
import 'package:regenie/presentation/navigation/bottom_nav.dart';

class AppRoutes {

  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const onboarding = '/onboarding';
  static const main = '/main'; // ✅ matches main.dart
  // static const reminders = '/reminders';



// static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case splash:
  //       return MaterialPageRoute(builder: (_) => const SplashScreen());
  //     case login:
  //       return MaterialPageRoute(builder: (_) => const LoginScreen());
  //     case register:
  //       return MaterialPageRoute(builder: (_) => const RegistrationScreen());
  //     case onboarding:
  //       return MaterialPageRoute(builder: (_) => const OnboardingScreen());
  //     case main:
  //       return MaterialPageRoute(builder: (_) => const BottomNavBar());
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Scaffold(
  //           body: Center(child: Text('Route not found')),
  //         ),
  //       );
  //   }
  // }
}
