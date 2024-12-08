// lib/widgets/sales/sales_chart.dart
import 'package:flutter/cupertino.dart';

class SalesChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const SalesChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // Find the max value for scaling
    final maxSale =
        data.map((e) => e['sales'] as num).reduce((a, b) => a > b ? a : b);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 300,
          padding:
              const EdgeInsets.only(left: 40, right: 16, top: 16, bottom: 24),
          child: Column(
            children: [
              Expanded(
                child: CustomPaint(
                  size: Size(constraints.maxWidth, 240),
                  painter: ChartPainter(
                    data: data,
                    maxValue: maxSale.toDouble(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: data.map((point) {
                    return Text(
                      point['name'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey.darkColor,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double maxValue;

  ChartPainter({
    required this.data,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF05001E)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final points = _getPoints(size);
    final path = Path();

    // Draw grid lines
    _drawGrid(canvas, size);

    // Draw line chart
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    // Draw points
    paint.style = PaintingStyle.fill;
    for (final point in points) {
      canvas.drawCircle(point, 4, paint);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CupertinoColors.systemGrey.withOpacity(0.2)
      ..strokeWidth = 1;

    // Draw horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );

      // Draw value labels
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${((4 - i) * maxValue / 4).round()}',
          style: TextStyle(
            color: CupertinoColors.systemGrey.darkColor,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(-35, y - textPainter.height / 2),
      );
    }
  }

  List<Offset> _getPoints(Size size) {
    if (data.isEmpty) return [];

    final points = <Offset>[];
    final width = size.width;
    final height = size.height;

    for (int i = 0; i < data.length; i++) {
      final x = (width * i / (data.length - 1));
      final y = height - (height * (data[i]['sales'] as num) / maxValue);
      points.add(Offset(x, y));
    }

    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
