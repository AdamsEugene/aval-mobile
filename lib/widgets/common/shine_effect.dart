import 'package:e_commerce_app/widgets/common/shine_painter.dart';
import 'package:flutter/cupertino.dart';

class ShineEffect extends StatefulWidget {
  final Color startColor;
  final Color endColor;

  const ShineEffect({
    super.key,
    required this.startColor,
    required this.endColor,
  });

  @override
  State<ShineEffect> createState() => _ShineEffectState();
}

class _ShineEffectState extends State<ShineEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(_controller);

    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ShinePainter(
            value: _animation.value,
            startColor: widget.startColor,
            endColor: widget.endColor,
          ),
        );
      },
    );
  }
}
