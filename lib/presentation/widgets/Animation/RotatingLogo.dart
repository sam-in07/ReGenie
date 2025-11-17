import 'package:flutter/material.dart';

class RotatingLogo extends StatefulWidget {
  final String imagePath;
  final double size;

  const RotatingLogo({
    super.key,
    required this.imagePath,
    this.size = 250,
  });

  @override
  State<RotatingLogo> createState() => _RotatingLogoState();
}

class _RotatingLogoState extends State<RotatingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Animate forward then repeat with reverse (like a shake/rotate effect)
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: -0.05, end: 0.05).animate(_controller),
      child: Image.asset(
        widget.imagePath,
        width: widget.size,
        height: widget.size,
        fit: BoxFit.contain,
      ),
    );
  }
}
