import 'dart:math';
import 'package:e_commerce_app/widgets/common/magic_pattern_painter.dart';
import 'package:e_commerce_app/widgets/common/shine_effect.dart';
import 'package:e_commerce_app/widgets/magic_box/reveal_box_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/product_service.dart';

class MagicBox extends StatefulWidget {
  final String title;
  final double price;
  final Color startColor;
  final Color endColor;
  final VoidCallback? onPurchased;
  final int itemCount; // Number of items in the magic box

  const MagicBox({
    super.key,
    this.title = 'Magic Box',
    this.price = 9.99,
    this.startColor = const Color(0xFFDA4453),
    this.endColor = const Color(0xFF89216B),
    this.onPurchased,
    this.itemCount = 1, // Default to 1 item
  });

  @override
  State<MagicBox> createState() => _MagicBoxState();
}

class _MagicBoxState extends State<MagicBox>
    with SingleTickerProviderStateMixin {
  List<Product> _hiddenProducts = [];
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _fetchRandomProducts();

    // Initialize pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _fetchRandomProducts() async {
    try {
      final products = await ProductService.fetchProducts();
      if (products.isNotEmpty) {
        final random = Random();
        final selectedProducts = <Product>[];

        // Get unique random products up to itemCount
        final availableProducts = List<Product>.from(products);
        final itemCount = min(widget.itemCount, availableProducts.length);

        for (var i = 0; i < itemCount; i++) {
          final randomIndex = random.nextInt(availableProducts.length);
          selectedProducts.add(availableProducts[randomIndex]);
          availableProducts.removeAt(randomIndex); // Prevent duplicates
        }

        setState(() {
          _hiddenProducts = selectedProducts;
        });
      } else {
        // Create fallback products if no products are available
        _createFallbackProducts();
      }
    } catch (e) {
      debugPrint('Error fetching products for magic box: $e');
      // Create fallback products on error
      _createFallbackProducts();
    }
  }

  void _createFallbackProducts() {
    final now = DateTime.now();
    final randomProducts = <Product>[];

    for (var i = 0; i < widget.itemCount; i++) {
      randomProducts.add(Product(
        id: 999 + i,
        title: 'Magic Surprise ${i + 1}',
        description: 'A special surprise item just for you!',
        category: 'Special',
        price: widget.price * (1.0 + (i * 0.2)), // Vary the price slightly
        discountPercentage: 0,
        rating:
            4.5 + (random.nextDouble() * 0.5), // Random rating between 4.5-5.0
        stock: 1,
        tags: ['Magic', 'Special', 'Surprise'],
        brand: 'Special Edition',
        sku: 'Magic-${now.millisecondsSinceEpoch}-$i',
        weight: 0.5,
        dimensions: Dimensions(width: 10, height: 10, depth: 10),
        warrantyInformation: 'Standard warranty applies',
        shippingInformation: 'Standard shipping',
        availabilityStatus: 'In Stock',
        reviews: [],
        returnPolicy: 'No returns on Magic items',
        minimumOrderQuantity: 1,
        meta: Meta(
          createdAt: now,
          updatedAt: now,
          barcode: '00000000',
          qrCode: '00000000',
        ),
        images: ['assets/images/Magic_box.png'],
        thumbnail: 'assets/images/Magic_box_thumb.png',
      ));
    }

    setState(() {
      _hiddenProducts = randomProducts;
    });
  }

  void _handlePurchase() {
    final totalValue =
        _hiddenProducts.fold<double>(0, (sum, product) => sum + product.price);

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text(
            'Purchase this ${widget.title} with ${widget.itemCount} items for \$${widget.price.toStringAsFixed(2)}?\n\nTotal value potential: up to \$${totalValue.toStringAsFixed(2)}'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: false,
            isDefaultAction: true,
            child: const Text('Buy Now'),
            onPressed: () {
              Navigator.pop(context);
              _showRevealModal();
              if (widget.onPurchased != null) {
                widget.onPurchased!();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showRevealModal() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return Center(
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: RevealBoxModal(
                products: _hiddenProducts,
                boxTitle: widget.title,
                boxPrice: widget.price,
                startColor: widget.startColor,
                endColor: widget.endColor,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePurchase,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: 180,
              height: 220,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.startColor.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.startColor,
                    widget.endColor,
                  ],
                ),
              ),
              child: _buildMagicContent(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMagicContent() {
    return Stack(
      children: [
        // Magic pattern
        Positioned.fill(
          child: CustomPaint(
            painter: MagicPatternPainter(),
          ),
        ),

        // Shine effect
        Positioned.fill(
          child: ShineEffect(
            startColor: widget.startColor,
            endColor: widget.endColor,
          ),
        ),

        // Main content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Box Icon with 3D effect
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.gift_fill,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  // Item count badge
                  if (widget.itemCount > 1)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${widget.itemCount}',
                            style: TextStyle(
                              color: widget.startColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),

              // Price
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '\$${widget.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.startColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Special tag for multiple items
              if (widget.itemCount > 1)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.itemCount} items inside!',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

              const SizedBox(height: 4),
              // Tap instruction
              Text(
                'Tap to purchase',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Random number generator for creating fallback products
final random = Random();
