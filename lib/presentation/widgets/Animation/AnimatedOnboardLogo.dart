import 'package:flutter/material.dart';

class AnimatedOnboardLogo extends StatefulWidget {
  final String imagePath;
  final double size;

  const AnimatedOnboardLogo({
    super.key,
    required this.imagePath,
    this.size = 250,
  });

  @override
  State<AnimatedOnboardLogo> createState() => _AnimatedOnboardLogoState();
}

class _AnimatedOnboardLogoState extends State<AnimatedOnboardLogo>
    with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final AnimationController _moveController;

  @override
  void initState() {
    super.initState();

    // Phase 1: rotation on load
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _rotateController.forward();

    // Phase 2: subtle floating movement
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _moveController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotateController, _moveController]),
      builder: (context, child) {
        // Phase 1 rotation: start -> end 0.05 radians
        final rotation = Tween<double>(begin: -0.1, end: 0.0)
            .animate(CurvedAnimation(
          parent: _rotateController,
          curve: Curves.easeOut,
        ))
            .value;

        // Phase 2 movement: up-down floating
        final offsetY = Tween<double>(begin: -5, end: 5)
            .animate(CurvedAnimation(
          parent: _moveController,
          curve: Curves.easeInOut,
        ))
            .value;

        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Transform.rotate(
            angle: rotation,
            child: Image.asset(
              widget.imagePath,
              width: widget.size,
              height: widget.size,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
