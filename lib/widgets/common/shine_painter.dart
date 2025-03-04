import 'package:flutter/material.dart';

class ShinePainter extends CustomPainter {
  final double value;
  final Color startColor;
  final Color endColor;

  ShinePainter({
    required this.value,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient that moves across the box
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          Colors.white.withOpacity(0.3),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
        begin: const Alignment(-1.0, -0.3),
        end: const Alignment(1.0, 0.3),
      ).createShader(
        Rect.fromLTWH(
          size.width * (value * 0.5 + 0.5) - 50,
          0,
          100,
          size.height,
        ),
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ShinePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
