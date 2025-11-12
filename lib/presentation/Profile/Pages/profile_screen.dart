import 'package:flutter/material.dart';
import 'package:regenie/presentation/User/Pages/login_screen.dart';
import 'package:regenie/presentation/widgets/Button_Cards/achievement_card.dart';
import 'package:regenie/presentation/widgets/Button_Cards/primary_button.dart';
import 'package:regenie/presentation/widgets/Button_Cards/stat_card.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: AppTextstyle.textStyle12BlackW500,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  // Profile Image Placeholder
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.eco,
                      color: Color(0xFF00B686),
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Samin",
                    style: AppTextstyle.textStyle12BlackW500.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Level 19 Eco Champion",
                      style: AppTextstyle.textStyle16blackW400.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🧾 Stats Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                StatCard(title: "Points", value: "1850", icon: Icons.show_chart),
                StatCard(title: "Rank", value: "#12", icon: Icons.emoji_events),
                StatCard(title: "Badges", value: "3", icon: Icons.badge),
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
                AchievementCard(title: "First Steps", achieved: true),
                AchievementCard(title: "Eco Warrior", achieved: true),
                AchievementCard(title: "Week Streak", achieved: true),
                AchievementCard(title: "Plant Parent", achieved: false),
                AchievementCard(title: "Eco Master", achieved: false),
                AchievementCard(title: "Zero Waste", achieved: false),
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
                        style: AppTextstyle.textStyle16blackW400.copyWith(
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
                    style: AppTextstyle.textStyle16blackW400.copyWith(
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
              onTap: () {

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => LoginScreen(),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
