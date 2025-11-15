import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  const SmallCard({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.4,
      padding: EdgeInsets.all(width * 0.05),
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
          Icon(icon, size: width * 0.07, color: const Color(0xFF1D2838)),
          SizedBox(height: width * 0.06),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF1D2838),
              fontSize: width * 0.04,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: width * 0.02),
          Text(
            subtitle,
            style: TextStyle(
              color: const Color(0xFF697282),
              fontSize: width * 0.035,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
