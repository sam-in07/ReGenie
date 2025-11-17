import 'package:flutter/material.dart';

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
          children: const [
            Text("💡", style: TextStyle(fontSize: 32)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "ReGenie learns your habits and sends personalized reminders at the best times to help you stay eco-friendly!",
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
