import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/Challenges/pages/challenges_screen.dart';
import 'package:regenie/presentation/Chat/Pages/chat_screen.dart';
import 'package:regenie/presentation/Home/Pages/ReminderScreen.dart';
import 'package:regenie/presentation/Home/Pages/progress_screen.dart';
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
      backgroundColor: const Color(0xFFD1F1DD),


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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👋 Welcome Text
                Container(
                  width: double.infinity,
                  height: 400, // <- explicit height
                  decoration: const BoxDecoration(
                    color: Color(0xFF00BC7D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,


                        children: [
                          const SizedBox(height: 48),


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Texts in a Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome back,",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "$name 👋",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),


                              const SizedBox(
                                width: 290,
                              ), // space between texts and image
                              // Your image
                              Image.asset(
                                "assets/images/leaf_btn.png",
                                width: 48, // adjust size as needed
                                height: 48,
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),


                          // Eco Points Card
                          Container(
                            width: double.infinity,
                            height: 224.3,
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 24,
                              right: 24,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.white.withOpacity(0.95),
                              color: Color(0xFFD0FAE5),

                              borderRadius: BorderRadius.circular(16.4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top row: points and level
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Your Eco Points',
                                          style: TextStyle(
                                            color: Color(0xFF495565),
                                            fontSize: 15.2,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.6,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              '$points',
                                              style: TextStyle(
                                                color: Color(0xFF009865),
                                                fontSize: 20,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 1.4,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Level $level',
                                              style: TextStyle(
                                                color: Color(0xFF697282),
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 1.43,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Optional right icon/avatar placeholder
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200], // placeholder
                                      ),
                                      child: Image.asset(
                                        'assets/images/point.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ],
                                ),


                                const SizedBox(height: 26),


                                // Gradient progress bar
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    Container(
                                      width:
                                      ((points % 100) / 100) *
                                          MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF00D491),
                                            Color(0xFF00BC7C),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ],
                                ),


                                const SizedBox(height: 26),


                                // Points to next level
                                Text(
                                  "${100 - (points % 100)} points to Level ${level + 1}",
                                  style: TextStyle(
                                    color: Color(0xFF697282),
                                    fontSize: 15.2,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                // 🔥 Wrap everything below in padding
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06,
                    vertical: height * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChallengesScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: const Color(0xFF009865),
                                fontSize: width * 0.035,
                                fontFamily: 'Inter',
                              ),
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
                              child: Image.asset(
                                'assets/icons/chall_icon.png',
                                width: 24, // adjust size as needed
                                height: 24,
                                color: Colors
                                    .white, // optional: applies tint color if image is monochrome
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SmallCard(
                      //       color: const Color(0xFFFFFFFF),
                      //       title: "Challenges",
                      //       subtitle: "$challenges completed",
                      //       iconPath: "assets/icons/chall_green.png",
                      //     ),
                      //     SmallCard(
                      //       color: const Color(0xFFFFFFFF),
                      //       title: "Leaderboard",
                      //       subtitle: "Rank #$rank",
                      //       iconPath: "assets/icons/incri_icon.png",
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2, // 2 boxes per row
                        shrinkWrap: true, // important inside Column/ScrollView
                        physics:
                        NeverScrollableScrollPhysics(), // prevent scrolling
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          SmallCard(
                            color: const Color(0xFFFFFFFF),
                            title: "Challenges",
                            subtitle: "$challenges completed",
                            iconPath: "assets/icons/chall_green.png",
                          ),
                          SmallCard(
                            color: const Color(0xFFFFFFFF),
                            title: "Leaderboard",
                            subtitle: "Rank #$rank",
                            iconPath: "assets/icons/incri_icon.png",
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const ProgressTrackerScreen(),
                                ),
                              );
                            },
                            child: SmallCard(
                              color: const Color(0xFFFFFFFF),
                              title: "Progress",
                              subtitle: "achievements unlocked",
                              iconPath: "assets/icons/progress.png",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const Reminderscreen(),
                                ),
                              );
                            },
                            child: SmallCard(
                              color: const Color(0xFFFFFFFF),
                              title: "Notification",
                              // subtitle: "$goals completed",
                              subtitle: "Daily Tips",
                              iconPath: "assets/icons/reminder.png",
                            ),
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
                                  colors: [
                                    Color(0xFFC17AFF),
                                    Color(0xFF50A2FF),
                                  ],
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
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Chat with ReGenie →",
                                        style: TextStyle(
                                          color: const Color(0xFF980FFA),
                                          fontSize: width * 0.035,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}



