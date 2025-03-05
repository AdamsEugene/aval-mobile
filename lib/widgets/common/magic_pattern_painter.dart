import 'dart:math';

import 'package:flutter/material.dart';

class MagicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final random = Random(42); // Fixed seed for consistent pattern

    // Draw question marks in random positions
    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 3.0 + random.nextDouble() * 5;

      final path = Path();
      path.addOval(
          Rect.fromCircle(center: Offset(x, y - radius), radius: radius));
      path.addRect(
          Rect.fromLTRB(x - radius / 2, y, x + radius / 2, y + radius * 1.5));
      path.addOval(
          Rect.fromCircle(center: Offset(x, y + radius * 2), radius: radius));

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
