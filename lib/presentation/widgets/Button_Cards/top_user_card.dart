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
    // 🟡 Optional: gradient gold background for 1st place
    final BoxDecoration avatarDecoration = isFirstPlace
        ? const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFDC700), Color(0xFFF0B000)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
    )
        : BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );

    return SizedBox(
      width: 95,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // 🌿 White info box under avatar
          Positioned(
            top: avatarSize / 1.6,
            child: Container(
              width: 95,
              padding: const EdgeInsets.only(
                top: 38,
                bottom: 12,
                left: 6,
                right: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$points pts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isFirstPlace
                          ? const Color(0xFF009865)
                          : Colors.black54,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🟡 Avatar (with optional gradient)
          Container(
            height: avatarSize,
            width: avatarSize,
            decoration: avatarDecoration,
            child: Icon(
              icon,
              color: Colors.white,
              size: avatarSize / 2.1,
            ),
          ),

          // 👑 Crown for 1st place
          if (isFirstPlace)
            Positioned(
              top: -16,
              child: Icon(
                Icons.emoji_events,
                color: Colors.amber[700],
                size: 28,
              ),
            ),
        ],
      ),
    );
  }
}
