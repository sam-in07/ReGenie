import 'package:flutter/material.dart';

import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';





class PrimaryButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color? color;
  final Color? borderColor;
  final String title;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  const PrimaryButton({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    required this.title,
    this.color,
    this.borderColor,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ?? AppColors.appButtonColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ??
                AppTextstyle.textStyle22WideW300.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
  }
}
