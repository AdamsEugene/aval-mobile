import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/product.dart';

class RevealBoxModal extends StatefulWidget {
  final Product? product;
  final String boxTitle;
  final double boxPrice;
  final Color startColor;
  final Color endColor;

  const RevealBoxModal({
    super.key,
    required this.product,
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

  @override
  void initState() {
    super.initState();

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

    // Use simpler animations to avoid the assertion error
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
        });
        // Start content animation
        _contentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _boxController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                          child: Center(
                            child: Icon(
                              CupertinoIcons.gift_fill,
                              size: 70,
                              color: Colors.white.withOpacity(0.9),
                            ),
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
    );
  }

  // Rest of the methods remain the same...
  Widget _buildRevealedContent() {
    if (widget.product == null) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'Surprise item not available',
            style: TextStyle(
              fontSize: 18,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with sparkles animation
            _buildSparklesAnimation(),
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

            Text(
              'You got:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // Product name with special styling
            Text(
              widget.product!.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // Product image if available
            if (widget.product!.thumbnail.isNotEmpty &&
                !widget.product!.thumbnail.startsWith('assets'))
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.product!.thumbnail,
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
                    '\$${widget.product!.price.toStringAsFixed(2)}',
                    valueColor: Colors.green[700]!,
                  ),
                  const SizedBox(height: 8),
                  if (widget.product!.discountPercentage > 0) ...[
                    _buildDetailRow(
                      'Discount',
                      '${widget.product!.discountPercentage.toStringAsFixed(1)}%',
                      valueColor: Colors.orange[700]!,
                    ),
                    const SizedBox(height: 8),
                  ],
                  _buildDetailRow('Brand', widget.product!.brand),
                  const SizedBox(height: 8),
                  _buildDetailRow('Category', widget.product!.category),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    'Rating',
                    '${widget.product!.rating.toStringAsFixed(1)} ★',
                    valueColor: Colors.amber[700]!,
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow('In Stock', '${widget.product!.stock}'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Savings calculation
            if (widget.product!.price > widget.boxPrice) ...[
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
                      'You saved ${((widget.product!.price - widget.boxPrice) / widget.product!.price * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${(widget.product!.price - widget.boxPrice).toStringAsFixed(2)} off regular price',
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

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
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
                ),
              ],
            ),
            const SizedBox(height: 8),

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
}
