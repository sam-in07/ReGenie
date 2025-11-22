import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int points;
  final bool completed;
  final VoidCallback? onComplete;

  const ChallengeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.points,
    this.completed = false,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onComplete,   // 👈 Entire card is now clickable
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: completed ? const Color(0xFFE8F8F0) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: completed
              ? Border.all(color: const Color(0xFF0EB177), width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF0FDF7),
              child: Icon(icon, color: const Color(0xFF0EB177)),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: completed ? Colors.grey[700] : Colors.black87,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.trending_up,
                          size: 16, color: Color(0xFF0EB177)),
                      const SizedBox(width: 4),
                      Text(
                        "+$points points",
                        style: const TextStyle(
                          color: Color(0xFF0EB177),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            GestureDetector(
              onTap: onComplete,
              child: Icon(
                completed ? Icons.check_circle : Icons.radio_button_unchecked,
                color:
                completed ? const Color(0xFF0EB177) : Colors.grey[400],
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
