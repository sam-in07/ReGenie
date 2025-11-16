import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 117,
      height: 158,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // matches your design
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 26, height: 26, child: icon),
            const SizedBox(height: 12),
            Text(
              value,
              style: AppTextstyle.textStyle16darkblackW600,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: AppTextstyle.textStyle16greyW400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
