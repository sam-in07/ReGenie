import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/app_text.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';

import 'package:regenie/presentation/widgets/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👋 Welcome section
            Text(
              "Welcome back,",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: width * 0.04,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: height * 0.004),
            Text(
              "Samin 👋",
              style: TextStyle(
                color: const Color(0xFF009865),
                fontSize: width * 0.055,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: height * 0.03),

            // 🌱 Eco Points Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                color: const Color(0xFF00BC7C),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Eco Points",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.04,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Text(
                    "1850   Level 19",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      color: Colors.white,
                      minHeight: height * 0.01,
                    ),
                  ),
                  SizedBox(height: height * 0.006),
                  Text(
                    "50 points to Level 20",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.03,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.04),

            // 🔥 Today's Challenge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Challenge",
                  style: TextStyle(
                    color: const Color(0xFF1D2838),
                    fontSize: width * 0.05,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: const Color(0xFF009865),
                    fontSize: width * 0.035,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // 💧 Challenge Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00D491), Color(0xFF00BC7C)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: width * 0.12,
                    height: width * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.water_drop_outlined, color: Colors.white),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Use a Reusable Water Bottle",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.04,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          "Skip single-use plastic today and carry your own bottle",
                          style: TextStyle(
                            color: const Color(0xFFEBFCF4),
                            fontSize: width * 0.035,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF009865),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Complete"),
                  )
                ],
              ),
            ),

            SizedBox(height: height * 0.035),

            // 🏆 Two Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _smallCard(
                  width,
                  color: const Color(0xFFD0FAE5),
                  title: "Challenges",
                  subtitle: "3 active tasks",
                  icon: Icons.flag,
                ),
                _smallCard(
                  width,
                  color: const Color(0xFFFEF3C6),
                  title: "Leaderboard",
                  subtitle: "Rank #12",
                  icon: Icons.leaderboard,
                ),
              ],
            ),

            SizedBox(height: height * 0.04),

            // 💬 Ask ReGenie
            Text(
              "Ask ReGenie",
              style: TextStyle(
                color: const Color(0xFF1D2838),
                fontSize: width * 0.05,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: height * 0.02),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFAF5FE), Color(0xFFEEF5FE)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.12,
                    height: width * 0.12,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFC17AFF), Color(0xFF50A2FF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.lightbulb_outline, color: Colors.white),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Eco Tips",
                          style: TextStyle(
                            color: const Color(0xFF1D2838),
                            fontSize: width * 0.04,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          '"Did you know? Unplugging devices can save up to 10% on your energy bill!"',
                          style: TextStyle(
                            color: const Color(0xFF495565),
                            fontSize: width * 0.035,
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          "Chat with ReGenie →",
                          style: TextStyle(
                            color: const Color(0xFF980FFA),
                            fontSize: width * 0.035,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallCard(
      double width, {
        required Color color,
        required String title,
        required String subtitle,
        required IconData icon,
      }) {
    return Container(
      width: width * 0.4,
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: width * 0.07, color: const Color(0xFF1D2838)),
          SizedBox(height: width * 0.06),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF1D2838),
              fontSize: width * 0.04,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: width * 0.02),
          Text(
            subtitle,
            style: TextStyle(
              color: const Color(0xFF697282),
              fontSize: width * 0.035,
              fontFamily: 'Inter',
            ),
          ),

        ],
      ),
    );
  }
}