import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/Button_Cards/challenge_card.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/primary_header.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  String selectedTab = "Daily";
  final List<String> tabs = ["Daily", "Weekly", "Completed"];

  List<String> completedChallengeIds = [];

  // ⚡ EACH CHALLENGE HAS A UNIQUE ID
  final List<Map<String, dynamic>> allChallenges = [
    // ---------------- DAILY CHALLENGES ----------------
    {
      "id": "d1",
      "icon": Icons.water_drop,
      "title": "Use a Reusable Water Bottle",
      "subtitle": "Skip single-use plastic today",
      "points": 15,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d2",
      "icon": Icons.directions_bike,
      "title": "Bike or Walk Instead of Driving",
      "subtitle": "Use eco-friendly transportation",
      "points": 25,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d3",
      "icon": Icons.eco,
      "title": "Meatless Monday",
      "subtitle": "Try a plant-based meal today",
      "points": 20,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d4",
      "icon": Icons.power_off,
      "title": "Unplug Unused Electronics",
      "subtitle": "Save energy by unplugging devices",
      "points": 10,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d5",
      "icon": Icons.lightbulb,
      "title": "Turn Off Extra Lights",
      "subtitle": "Save electricity whenever possible",
      "points": 10,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d6",
      "icon": Icons.shopping_bag,
      "title": "Use a Reusable Shopping Bag",
      "subtitle": "Avoid plastic bags today",
      "points": 15,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d7",
      "icon": Icons.restaurant,
      "title": "No Food Waste Day",
      "subtitle": "Finish all meals without waste",
      "points": 20,
      "type": "Daily",
      "completed": false,
    },
    {
      "id": "d8",
      "icon": Icons.local_florist,
      "title": "Pick Up Litter",
      "subtitle": "Clean 5 pieces of trash from around you",
      "points": 20,
      "type": "Daily",
      "completed": false,
    },

    // ---------------- WEEKLY CHALLENGES ----------------
    {
      "id": "w1",
      "icon": Icons.park,
      "title": "Plant a Tree",
      "subtitle": "Contribute to reforestation",
      "points": 100,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w2",
      "icon": Icons.recycling,
      "title": "Zero Waste Week",
      "subtitle": "Avoid any single-use items for 7 days",
      "points": 150,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w3",
      "icon": Icons.grass,
      "title": "Compost Food Scraps",
      "subtitle": "Start composting this week",
      "points": 50,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w4",
      "icon": Icons.clean_hands,
      "title": "Clean a Public Space",
      "subtitle": "Join or do a neighborhood clean-up",
      "points": 120,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w5",
      "icon": Icons.energy_savings_leaf,
      "title": "Reduce Energy Use",
      "subtitle": "Lower electricity use for 3 days",
      "points": 80,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w6",
      "icon": Icons.water,
      "title": "Save Water Week",
      "subtitle": "Limit water use for 5 days",
      "points": 90,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w7",
      "icon": Icons.public,
      "title": "Avoid Using Plastic",
      "subtitle": "No plastic bottles for a week",
      "points": 150,
      "type": "Weekly",
      "completed": false,
    },
    {
      "id": "w8",
      "icon": Icons.car_crash,
      "title": "Avoid Car Usage",
      "subtitle": "No car use for 3 days",
      "points": 70,
      "type": "Weekly",
      "completed": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    loadCompletedChallenges();
  }

  /// 🔥 Load completed challenge IDs from Firestore
  Future<void> loadCompletedChallenges() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    completedChallengeIds =
    List<String>.from(snapshot['completedChallenges'] ?? []);

    for (var challenge in allChallenges) {
      challenge['completed'] =
          completedChallengeIds.contains(challenge['id']);
    }

    setState(() {});
  }

  /// 🔥 Complete challenge and update Firestore
  Future<void> completeChallenge(int points, String challengeId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = FirebaseFirestore.instance.collection('users').doc(uid);

    await FirebaseFirestore.instance.runTransaction((tx) async {
      final snap = await tx.get(doc);
      if (!snap.exists) return;

      final currentPoints = snap['points'] ?? 0;
      final completedCount = snap['challengesCompleted'] ?? 0;

      List<String> completedIds =
      List<String>.from(snap['completedChallenges'] ?? []);

      if (!completedIds.contains(challengeId)) {
        completedIds.add(challengeId);
      }

      final newPoints = currentPoints + points;
      final newLevel = (newPoints ~/ 100) + 1;

      tx.update(doc, {
        "points": newPoints,
        "level": newLevel,
        "completedChallenges": completedIds,
        "challengesCompleted": completedCount + 1,
        "updatedAt": FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visibleChallenges = [];

    if (selectedTab == "Completed") {
      visibleChallenges =
          allChallenges.where((c) => c["completed"] == true).toList();
    } else {
      visibleChallenges =
          allChallenges.where((c) => c["type"] == selectedTab).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFD1F1DD),
      body: Column(
        children: [
          PrimaryHeader(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/back_btn.png",
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text("Challenges", style: AppTextstyle.textStyle22WideW300),
                  ],
                ),

                const SizedBox(height: 20),

                // TABS SECTION
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: tabs.map((tab) {
                      final isSelected = tab == selectedTab;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedTab = tab),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              tab,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF0EB177)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),


          // Challenge List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: visibleChallenges.length,
              itemBuilder: (context, index) {
                final ch = visibleChallenges[index];

                return ChallengeCard(
                  icon: ch["icon"],
                  title: ch["title"],
                  subtitle: ch["subtitle"],
                  points: ch["points"],
                  completed: ch["completed"],
                  onComplete: () async {
                    if (!ch["completed"]) {
                      setState(() => ch["completed"] = true);

                      await completeChallenge(
                        ch["points"],
                        ch["id"],
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "+${ch["points"]} points earned!",
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
