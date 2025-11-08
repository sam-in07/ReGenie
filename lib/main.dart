import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regenie/core/firebase/firebase_options.dart';
import 'package:regenie/core/firebase/firebase_service.dart';
import 'package:regenie/data/repositories/user_repo_impl.dart';
import 'package:regenie/presentation/Splash/splash_screen.dart';
import 'package:regenie/presentation/User/Bloc/user_cubit.dart';

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

        // BlocProvider(
        //     create: (_) =>
        //         ChallengeCubit()
        // ),
        // BlocProvider(create: (_) => ChatCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReGenie App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}


