import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/colors.dart';


class DayChip extends StatelessWidget {
  final String day;
  final bool active;

  const DayChip({super.key, required this.day, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.emerald : AppColors.grayLight,
        shape: BoxShape.circle,
      ),
      child: Text(
        day[0],
        style: TextStyle(
          color: active ? Colors.white : AppColors.gray,
        ),
      ),
    );
  }
}
