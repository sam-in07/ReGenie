import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/colors.dart';


class AddReminderButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddReminderButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.emeraldLight, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: AppColors.emerald),
          const SizedBox(width: 8),
          Text("Create Custom Reminder",
              style: TextStyle(color: AppColors.emerald)),
        ],
      ),
    );
  }
}
