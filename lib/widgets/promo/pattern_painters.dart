import 'dart:math' as Math;
import 'package:flutter/material.dart';

/// A custom painter that draws a dot pattern background
/// Useful for adding visual interest to promotional banners
class DotPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;
  final bool isStaggered;

  DotPatternPainter({
    required this.dotColor,
    this.dotSize = 4,
    this.spacing = 20,
    this.isStaggered = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    final rows = (size.height / spacing).ceil() + 1;
    final cols = (size.width / spacing).ceil() + 1;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        // Offset to create a staggered pattern if enabled
        final offset = isStaggered && j.isEven ? 0.0 : spacing / 2;

        canvas.drawCircle(
          Offset(j * spacing, i * spacing + offset),
          dotSize / 2,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(DotPatternPainter oldDelegate) =>
      oldDelegate.dotColor != dotColor ||
      oldDelegate.dotSize != dotSize ||
      oldDelegate.spacing != spacing ||
      oldDelegate.isStaggered != isStaggered;
}

/// A custom painter that draws a diagonal line pattern background
/// Another option for promotional banners
class DiagonalPatternPainter extends CustomPainter {
  final Color lineColor;
  final double lineWidth;
  final double spacing;
  final double angle;

  DiagonalPatternPainter({
    required this.lineColor,
    this.lineWidth = 1.5,
    this.spacing = 15,
    this.angle = 45,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    // Convert angle to radians
    final double angleInRadians = angle * (Math.pi / 180);

    // Calculate how many lines we need to cover the whole area
    final diagonal = size.width + size.height;
    final lines = (diagonal / spacing).ceil();

    // Starting offset based on angle
    final double cosAngle = Math.cos(angleInRadians);
    final double sinAngle = Math.sin(angleInRadians);

    for (int i = -lines; i < lines; i++) {
      final offset = i * spacing;

      // Calculate start and end points for each line
      Offset start;
      Offset end;

      if (offset < 0) {
        start = Offset(0, -offset / sinAngle);
        if (start.dy > size.height) {
          start = Offset(-offset * cosAngle / sinAngle, size.height);
        }

        end = Offset(
            size.width, size.width * sinAngle / cosAngle - offset / sinAngle);
        if (end.dy < 0) {
          end = Offset(offset / cosAngle, 0);
        } else if (end.dy > size.height) {
          end = Offset(
              size.width - (end.dy - size.height) * cosAngle / sinAngle,
              size.height);
        }
      } else {
        start = Offset(offset, 0);
        if (start.dx > size.width) {
          start =
              Offset(size.width, (offset - size.width) * sinAngle / cosAngle);
        }

        end = Offset(0, offset * sinAngle / cosAngle);
        if (end.dy > size.height) {
          end =
              Offset((end.dy - size.height) * cosAngle / sinAngle, size.height);
        } else {
          end = Offset(0, end.dy);
        }
      }

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(DiagonalPatternPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor ||
      oldDelegate.lineWidth != lineWidth ||
      oldDelegate.spacing != spacing ||
      oldDelegate.angle != angle;
}

/// A custom painter that draws a grid pattern background
class GridPatternPainter extends CustomPainter {
  final Color lineColor;
  final double lineWidth;
  final double spacing;

  GridPatternPainter({
    required this.lineColor,
    this.lineWidth = 1.0,
    this.spacing = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor ||
      oldDelegate.lineWidth != lineWidth ||
      oldDelegate.spacing != spacing;
}

/// A custom painter that draws a wave pattern background
class WavePatternPainter extends CustomPainter {
  final Color lineColor;
  final double lineWidth;
  final double amplitude;
  final double frequency;
  final bool horizontal;

  WavePatternPainter({
    required this.lineColor,
    this.lineWidth = 1.5,
    this.amplitude = 10.0,
    this.frequency = 0.1,
    this.horizontal = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (horizontal) {
      // Draw horizontal waves
      final waveCount = (size.height / 30).ceil();
      final waveSpacing = size.height / waveCount;

      for (int i = 0; i < waveCount + 1; i++) {
        final y = i * waveSpacing;
        path.moveTo(0, y);

        for (double x = 0; x <= size.width; x++) {
          final sinValue = Math.sin(x * frequency);
          path.lineTo(x, y + sinValue * amplitude);
        }
      }
    } else {
      // Draw vertical waves
      final waveCount = (size.width / 30).ceil();
      final waveSpacing = size.width / waveCount;

      for (int i = 0; i < waveCount + 1; i++) {
        final x = i * waveSpacing;
        path.moveTo(x, 0);

        for (double y = 0; y <= size.height; y++) {
          final sinValue = Math.sin(y * frequency);
          path.lineTo(x + sinValue * amplitude, y);
        }
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePatternPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor ||
      oldDelegate.lineWidth != lineWidth ||
      oldDelegate.amplitude != amplitude ||
      oldDelegate.frequency != frequency ||
      oldDelegate.horizontal != horizontal;
}
