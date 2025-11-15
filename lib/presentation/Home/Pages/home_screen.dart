import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/Button_Cards/small_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),

      // 🔥 STREAM USER DATA FROM FIRESTORE LIVE
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return const Center(child: Text("User data not found"));
          }

          final String name = data['name'] ?? "User";
          final int points = data['points'] ?? 0;
          final int level = data['level'] ?? 1;
          final int rank = data['rank'] ?? 0;
          final int challenges = data['challengesCompleted'] ?? 0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: height * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👋 Welcome Text
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
                  "$name 👋",
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
                        "$points   Level $level",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: height * 0.008),

                      // LEVEL PROGRESS
                      // LEVEL PROGRESS (100 points per level)
                      LinearProgressIndicator(
                        value: (points % 100) / 100,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        color: Colors.white,
                        minHeight: height * 0.01,
                      ),
                      SizedBox(height: height * 0.006),
                      Text(
                        "${100 - (points % 100)} points to next level",
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

                // 🔥 Today's Challenge Header
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

                // 💧 Challenge Card (Static For Now)
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
                        child: const Icon(
                          Icons.water_drop_outlined,
                          color: Colors.white,
                        ),
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
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.035),

                // 🏆 Two Info Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallCard(
                      color: const Color(0xFFD0FAE5),
                      title: "Challenges",
                      subtitle: "$challenges completed",
                      icon: Icons.flag,
                    ),
                    SmallCard(
                      color: const Color(0xFFFEF3C6),
                      title: "Leaderboard",
                      subtitle: "Rank #$rank",
                      icon: Icons.leaderboard,
                    ),
                  ],
                ),

                SizedBox(height: height * 0.04),

                // 💬 Ask ReGenie Section
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
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                        ),
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
          );
        },
      ),
    );
  }
}
