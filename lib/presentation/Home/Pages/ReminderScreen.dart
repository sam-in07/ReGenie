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
      backgroundColor: AppColors.grayLight,
      appBar: AppBar(
        title: const Text("Eco Reminders"),
        actions: [
          IconButton(
            icon: Icon(
              notificationsEnabled ? Icons.notifications : Icons.notifications_off,
            ),
            onPressed: () {
              setState(() {
                notificationsEnabled = !notificationsEnabled;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            AddReminderButton(
              onPressed: () {
                // Handle adding a new reminder
              },
            ),
            const SizedBox(height: 16),
            ...reminders.map((reminder) => ReminderItem(
              reminder: reminder,
              onToggle: () => toggleReminder(reminder.id),
              onDelete: () => deleteReminder(reminder.id),
            )),
            const InfoCard(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
