import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder.dart';
import 'package:regenie/presentation/widgets/colors.dart';

import 'day_chip.dart';

class ReminderItem extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ReminderItem({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = !reminder.enabled;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: disabled ? 0.5 : 1,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reminder.icon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reminder.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: disabled ? AppColors.gray : Colors.black87,
                          ),
                        ),
                        Switch(
                          value: reminder.enabled,
                          onChanged: (_) => onToggle(),
                        )
                      ],
                    ),
                    Text(
                      reminder.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.gray),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 16, color: AppColors.gray),
                        const SizedBox(width: 4),
                        Text(reminder.time,
                            style: const TextStyle(color: AppColors.gray)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 5,
                      children: reminder.days
                          .map((d) => DayChip(
                        day: d,
                        active: reminder.enabled,
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: onDelete,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.delete, color: Colors.red, size: 18),
                          SizedBox(width: 4),
                          Text("Delete",
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
