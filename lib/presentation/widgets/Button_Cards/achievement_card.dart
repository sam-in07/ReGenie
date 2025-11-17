import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';


class AchievementCard extends StatelessWidget {
  final String title;
  final bool achieved;
  final String? imagePath; // You can pass your design image later


  const AchievementCard({
    super.key,
    required this.title,
    required this.achieved,
    this.imagePath,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 119, // Set the width from design
      height: 124, // Set the height from design
      decoration: BoxDecoration(
        color: achieved ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achieved ? AppColors.appButtonColor : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🖼 Replace this with your actual image asset later
          imagePath != null
              ? Image.asset(
                  imagePath!,
                  height: 28,
                  width: 28,
                  color: achieved ? null : Colors.grey,
                )
              : Icon(
                  achieved ? Icons.eco : Icons.lock_outline,
                  color: achieved ? AppColors.appButtonColor : Colors.grey,
                  size: 28,
                ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextstyle.textStyle16darkblackW400.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: achieved ? Colors.black87 : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}



