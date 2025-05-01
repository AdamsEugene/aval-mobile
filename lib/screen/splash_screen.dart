import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    
    _colorAnimation = ColorTween(
      begin: const Color(0xFFFFA500),  // Orange
      end: const Color(0xFF4A90E2),   // Blue
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF050311),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: (_colorAnimation.value ?? const Color(0xFFFFA500)).withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.shopping_cart,
                          color: CupertinoColors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Text(
                      'Aval',
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: CupertinoColors.white,
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Text(
                      'Shop Smarter, Live Better',
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: CupertinoColors.systemGrey,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Opacity(
                  opacity: _opacityAnimation.value,
                  child: _buildLoadingIndicator(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        const CupertinoActivityIndicator(
          radius: 15,
          color: CupertinoColors.white,
        ),
        const SizedBox(height: 10),
        Text(
          'Loading Experience...',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
        ),
      ],
    );
  }
}
