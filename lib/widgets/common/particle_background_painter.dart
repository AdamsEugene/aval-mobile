// Particle background painter
import 'dart:math';

import 'package:flutter/material.dart';

class ParticleBackgroundPainter extends CustomPainter {
  final double animation;
  final List<Particle> particles = [];

  ParticleBackgroundPainter({
    required this.animation,
  }) {
    if (particles.isEmpty) {
      _initParticles();
    }
  }

  void _initParticles() {
    final random = Random();
    for (int i = 0; i < 100; i++) {
      particles.add(
        Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 1 + random.nextDouble() * 3,
          speed: 0.001 + random.nextDouble() * 0.003,
          offset: random.nextDouble() * 2 * pi,
          color: Colors.white.withOpacity(0.1 + random.nextDouble() * 0.5),
        ),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw particles
    for (final particle in particles) {
      // Update position based on animation
      final x = (particle.x +
              sin(animation * 2 * pi + particle.offset) * particle.speed) *
          size.width;
      final y = (particle.y +
              cos(animation * 2 * pi + particle.offset) * particle.speed) *
          size.height;

      paint.color = particle.color;
      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticleBackgroundPainter oldDelegate) => true;
}

// Particle class
class Particle {
  double x;
  double y;
  double size;
  double speed;
  double offset;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.offset,
    required this.color,
  });
}
