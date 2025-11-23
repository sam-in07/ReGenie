import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String iconPath; // <-- icon as image asset

  const SmallCard({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,   // fixed size as you said
      height: 195,  // fixed size
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌟 Replace Icon() with your asset image
          const SizedBox(height: 18),
          Image.asset(
            iconPath,
            width: 48,   // adjust icon size
            height: 48,
          ),

          const SizedBox(height: 26),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1D2838),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 30),

          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF697282),
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
