import 'package:flutter/material.dart';
import 'package:regenie/presentation/Challenges/pages/challenges_screen.dart';
import 'package:regenie/presentation/Chat/Pages/chat_screen.dart';
import 'package:regenie/presentation/Home/Pages/home_screen.dart';
import 'package:regenie/presentation/Leaderboard/pages/leaderboard_screen.dart';
import 'package:regenie/presentation/Profile/Pages/profile_screen.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ChallengesScreen(),
    LeaderboardScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          _buildNavItem('assets/icons/home.png', 'Home', 0),
          _buildNavItem('assets/icons/challnges.png', 'Challenges', 1),
          _buildNavItem('assets/icons/leaderb.png', 'Leaderboard', 2),
          _buildNavItem('assets/icons/chat.png', 'Chat', 3),
          _buildNavItem('assets/icons/profile.png', 'Profile', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, String label, int index) {
    final bool isSelected = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.15) : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]
              : [],
        ),
        child: Image.asset(
          iconPath,
          height: 28,
          width: 28,
          color: isSelected ? Colors.green.shade600 : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
