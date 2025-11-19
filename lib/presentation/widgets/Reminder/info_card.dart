import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children:  [
           // Text("💡", style: TextStyle(fontSize: 32)),
            Image.asset(
              'assets/reminderscreen/batti.png',
              height: 32,
              width: 24,
            ),
            SizedBox(width: 12),
            Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Smart Reminders",
                      style : AppTextstyle.textStyle16darkblackW600,
                   ),
                   const SizedBox(height: 6,) ,
                   Text(
                     "ReGenie learns your habits and sends personalized reminders at the best times to help you stay eco-friendly!",
                     style : AppTextstyle.textStyle16greyW400,
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
