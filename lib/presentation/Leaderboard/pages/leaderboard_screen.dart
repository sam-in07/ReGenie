import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regenie/presentation/widgets/Button_Cards/top_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  // 🔹 Fetch leaderboard data from Firestore
  Future<List<Map<String, dynamic>>> _fetchLeaderboard() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('leaderboard')
        .orderBy('points', descending: true)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No leaderboard data yet 😅"));
          }

          final users = snapshot.data!;

          // 🔹 Take top 3 users
          final topUsers = users.take(3).toList();

          // 🔹 Reorder top 3 visually as [2nd, 1st, 3rd]
          List<Map<String, dynamic>> orderedTop = [];
          if (topUsers.length >= 3) {
            orderedTop = [topUsers[1], topUsers[0], topUsers[2]];
          } else {
            orderedTop = topUsers;
          }

          // 🔹 Remaining users
          final others = users.skip(3).toList();

          return Column(
            children: [
              /// ✅ Green rounded header with top 3
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

                        /// 🥇🥈🥉 Top 3 users
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(orderedTop.length, (index) {
                            final user = orderedTop[index];
                            final isFirstPlace = user == topUsers.first;

                            return TopUserCard(
                              name: user['name'] ?? 'Unknown',
                              points: user['points'] ?? 0,
                              color: Colors.tealAccent.shade100,
                              icon: _mapIcon(user['icon']),
                              isFirstPlace: isFirstPlace,
                              avatarSize: isFirstPlace ? 80 : 60,
                            );
                          }),
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
                    final rank = index + 4;
                    // ✅ Get current logged-in user
                    final currentUid = FirebaseAuth.instance.currentUser?.uid;

                    // ✅ Check if this row belongs to the current user
                    final isYou = user['uid'] == currentUid;

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
                            _mapIcon(user['icon']),
                            color: isYou ? Colors.white : Colors.grey[800],
                          ),
                        ),
                        title: Text(
                          user['name'] ?? 'Unknown',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isYou ? Colors.white : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          "Level ${user['level'] ?? '-'}",
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
                                  "${user['points'] ?? 0}",
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
          );
        },
      ),
    );
  }

  /// 🧩 Helper — Convert string icon name from Firestore to actual IconData
  static IconData _mapIcon(String? iconName) {
    switch (iconName) {
      case 'park':
        return Icons.park;
      case 'sunny':
        return Icons.wb_sunny;
      case 'water':
        return Icons.water_drop;
      case 'landscape':
        return Icons.landscape;
      case 'public':
        return Icons.public;
      case 'cloud':
        return Icons.cloud;
      case 'wb_cloudy':
        return Icons.wb_cloudy;
      case 'spa':
        return Icons.spa;
      case 'wb_sunny_outlined':
        return Icons.wb_sunny_outlined;
      case 'eco':
        return Icons.eco;
      default:
        return Icons.person;
    }
  }
}
