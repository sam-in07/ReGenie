import 'package:flutter/material.dart';

class TopUserCard extends StatelessWidget {
  final String name;
  final int points;
  final Color color;
  final IconData icon;
  final bool isFirstPlace;
  final double avatarSize;

  const TopUserCard({
    super.key,
    required this.name,
    required this.points,
    required this.color,
    required this.icon,
    this.isFirstPlace = false,
    this.avatarSize = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // White half-overlapping box
          Positioned(
            top: avatarSize / 2.2,
            child: Container(
              width: 95,
              padding: const EdgeInsets.only(top: 32, bottom: 10, left: 6, right: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Placeholder for your custom image
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "$points pts",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Circle avatar
          CircleAvatar(
            radius: avatarSize / 2,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: avatarSize / 2,
            ),
          ),

          // Crown for first place
          if (isFirstPlace)
            Positioned(
              top: -14,
              child: Icon(
                Icons.emoji_events,
                color: Colors.amber[700],
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}
