import 'package:flutter/material.dart';

class ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const color = Colors.white;
    const strokeWidth = 4.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Top left
    canvas.drawLine(const Offset(0, 20), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(20, 0), paint);

    // Top right
    canvas.drawLine(Offset(size.width - 20, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, 20), paint);

    // Bottom left
    canvas.drawLine(
        Offset(0, size.height - 20), Offset(0, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(20, size.height), paint);

    // Bottom right
    canvas.drawLine(Offset(size.width - 20, size.height),
        Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - 20),
        Offset(size.width, size.height), paint);

    // Center horizontal scan line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}