import 'package:flutter/material.dart';

class ActionData {
  final String title;
  final int count;
  final IconData icon;
  final Color iconColor;

  ActionData(this.title, this.count, this.icon, this.iconColor);
}

class ActionBreakdownTile  extends StatelessWidget {
  final ActionData action;

  const ActionBreakdownTile ({required this.action});

  @override
  Widget build(BuildContext context) {
    final double progress = (action.count / 30).clamp(0, 1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(action.icon, color: action.iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    color: action.iconColor,
                    backgroundColor: action.iconColor.withOpacity(0.3),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            "${action.count}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: action.iconColor,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            "times",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

