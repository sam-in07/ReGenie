import 'dart:math' as math;
import 'package:flutter/material.dart';

class ShakingLogo extends StatefulWidget {
  const ShakingLogo({super.key});

  @override
  State<ShakingLogo> createState() => _ShakingLogoState();
}

class _ShakingLogoState extends State<ShakingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true); // Continuous vibration effect
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Image.asset('assets/images/logo.png'),
      ),
      builder: (context, child) {
        double angle = math.sin(_controller.value * 2 * math.pi) * 0.07;
        return Transform.rotate(
          angle: angle,
          child: child,
        );
      },
    );
  }
}
