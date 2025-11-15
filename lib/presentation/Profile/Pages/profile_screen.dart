import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/User/Pages/login_screen.dart';
import 'package:regenie/presentation/widgets/Button_Cards/achievement_card.dart';
import 'package:regenie/presentation/widgets/Button_Cards/primary_button.dart';
import 'package:regenie/presentation/widgets/Button_Cards/stat_card.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String? _name;
  String? _email;

  int _points = 0;
  int _rank = 0;
  int _challengesCompleted = 0;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc =
      await _firestore.collection('users').doc(user.uid).get();

      final data = doc.data();

      setState(() {
        _name = data?['name'] ?? user.displayName ?? 'Eco User';
        _email = data?['email'] ?? user.email ?? '';

        // Fetch stats
        _points = data?['points'] ?? 0;
        _rank = data?['rank'] ?? 0;
        _challengesCompleted = data?['challengesCompleted'] ?? 0;

        _loading = false;
      });
    } catch (_) {
      setState(() {
        _name = user.displayName ?? 'Eco User';
        _email = user.email ?? '';
        _loading = false;
      });
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Profile", style: AppTextstyle.textStyle12BlackW500),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🌿 Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.appButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.eco,
                        color: Color(0xFF00B686), size: 40),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _name ?? 'Eco User',
                    style:
                    AppTextstyle.textStyle12BlackW500.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _email ?? '',
                    style: AppTextstyle.textStyle16blackW400.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🧾 Stats Cards Row (NOW USING FIRESTORE DATA)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(
                  title: "Points",
                  value: _points.toString(),
                  icon: Icons.show_chart,
                ),
                StatCard(
                  title: "Rank",
                  value: "#$_rank",
                  icon: Icons.emoji_events,
                ),
                StatCard(
                  title: "Badges",
                  value: _challengesCompleted.toString(),
                  icon: Icons.badge,
                ),
              ],
            ),

            const SizedBox(height: 25),

            // 🏆 Achievements Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Achievements",
                style: AppTextstyle.textStyle12BlackW500.copyWith(
                  fontWeight: FontWeight.w600,
                ),
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
                    title: "First Steps", achieved: true),
                AchievementCard(
                    title: "Eco Warrior", achieved: true),
                AchievementCard(
                    title: "Week Streak", achieved: true),
                AchievementCard(
                    title: "Plant Parent", achieved: false),
                AchievementCard(
                    title: "Eco Master", achieved: false),
                AchievementCard(
                    title: "Zero Waste", achieved: false),
              ],
            ),

            const SizedBox(height: 25),

            // ⚙️ Settings Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: AppTextstyle.textStyle12BlackW500.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 🌙 Dark Mode
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wb_sunny_outlined,
                          color:
                          Colors.black.withOpacity(0.7)),
                      const SizedBox(width: 10),
                      Text(
                        "Dark Mode",
                        style: AppTextstyle
                            .textStyle16blackW400
                            .copyWith(
                          fontWeight: FontWeight.w500,
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 14),
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
                    style: AppTextstyle.textStyle16blackW400
                        .copyWith(
                      fontWeight: FontWeight.w500,
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
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
