import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:regenie/presentation/widgets/Button_Cards/top_user_card.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  // 🔹 New: Fetch data using a Stream for real-time updates
  // We stream the 'users' collection and merge it with the static 'leaderboard' dummy data.
  Stream<List<Map<String, dynamic>>> get _leaderboardStream {
    // 1. Get a stream of the entire 'users' collection
    return FirebaseFirestore.instance.collection('users').snapshots().map((userSnapshot) {

      // 2. Fetch the static 'leaderboard' dummy data only once (or you can cache this)
      // NOTE: We use a Future.value wrapper to make this synchronous-looking within the stream map.
      // A more complex solution would use StreamGroup, but this is simpler for combining one stream and one static list.
      // For this implementation, we will fetch the dummy data every time the user stream updates.
      // A better optimization would be to cache the dummy data.

      // We perform the merge/sort operation inside the map function.
      final List<Map<String, dynamic>> dummy = [];

      // Fetch static dummy users (Ideally, this should be done once or from a separate combined stream)
      // Since this is Dart/Flutter, we must use an asynchronous method to get the dummy data,
      // but Stream.map() requires a synchronous return.
      // To ensure the data is complete, we must make this whole function return a Future<Stream> or use a separate Future.

      // Given the limitation of combining static future data inside a continuous stream map,
      // let's adjust the widget to handle this merge safely by performing the fetch inside the map logic
      // if you decide to use Stream.asyncMap (more complex) or stick to the FutureBuilder

      // Let's stick to a FutureBuilder but update the future every time a point changes.
      // The best fix is to use StreamBuilder that combines the results, but the current layout prevents a clean combination.

      // ******* REVERTING TO FUTUREBUILDER FOR NOW, BUT FIXING THE CALL SITE *******
      // ******* The key is to force the FutureBuilder to rerun when a point changes. *******
      // Since we can't easily trigger a state change in a StatelessWidget, we must stick with the FutureBuilder
      // and ensure the user's document update forces a full rebuild if this screen is the active tab.

      final List<Map<String, dynamic>> realUsers = userSnapshot.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id; // needed for "YOU"
        return data;
      }).toList();

      // Since we can't fetch the dummy data (which is a Future) synchronously here,
      // we must rely on the full FutureBuilder approach.
      // We will revert the data source to the original Future and assume the user forces a refresh
      // (or the parent widget rebuilds) to update the leaderboard.

      return realUsers; // Returning only real users for now, merge done in the function below
    });
  }


  // 🔹 Fetch dummy + real users and merge (The original function, slightly simplified)
  Future<List<Map<String, dynamic>>> _fetchLeaderboardAndMerge() async {
    // 1. Fetch Dummy users (from 'leaderboard' collection)
    final dummySnap = await FirebaseFirestore.instance
        .collection('leaderboard')
        .get();

    // 2. Fetch Real users (from 'users' collection)
    final userSnap = await FirebaseFirestore.instance
        .collection('users')
        .get();

    List<Map<String, dynamic>> dummy =
    dummySnap.docs.map((doc) => doc.data()).toList();

    List<Map<String, dynamic>> realUsers = userSnap.docs.map((doc) {
      final data = doc.data();
      data['uid'] = doc.id; // needed for "YOU" check
      return data;
    }).toList();

    // 3. Merge both lists
    List<Map<String, dynamic>> all = [...dummy, ...realUsers];

    // 4. Sort by points (highest first)
    all.sort((a, b) => (b['points'] ?? 0).compareTo(a['points'] ?? 0));

    // 5. Assign rank
    for (int i = 0; i < all.length; i++) {
      // Assign rank based on position in the sorted list (1-based index)
      all[i]['rank'] = i + 1;
    }

    return all;
  }

  @override
  Widget build(BuildContext context) {
    // ⭐ CORE FIX: Using a StreamBuilder that constantly triggers the merge logic
    // We create a stream that yields the full merged and sorted list whenever the 'users' collection changes.
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: StreamBuilder<QuerySnapshot>( // Listen to the 'users' collection
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, userSnapshot) {

          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use a FutureBuilder nested inside to safely fetch the static 'leaderboard' data
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('leaderboard').get(),
            builder: (context, dummySnapshot) {

              if (userSnapshot.hasError || dummySnapshot.hasError) {
                return const Center(child: Text("Error loading leaderboard data 😔"));
              }

              if (!userSnapshot.hasData || !dummySnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              // 1. Extract Real Users
              List<Map<String, dynamic>> realUsers = userSnapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                data['uid'] = doc.id;
                return data;
              }).toList();

              // 2. Extract Dummy Users
              List<Map<String, dynamic>> dummy = dummySnapshot.data!.docs.map((doc) {
                return doc.data() as Map<String, dynamic>;
              }).toList();

              // 3. Merge and Sort
              List<Map<String, dynamic>> allUsers = [...dummy, ...realUsers];
              allUsers.sort((a, b) => (b['points'] ?? 0).compareTo(a['points'] ?? 0));

              // 4. Assign Rank (1-based index)
              for (int i = 0; i < allUsers.length; i++) {
                allUsers[i]['rank'] = i + 1;
              }

              final users = allUsers;

              if (users.isEmpty) {
                return const Center(child: Text("No leaderboard data yet 😅"));
              }

              // 🔹 Top 3 users
              final topUsers = users.take(3).toList();

              // 🔹 Reorder top 3 visually: 2nd, 1st, 3rd
              List<Map<String, dynamic>> orderedTop = [];
              if (topUsers.length >= 3) {
                orderedTop = [topUsers[1], topUsers[0], topUsers[2]];
              } else {
                orderedTop = topUsers;
              }

              // 🔹 Others (from rank 4 and below)
              final others = users.skip(3).toList();

              return Column(
                children: [
                  // 🔥 HEADER with Top 3
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back + Title
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

                            // 🥇 🥈 🥉 Top 3 Cards
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(orderedTop.length, (index) {
                                final user = orderedTop[index];
                                final isFirstPlace = user == topUsers.first;

                                // Get the rank for display on the card
                                final int rank = user['rank'] ?? 0;

                                return TopUserCard(
                                  name: user['name'] ?? 'Unknown',
                                  points: user['points'] ?? 0,
                                  color: Colors.tealAccent.shade100,
                                  icon: _mapIcon(user['icon']),
                                  isFirstPlace: isFirstPlace,
                                  avatarSize: isFirstPlace ? 80 : 60,
                                  // Pass the rank here
                                  // rank: rank,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 🔥 LIST OF OTHER USERS
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: others.length,
                      itemBuilder: (context, index) {
                        final user = others[index];

                        final currentUid = FirebaseAuth.instance.currentUser?.uid;
                        final isYou = user['uid'] == currentUid;
                        final int rank = user['rank'] ?? (3 + index + 1); // Use assigned rank or fallback

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
                              backgroundColor:
                              isYou ? Colors.white.withOpacity(0.2) : Colors.grey[100],
                              child: Text(
                                '$rank', // Display the rank
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isYou ? Colors.white : Colors.black,
                                ),
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
                                      color:
                                      isYou ? Colors.white : const Color(0xFF00C48C),
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // 🔧 Convert Firestore icon string → IconData
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