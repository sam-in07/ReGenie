import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:regenie/presentation/User/Bloc/user_service.dart';
import 'package:regenie/presentation/User/Pages/registration_screen.dart';
import 'package:regenie/presentation/User/Pages/onboarding_screen.dart';
import 'package:regenie/presentation/widgets/Button_Cards/primary_button.dart';
import 'package:regenie/presentation/widgets/app_text.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _login() async {
    setState(() => _loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 🚫 No UserService(), no database write here.

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";

      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    setState(() => _loading = false);
  }



  // 📌 AFTER THAT → your controllers go here
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;







  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD1F1DD),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width * 0.85,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.04,
              horizontal: width * 0.06,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: height * 0.025),

                Text(
                  AppText.wtRe,
                  textAlign: TextAlign.center,
                  style: AppTextstyle.textStyle24greenW600,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(height: height * 0.03),

                // ✅ Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "your@email.com",
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                SizedBox(height: height * 0.02),

                // ✅ Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "••••••••",
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                SizedBox(height: height * 0.03),

                // ✅ Login button
                PrimaryButton(
                  height: 48,
                  width: double.infinity,
                  radius: 10,
                  color: const Color(0xFF00C68E),
                  title: _loading ? "Please wait..." : "Sign In",
                  onTap: _loading ? null : _login,
                ),

                SizedBox(height: height * 0.025),

                // Divider
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                SizedBox(height: height * 0.02),

                // Google Sign-In (you can add later)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Google Auth later
                    },
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 22,
                    ),
                    label: const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                // ✅ Registration link
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account? Create one",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




