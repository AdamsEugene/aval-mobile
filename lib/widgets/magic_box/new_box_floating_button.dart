import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/magic_box/new_box_preview_modal.dart';

class NewBoxFloatingButton extends StatefulWidget {
  final String boxTitle;
  final double boxPrice;
  final Color startColor;
  final Color endColor;
  final int itemCount;

  const NewBoxFloatingButton({
    super.key,
    required this.boxTitle,
    required this.boxPrice,
    required this.startColor,
    required this.endColor,
    this.itemCount = 1,
  });

  @override
  State<NewBoxFloatingButton> createState() => _NewBoxFloatingButtonState();
}

class _NewBoxFloatingButtonState extends State<NewBoxFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showBoxPreview() {
    // Use a CupertinoModalPopup instead of showModalBottomSheet to avoid Material dependency
    showCupertinoModalPopup(
      context: context,
      builder: (context) => NewBoxPreviewModal(
        boxTitle: widget.boxTitle,
        boxPrice: widget.boxPrice,
        startColor: widget.startColor,
        endColor: widget.endColor,
        itemCount: widget.itemCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _showBoxPreview,
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [widget.startColor, widget.endColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: widget.startColor.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            CupertinoIcons.gift_fill,
                            color: Colors.white,
                            size: 32,
                          ),
                          if (widget.itemCount > 1)
                            Positioned(
                              right: -4,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${widget.itemCount}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      // const SizedBox(width: 8),
                      // const Text(
                      //   'NEW BOX!',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 14,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // const SizedBox(width: 4),
                      // _buildSparkle(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSparkle() {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _SparklePainter(
          animation: _animationController,
          color: Colors.amber,
        ),
      ),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _SparklePainter({required this.animation, required this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;

    // Draw a star shape
    final path = Path();
    const points = 5;
    final innerRadius = maxRadius * 0.4;

    for (int i = 0; i < points * 2; i++) {
      final pointRadius = i.isEven ? maxRadius : innerRadius;
      final angle = (i * math.pi) / points;
      final x = center.dx + pointRadius * math.cos(angle);
      final y = center.dy + pointRadius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Add pulsing effect
    final pulseFactor = 0.5 + 0.5 * animation.value;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(pulseFactor, pulseFactor);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SparklePainter oldDelegate) => true;
}
