import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/User/Pages/login_screen.dart';
import 'package:regenie/presentation/widgets/Button_Cards/ResponsiveProfileHeader.dart';
import 'package:regenie/presentation/widgets/Button_Cards/achievement_card.dart';
import 'package:regenie/presentation/widgets/Button_Cards/primary_button.dart';
import 'package:regenie/presentation/widgets/Button_Cards/stat_card.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';
import 'package:regenie/presentation/widgets/primary_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Use the currently authenticated user's UID
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      // Navigate back to Login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uid = currentUserId;

    if (uid == null) {
      // Should not happen if user is logged in, but safe check
      return const Center(child: Text("User not logged in."));
    }

    return Scaffold(
        backgroundColor: const Color(0xFFD1F1DD),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Text("Profile", style: AppTextstyle.textStyle12BlackW500),
      // ),

      // ⭐ CORE FIX: Use StreamBuilder for real-time data
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return const Center(child: Text("User profile data not found."));
          }

          // Safely extract data from the stream
          final data = snapshot.data!.data() as Map<String, dynamic>;

          final String name = data['name'] ?? 'Eco User';
          final String email = data['email'] ?? FirebaseAuth.instance.currentUser?.email ?? '';
          final int points = data['points'] ?? 1000;
          final int rank = data['rank'] ?? 11;
          final int challengesCompleted = data['challengesCompleted'] ?? 0;

          return SingleChildScrollView(
           // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🌿 Profile Header

              Container(
                width: double.infinity,
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFF00BC7D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              child: SafeArea(
                //bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: ImageIcon(
                          AssetImage("assets/profiles/leaf_sm.png"),
                          size: 40,
                          color: Color(0xFF00B686),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        name,
                        style: AppTextstyle.textStyle12BlackW500.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        email,
                        style: AppTextstyle.textStyle16blackW400.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),




              const SizedBox(height: 20),

                // 🧾 Stats Cards Row (NOW USING REAL-TIME DATA)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatCard(
                      title: "Points",
                      value: points.toString(),
                      icon: Image.asset(
                        "assets/profiles/incri.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 3),
                    StatCard(
                      title: "Rank",
                      value: "#$rank", // Real-time rank
                        icon: Image.asset(
                          "assets/profiles/prize.png",
                          fit: BoxFit.contain,
                        ),
                    ),
                    SizedBox(width: 3),
                    StatCard(
                      title: "Badges",
                      value: challengesCompleted.toString(), // Real-time challenges completed
                        icon: Image.asset(
                          "assets/profiles/badge.png",
                          fit: BoxFit.contain,
                        ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // 🏆 Achievements Section (Static for now)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Achievements",
                    style: AppTextstyle.textStyle20darkblackW600
                    //     .copyWith(
                    //   fontWeight: FontWeight.w600,
                    // )
                    ,
                  ),
                ),
                const SizedBox(height: 12),

                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: const [
                    AchievementCard(
                      title: "First Steps",
                      achieved: true,
                      imagePath: "assets/profiles/plant.png",
                    ),

                    AchievementCard(title: "Eco Warrior", achieved: true , imagePath: "assets/profiles/warriror.png",),
                    AchievementCard(title: "Week Streak", achieved: true , imagePath: "assets/profiles/fire.png",),
                    AchievementCard(title: "Plant Parent", achieved: false , imagePath: "assets/profiles/tree.png",),
                    AchievementCard(title: "Eco Master", achieved: false , imagePath: "assets/profiles/master.png",),
                    AchievementCard(title: "Zero Waste", achieved: false , imagePath: "assets/profiles/recycle.png",),
                  ],
                ),

                const SizedBox(height: 25),

                // ⚙️ Settings Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Settings",
                    style: AppTextstyle.textStyle20darkblackW600.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 🌙 Dark Mode
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.wb_sunny_outlined,
                              color: Colors.black.withOpacity(0.7)),
                          const SizedBox(width: 10),
                          Text(
                            "Dark Mode",
                            style: AppTextstyle.textStyle16darkblackW600.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: false,
                        onChanged: (value) {},
                        activeColor: AppColors.appButtonColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ⚙️ App Settings
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.settings_outlined,
                          color: Colors.black.withOpacity(0.7)),
                      const SizedBox(width: 10),
                      Text(
                        "App Settings",
                        style: AppTextstyle.textStyle16darkblackW600.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // 🚪 Logout Button
                PrimaryButton(
                  height: 50,
                  width: double.infinity,
                  radius: 10,
                  title: "Logout",
                  color: Colors.redAccent,
                  onTap: () => _logout(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}