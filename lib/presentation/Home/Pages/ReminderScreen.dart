import 'package:flutter/material.dart';
import 'package:regenie/presentation/navigation/bottom_nav.dart';
import 'package:regenie/presentation/widgets/Reminder/add_reminder_button.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder_item.dart';
import 'package:regenie/presentation/widgets/colors.dart';
import 'package:regenie/presentation/widgets/Reminder/info_card.dart';
 // Import the AppColors

class Reminderscreen extends StatefulWidget {
  const Reminderscreen({super.key});

  @override
  State<Reminderscreen> createState() => _ReminderscreenState();
}

class _ReminderscreenState extends State<Reminderscreen> {
  List<Reminder> reminders = [
    Reminder(
      id: '1',
      title: 'Morning Eco Tip',
      message: "Don't forget your reusable bag today 🌿",
      time: '08:00 AM',
      icon: '🛍️',
      enabled: true,
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    ),
    Reminder(
      id: '2',
      title: 'Hydration Reminder',
      message: 'Stay hydrated with your reusable water bottle 💧',
      time: '10:00 AM',
      icon: '💧',
      enabled: true,
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    ),
    Reminder(
      id: '3',
      title: 'Lunch Time',
      message: 'Choose a plant-based meal today 🥗',
      time: '12:00 PM',
      icon: '🥗',
      enabled: false,
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    ),
    Reminder(
      id: '4',
      title: 'Energy Saver',
      message: 'Remember to unplug unused electronics 🔌',
      time: '06:00 PM',
      icon: '🔌',
      enabled: true,
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    ),
    Reminder(
      id: '5',
      title: 'Night Routine',
      message: 'Did you recycle today? ♻️',
      time: '08:00 PM',
      icon: '♻️',
      enabled: false,
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    ),
  ];

  bool notificationsEnabled = true;

  void toggleReminder(String id) {
    setState(() {
      reminders = reminders.map((reminder) {
        if (reminder.id == id) {
          return reminder.copyWith(enabled: !reminder.enabled);
        }
        return reminder;
      }).toList();
    });
  }

  void deleteReminder(String id) {
    setState(() {
      reminders = reminders.where((reminder) => reminder.id != id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // ---------- GREEN HEADER CONTAINER ----------
            Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                color: Color(0xFF00BC7D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),

                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title Text
                          const Text(
                            'Eco Reminders',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          // Bell Icon (Optional)
                          const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Active reminders text
                      const Text(
                        '3 active reminders',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Custom Card for Enable Notifications Section
                      Container(
                        width: double.infinity,
                        height: 78.70, // Height of the card
                        padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.95), // White background with opacity
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.40), // Rounded corners
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: 350,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Left side: Text content
                                    Container(
                                      width: 234.30,
                                      height: 46.70,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Notification Icon
                                          Container(
                                            width: 20,
                                            height: 20,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Icon(
                                              Icons.notifications,
                                              size: 20,
                                              color: Color(0xFF00BC7D), // Green color for the icon
                                            ),
                                          ),
                                          // Text content in column
                                          Expanded(
                                            child: Container(
                                              height: 46.70,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Title for notification toggle
                                                  Text(
                                                    'Enable Notifications',
                                                    style: TextStyle(
                                                      color: Color(0xFF1D2838),
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600,
                                                      height: 1.40,
                                                    ),
                                                  ),
                                                  // Subtitle for reminder info
                                                  Text(
                                                    'Receive daily eco reminders',
                                                    style: TextStyle(
                                                      color: Color(0xFF495565),
                                                      fontSize: 15.20,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.60,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Right side: Toggle switch container
                                    Container(
                                      width: 32,
                                      height: 18.39,
                                      padding: const EdgeInsets.only(left: 14),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF171717), // Background color for toggle
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: Colors.black.withOpacity(0), // No border
                                          ),
                                          borderRadius: BorderRadius.circular(33554400),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Inner white circle representing the switch
                                          Container(
                                            width: 16,
                                            height: 16,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFAFAFA), // White circle
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(33554400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),



            // ---------- MAIN CONTENT BELOW GREEN HEADER ----------
            // ---------- MAIN CONTENT BELOW GREEN HEADER ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Body content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      shrinkWrap: true, // Ensures the ListView does not expand infinitely
                      children: [
                        AddReminderButton(
                          onPressed: () {
                            // Handle adding a new reminder
                          },
                        ),
                        const SizedBox(height: 16),
                        // Map through reminders list to display them
                        ...reminders.map((reminder) => ReminderItem(
                          reminder: reminder,
                          onToggle: () => toggleReminder(reminder.id),
                          onDelete: () => deleteReminder(reminder.id),
                        )),
                        const InfoCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
