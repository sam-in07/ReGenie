import 'package:flutter/material.dart';
import 'package:regenie/presentation/navigation/bottom_nav.dart';
import 'package:regenie/presentation/widgets/Reminder/add_reminder_button.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder_item.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
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
      backgroundColor: const Color(0xFFD1F1DD),


      // bottomNavigationBar: BottomNavBar(),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [




            // ---------- GREEN HEADER CONTAINER ----------
            Container(
              width: double.infinity,
              height: 290,
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
                      // HEADER BAR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // LEFT: BACK BUTTON (CIRCLE)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.20),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          // CENTER: TITLE + SUBTITLE
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Eco Reminders',
                                style: AppTextstyle.textStyle24whiteW600,
                              ),
                              // SizedBox(height: 2),
                              Text(
                                '3 active reminders',
                                style: AppTextstyle.textStyle16whiteW400,
                              ),
                            ],
                          ),
                          SizedBox(width: 55),
                          // RIGHT: BELL ICON (CIRCLE)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.20),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/reminderscreen/bellicon.png',
                                height: 40,
                                width: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),



                      const SizedBox(height: 16),


                      // Custom Card for Enable Notifications Section
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.40),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // LEFT SIDE
                            Container(
                              width: 235,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Icon
                                  Image.asset(
                                    'assets/reminderscreen/bell_sm.png',
                                    height: 20,
                                    width: 20,
                                    color: AppColors.btn_shades,
                                  ),

                                  SizedBox(width: 12),

                                  // Text Column
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Enable Notifications',
                                          style: AppTextstyle.textStyle16darkblackW600,
                                        ),
                                        Text(
                                          'Receive daily eco reminders',
                                          style: AppTextstyle.textStyle16greyW400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // RIGHT SIDE (toggle)
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child:  Container(
                                width: 32,
                                height: 19,
                                padding: const EdgeInsets.only(left: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF171717),
                                  borderRadius: BorderRadius.circular(33554400),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFAFAFA),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
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





