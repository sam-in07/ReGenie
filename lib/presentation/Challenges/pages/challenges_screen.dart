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

  // Challenge data
  final List<Map<String, dynamic>> allChallenges = [
    {
      "icon": Icons.water_drop,
      "title": "Use a Reusable Water Bottle",
      "subtitle": "Skip single-use plastic today",
      "points": 15,
      "type": "Daily",
      "completed": false,
    },
    {
      "icon": Icons.directions_bike,
      "title": "Bike or Walk Instead of Driving",
      "subtitle": "Use eco-friendly transportation",
      "points": 25,
      "type": "Daily",
      "completed": false,
    },
    {
      "icon": Icons.eco,
      "title": "Meatless Monday",
      "subtitle": "Try a plant-based meal today",
      "points": 20,
      "type": "Daily",
      "completed": true,
    },
    {
      "icon": Icons.power_off,
      "title": "Unplug Unused Electronics",
      "subtitle": "Save energy by unplugging devices",
      "points": 10,
      "type": "Daily",
      "completed": false,
    },
    {
      "icon": Icons.park,
      "title": "Plant a Tree",
      "subtitle": "Contribute to reforestation",
      "points": 100,
      "type": "Weekly",
      "completed": false,
    },
    {
      "icon": Icons.recycling,
      "title": "Zero Waste Week",
      "subtitle": "No single-use items for 7 days",
      "points": 150,
      "type": "Weekly",
      "completed": false,
    },
    {
      "icon": Icons.grass,
      "title": "Compost Food Scraps",
      "subtitle": "Start composting this week",
      "points": 50,
      "type": "Weekly",
      "completed": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter challenges based on selected tab
    List<Map<String, dynamic>> displayedChallenges = [];

    if (selectedTab == "Completed") {
      displayedChallenges = allChallenges.where((c) => c["completed"]).toList();
    } else {
      displayedChallenges =
          allChallenges.where((c) => c["type"] == selectedTab).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          PrimaryHeader(
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Challenges",
                  style: AppTextstyle.textStyle22WideW300,
                ),
                const SizedBox(height: 20),

                // Toggle buttons
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
                          onTap: () {
                            setState(() => selectedTab = tab);
                          },
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
              itemCount: displayedChallenges.length,
              itemBuilder: (context, index) {
                final challenge = displayedChallenges[index];
                return ChallengeCard(
                  icon: challenge["icon"],
                  title: challenge["title"],
                  subtitle: challenge["subtitle"],
                  points: challenge["points"],
                  completed: challenge["completed"],
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}


