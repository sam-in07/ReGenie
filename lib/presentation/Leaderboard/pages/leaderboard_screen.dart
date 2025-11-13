import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/Button_Cards/top_user_card.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/primary_header.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final topUsers = [
      {'name': 'Liam Forest', 'points': 2380, 'color': Colors.grey[300], 'icon': Icons.park},
      {'name': 'Emma Green', 'points': 2450, 'color': const Color(0xFFFFD700), 'icon': Icons.wb_sunny},
      {'name': 'Olivia Ocean', 'points': 2210, 'color': const Color(0xFFFFA500), 'icon': Icons.water},
    ];

    final others = [
      {'rank': 4, 'name': 'Noah River', 'level': 21, 'points': 2050, 'icon': Icons.landscape},
      {'rank': 5, 'name': 'Ava Earth', 'level': 20, 'points': 1920, 'icon': Icons.public},
      {'rank': 6, 'name': 'You', 'level': 19, 'points': 1850, 'icon': Icons.eco},
      {'rank': 7, 'name': 'Ethan Sky', 'level': 18, 'points': 1780, 'icon': Icons.cloud},
      {'rank': 8, 'name': 'Sophia Rain', 'level': 17, 'points': 1650, 'icon': Icons.wb_cloudy},
      {'rank': 9, 'name': 'Mason Wind', 'level': 16, 'points': 1540, 'icon': Icons.spa},
      {'rank': 10, 'name': 'Isabella Sun', 'level': 15, 'points': 1420, 'icon': Icons.wb_sunny_outlined},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          /// ✅ Green rounded header
          Container(
            width: double.infinity,
            height: 220,
            decoration: const BoxDecoration(
              color: Color(0xFF00BC7D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Leaderboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        TopUserCard(
                          name: "Liam Forest",
                          points: 2380,
                          color: Color(0xFF94D4A2),
                          icon: Icons.park,
                          avatarSize: 60,
                        ),
                        TopUserCard(
                          name: "Emma Green",
                          points: 2450,
                          color: Color(0xFFF4E17C),
                          icon: Icons.sunny,
                          isFirstPlace: true,
                          avatarSize: 80,
                        ),
                        TopUserCard(
                          name: "Olivia Ocean",
                          points: 2210,
                          color: Color(0xFF7FD5F6),
                          icon: Icons.water_drop,
                          avatarSize: 60,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),



          /// ✅ Leaderboard list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: others.length,
              itemBuilder: (context, index) {
                final user = others[index];
                final isYou = user['name'] == 'You';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isYou ? const Color(0xFF00C48C) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isYou
                          ? Colors.white.withOpacity(0.2)
                          : Colors.grey[100],
                      child: Icon(
                        user['icon'] as IconData,
                        color: isYou ? Colors.white : Colors.grey[800],
                      ),
                    ),
                    title: Text(
                      user['name'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isYou ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "Level ${user['level']}",
                      style: TextStyle(
                        color: isYou ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: isYou
                                  ? Colors.white
                                  : const Color(0xFF00C48C),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              user['points'].toString(),
                              style: TextStyle(
                                color: isYou ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "points",
                          style: TextStyle(
                            fontSize: 12,
                            color: isYou ? Colors.white70 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🏅 Top user widget
  Widget _buildTopUser(Map<String, Object?> user, double size) {
    return Column(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: user['color'] as Color,
          child: Icon(
            user['icon'] as IconData,
            color: Colors.white,
            size: size / 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user['name'].toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "${user['points']} pts",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
