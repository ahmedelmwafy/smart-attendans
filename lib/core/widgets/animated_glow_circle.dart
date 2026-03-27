import 'package:flutter/material.dart';

class AnimatedGlowCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double top;
  final double? right;
  final double? left;
  final double bottom;
  final Animation<double> animation;
  final bool useTop;

  const AnimatedGlowCircle({
    super.key,
    required this.size,
    required this.color,
    required this.animation,
    this.top = 0,
    this.right,
    this.left,
    this.bottom = 0,
    this.useTop = true,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: useTop ? top + animation.value : null,
      bottom: !useTop ? bottom + animation.value : null,
      right: right,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.75),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 25,
              spreadRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}