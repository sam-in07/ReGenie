import 'package:flutter/material.dart';
import 'package:regenie/presentation/Home/Pages/home_screen.dart';
import 'package:regenie/presentation/User/Pages/registration_screen.dart';
import 'package:regenie/presentation/widgets/app_text.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/primary_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                // Logo Image
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: height * 0.025),

                // Welcome text
                Text(
                  AppText.wtRe,
                  textAlign: TextAlign.center,
                  style: AppTextstyle.textStyle24greenW600,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: height * 0.03),

                // Email field
                TextField(
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

                // Password field
                TextField(
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

                // Sign In button
                PrimaryButton(
                  height: 48,
                  width: double.infinity,
                  radius: 10,
                  color: const Color(0xFF00C68E),
                  title: "Sign In",
                  // onTap: () {
                  //   // Handle login tap
                  //   //HomeScreen
                  // },
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomeScreen(),
                      ),
                    );
                  },
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

                // Google sign-in button
                SizedBox(
                  width: double.infinity,
                  height: 48, // same as your PrimaryButton
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.black26),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                     // onPressed: () => context.read<UserCubit>().signInWithGoogle(),
                    },

                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 22, // adjusted for visual balance
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

                // Signup link
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => RegistrationScreen(),
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