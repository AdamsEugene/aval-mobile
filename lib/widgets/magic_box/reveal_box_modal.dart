import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/product.dart';

class RevealBoxModal extends StatefulWidget {
  final List<Product> products;
  final String boxTitle;
  final double boxPrice;
  final Color startColor;
  final Color endColor;

  const RevealBoxModal({
    super.key,
    required this.products,
    required this.boxTitle,
    required this.boxPrice,
    required this.startColor,
    required this.endColor,
  });

  @override
  State<RevealBoxModal> createState() => _RevealBoxModalState();
}

class _RevealBoxModalState extends State<RevealBoxModal>
    with TickerProviderStateMixin {
  late AnimationController _boxController;
  late AnimationController _contentController;
  late Animation<double> _boxScaleAnimation;
  late Animation<double> _boxRotationAnimation;
  late Animation<double> _contentOpacityAnimation;
  bool _isBoxOpened = false;
  int _currentProductIndex = 0;
  late PageController _pageController;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // Box animation controller
    _boxController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Content animation controller (delayed start)
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Box animations
    _boxScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 0.8),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 0.0),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _boxController,
        curve: Curves.easeInOut,
      ),
    );

    _boxRotationAnimation = Tween<double>(
      begin: 0.0,
      end: pi * 2,
    ).animate(
      CurvedAnimation(
        parent: _boxController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Content animation
    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeIn,
      ),
    );

    // Start box animation after a short delay to ensure everything is properly initialized
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _boxController.forward();
      }
    });

    // Listen for box animation completion
    _boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() {
          _isBoxOpened = true;
          _showConfetti = true;
        });
        // Start content animation
        _contentController.forward();

        // Hide confetti after a few seconds
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            setState(() {
              _showConfetti = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _boxController.dispose();
    _contentController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextProduct() {
    if (_currentProductIndex < widget.products.length - 1) {
      setState(() {
        _currentProductIndex++;
      });
      _pageController.animateToPage(
        _currentProductIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousProduct() {
    if (_currentProductIndex > 0) {
      setState(() {
        _currentProductIndex--;
      });
      _pageController.animateToPage(
        _currentProductIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Content (shows after box opens)
                if (_isBoxOpened)
                  FadeTransition(
                    opacity: _contentOpacityAnimation,
                    child: _buildRevealedContent(),
                  ),

                // Box animation (disappears after opening)
                if (!_isBoxOpened)
                  Center(
                    child: AnimatedBuilder(
                      animation: _boxController,
                      builder: (context, child) {
                        // Make sure the animation value is within bounds
                        final scale = _boxScaleAnimation.value.clamp(0.0, 3.0);
                        final rotation =
                            _boxRotationAnimation.value.clamp(0.0, pi * 4);

                        return Transform.scale(
                          scale: scale,
                          child: Transform.rotate(
                            angle: rotation,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    widget.startColor,
                                    widget.endColor,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.startColor.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      CupertinoIcons.gift_fill,
                                      size: 70,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  if (widget.products.length > 1)
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${widget.products.length}',
                                            style: TextStyle(
                                              color: widget.startColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                // Close button
                if (_isBoxOpened)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.xmark_circle_fill),
                      color: Colors.grey[400],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Confetti animation
          if (_showConfetti) _buildConfetti(),
        ],
      ),
    );
  }

  Widget _buildRevealedContent() {
    if (widget.products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'Surprise items not available',
            style: TextStyle(
              fontSize: 18,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with sparkles animation
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: _buildSparklesAnimation(),
        ),
        const SizedBox(height: 12),

        // Congratulations text
        Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: widget.startColor,
            shadows: [
              Shadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Multiple items indicator
        if (widget.products.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You got ${widget.products.length} items:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Item ${_currentProductIndex + 1}/${widget.products.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Text(
            'You got:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        const SizedBox(height: 8),

        // Product content with PageView for multiple items
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.products.length,
            onPageChanged: (index) {
              setState(() {
                _currentProductIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product name with special styling
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Product image if available
                    if (product.thumbnail.isNotEmpty &&
                        !product.thumbnail.startsWith('assets'))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.thumbnail,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Icon(
                                CupertinoIcons.photo,
                                size: 50,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Product details in a nice card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(
                            'Value',
                            '\$${product.price.toStringAsFixed(2)}',
                            valueColor: Colors.green[700]!,
                          ),
                          const SizedBox(height: 8),
                          if (product.discountPercentage > 0) ...[
                            _buildDetailRow(
                              'Discount',
                              '${product.discountPercentage.toStringAsFixed(1)}%',
                              valueColor: Colors.orange[700]!,
                            ),
                            const SizedBox(height: 8),
                          ],
                          _buildDetailRow('Brand', product.brand),
                          const SizedBox(height: 8),
                          _buildDetailRow('Category', product.category),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                            'Rating',
                            '${product.rating.toStringAsFixed(1)} ★',
                            valueColor: Colors.amber[700]!,
                          ),
                          const SizedBox(height: 8),
                          _buildDetailRow('In Stock', '${product.stock}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Savings calculation
                    if (product.price >
                        (widget.boxPrice / widget.products.length)) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green[200]!,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'You saved ${((product.price - (widget.boxPrice / widget.products.length)) / product.price * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${(product.price - (widget.boxPrice / widget.products.length)).toStringAsFixed(2)} off regular price',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // View details button
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      color: widget.startColor,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // Navigate to product details page
                        Navigator.of(context).pop();
                        // Implement navigation to product details
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Navigation arrows for multiple items
        if (widget.products.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.chevron_left_circle_fill),
                  color: _currentProductIndex > 0
                      ? widget.endColor
                      : Colors.grey[300],
                  iconSize: 32,
                  onPressed:
                      _currentProductIndex > 0 ? _goToPreviousProduct : null,
                ),
                // Page indicator dots
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.products.length,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentProductIndex
                            ? widget.endColor
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.chevron_right_circle_fill),
                  color: _currentProductIndex < widget.products.length - 1
                      ? widget.endColor
                      : Colors.grey[300],
                  iconSize: 32,
                  onPressed: _currentProductIndex < widget.products.length - 1
                      ? _goToNextProduct
                      : null,
                ),
              ],
            ),
          ),

        // Bottom action area
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 24.0,
            top: 8.0,
          ),
          child: Column(
            children: [
              // Total value calculation for multiple items
              if (widget.products.length > 1) ...[
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber[200]!),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Total Box Value: \${widget.products.fold<double>(0, (sum, product) => sum + product.price).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'You paid: \${widget.boxPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.amber[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Get another box button
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'Get Another Box',
                  style: TextStyle(
                    color: widget.endColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value,
      {Color valueColor = Colors.black87}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSparklesAnimation() {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        children: [
          // Central gift icon
          Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: widget.endColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.gift_fill,
                size: 36,
                color: widget.endColor,
              ),
            ),
          ),

          // Sparkles positioned around
          for (int i = 0; i < 8; i++)
            Positioned(
              top: 20 + 30 * sin(i * pi / 4),
              left: 20 + 30 * cos(i * pi / 4),
              child: _buildSparkle(duration: 1500 + i * 100),
            ),
        ],
      ),
    );
  }

  Widget _buildSparkle({required int duration}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: duration),
      builder: (context, value, child) {
        return Opacity(
          opacity: sin(value * pi) * 0.7 + 0.3, // Pulse effect
          child: Transform.scale(
            scale: 0.5 + sin(value * pi * 2) * 0.5,
            child: const Icon(
              Icons.star,
              color: Colors.amber,
              size: 14,
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfetti() {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: ConfettiPainter(
            colors: [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
              Colors.pink,
            ],
          ),
        ),
      ),
    );
  }
}

// Confetti animation painter
class ConfettiPainter extends CustomPainter {
  final List<Color> colors;
  final List<_ConfettiParticle> particles;

  ConfettiPainter({
    required this.colors,
  }) : particles = List<_ConfettiParticle>.generate(
          100,
          (_) => _ConfettiParticle(
            position: Offset(
              Random().nextDouble() * 400,
              Random().nextDouble() * -400,
            ),
            color: colors[Random().nextInt(colors.length)],
            size: 5 + Random().nextDouble() * 8,
            speed: 2 + Random().nextDouble() * 4,
            angle: Random().nextDouble() * pi / 4 - pi / 8,
            rotation: Random().nextDouble() * pi * 2,
            rotationSpeed: Random().nextDouble() * 0.2 - 0.1,
          ),
        );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final particle in particles) {
      paint.color = particle.color;

      canvas.save();
      canvas.translate(particle.position.dx, particle.position.dy);
      canvas.rotate(particle.rotation);

      // Draw rectangular confetti pieces
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: particle.size,
          height: particle.size * 0.5,
        ),
        paint,
      );

      canvas.restore();

      // Update particle position for next frame
      particle.position = Offset(
        particle.position.dx + cos(particle.angle) * particle.speed,
        particle.position.dy +
            sin(particle.angle) * particle.speed +
            particle.speed,
      );
      particle.rotation += particle.rotationSpeed;

      // Reset particles that move out of view
      if (particle.position.dy > size.height) {
        particle.position = Offset(
          Random().nextDouble() * size.width,
          Random().nextDouble() * -100,
        );
        particle.speed = 2 + Random().nextDouble() * 4;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Helper class for confetti animation
class _ConfettiParticle {
  Offset position;
  final Color color;
  final double size;
  double speed;
  final double angle;
  double rotation;
  final double rotationSpeed;

  _ConfettiParticle({
    required this.position,
    required this.color,
    required this.size,
    required this.speed,
    required this.angle,
    required this.rotation,
    required this.rotationSpeed,
  });
}
