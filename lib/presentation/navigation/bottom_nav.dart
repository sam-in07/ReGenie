import 'package:flutter/material.dart';
import 'package:regenie/presentation/Home/Pages/home_screen.dart';
import 'package:regenie/presentation/Challenges/pages/challenges_screen.dart';
import 'package:regenie/presentation/Leaderboard/pages/leaderboard_screen.dart';
import 'package:regenie/presentation/Chat/Pages/chat_screen.dart';
import 'package:regenie/presentation/Profile/Pages/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  late final List<Widget> _pages = const [
    HomeScreen(),
    ChallengesScreen(),
    LeaderboardScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: Colors.green.withOpacity(0.15),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          _buildNavItem('assets/icons/home.png', 'Home', 0),
          _buildNavItem('assets/icons/challnges.png', 'Challenges', 1),
          _buildNavItem('assets/icons/leaderb.png', 'Leaderboard', 2),
          _buildNavItem('assets/icons/chat.png', 'Chat', 3),
          _buildNavItem('assets/icons/profile.png', 'Profile', 4),
        ],
      ),
    );
  }

  NavigationDestination _buildNavItem(String asset, String label, int index) {
    final bool isSelected = _currentIndex == index;

    return NavigationDestination(
      icon: Image.asset(
        asset,
        height: 26,
        width: 26,
        filterQuality: FilterQuality.high,
        color: isSelected ? Colors.green : Colors.grey,
      ),
      selectedIcon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          asset,
          height: 26,
          width: 26,
          filterQuality: FilterQuality.high,
          color: Colors.green,
        ),
      ),
      label: label,
    );
  }

}