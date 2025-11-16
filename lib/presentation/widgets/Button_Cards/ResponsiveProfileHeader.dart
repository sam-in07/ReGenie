import 'package:flutter/material.dart';

class PrimaryHeader extends StatelessWidget {
  final double height;
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final Color color;

  const PrimaryHeader({
    super.key,
    required this.child,
    this.height = 180,
    this.borderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    this.color = const Color(0xFF0EB177), // Dark Eco Green
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}