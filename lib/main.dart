import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regenie/core/firebase/firebase_options.dart';
import 'package:regenie/core/firebase/firebase_service.dart';
import 'package:regenie/data/repositories/user_repo_impl.dart';
import 'package:regenie/domain/usecases/get_daily_challenge.dart';
import 'package:regenie/presentation/Challenges/Bloc/challenges_cubit.dart';
import 'package:regenie/presentation/Splash/splash_screen.dart';
import 'package:regenie/presentation/User/Bloc/user_cubit.dart';
import 'package:regenie/presentation/User/Pages/login_screen.dart';
import 'package:regenie/presentation/User/Pages/onboarding_screen.dart';
import 'package:regenie/presentation/User/Pages/registration_screen.dart';
import 'package:regenie/presentation/navigation/app_routes.dart';
import 'package:regenie/presentation/navigation/bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  // 🔹 Create base dependencies manually (instead of GetIt)
  final firebaseService = FirebaseService();
  final userRepository = UserRepoImpl(firebaseService);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(userRepository),
        ),
        // 🧩 Add more cubits later like:

        BlocProvider(
          create: (_) => ChallengeCubit(GetDailyChallenge()),
        ),
        // BlocProvider(create: (_) => ChatCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   AppRoutes.main: (context) => const BottomNavBar(),
  //
  //
  //   return MaterialApp(
  //     title: 'ReGenie App',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //       useMaterial3: true,
  //     ),
  //
  //     initialRoute: AppRoutes.splash,
  //     routes: {
  //       AppRoutes.splash: (context) => const SplashScreen(),
  //       AppRoutes.login: (context) => const LoginScreen(),
  //       AppRoutes.register: (context) => const RegistrationScreen(),
  //       AppRoutes.onboarding: (context) => const OnboardingScreen(),
  //       AppRoutes.main: (context) => const BottomNavBar(), // Must be a Widget type
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReGenie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // The first screen that shows up
      initialRoute: AppRoutes.splash,

      // All available routes in your app
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegistrationScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.main: (context) => const BottomNavBar(), // ✅ Correct place
      },
    );
  }

}