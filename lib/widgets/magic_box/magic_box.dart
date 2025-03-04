import 'dart:math';
import 'package:e_commerce_app/widgets/common/mystery_pattern_painter.dart';
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

  const MagicBox({
    super.key,
    this.title = 'Mystery Box',
    this.price = 9.99,
    this.startColor = const Color(0xFFDA4453),
    this.endColor = const Color(0xFF89216B),
    this.onPurchased,
  });

  @override
  State<MagicBox> createState() => _MagicBoxState();
}

class _MagicBoxState extends State<MagicBox> {
  Product? _hiddenProduct;

  @override
  void initState() {
    super.initState();
    _fetchRandomProduct();
  }

  Future<void> _fetchRandomProduct() async {
    try {
      final products = await ProductService.fetchProducts();
      if (products.isNotEmpty) {
        final random = Random();
        setState(() {
          _hiddenProduct = products[random.nextInt(products.length)];
        });
      } else {
        // Create a fallback product if no products are available
        _createFallbackProduct();
      }
    } catch (e) {
      debugPrint('Error fetching product for magic box: $e');
      // Create a fallback product on error
      _createFallbackProduct();
    }
  }

  void _createFallbackProduct() {
    final now = DateTime.now();
    setState(() {
      _hiddenProduct = Product(
        id: 999,
        title: 'Mystery Surprise',
        description: 'A special surprise item just for you!',
        category: 'Special',
        price: widget.price * 1.5,
        discountPercentage: 0,
        rating: 5.0,
        stock: 1,
        tags: ['Mystery', 'Special', 'Surprise'],
        brand: 'Special Edition',
        sku: 'MYSTERY-${now.millisecondsSinceEpoch}',
        weight: 0.5,
        dimensions: Dimensions(width: 10, height: 10, depth: 10),
        warrantyInformation: 'Standard warranty applies',
        shippingInformation: 'Standard shipping',
        availabilityStatus: 'In Stock',
        reviews: [],
        returnPolicy: 'No returns on mystery items',
        minimumOrderQuantity: 1,
        meta: Meta(
          createdAt: now,
          updatedAt: now,
          barcode: '00000000',
          qrCode: '00000000',
        ),
        images: ['assets/images/mystery_box.png'],
        thumbnail: 'assets/images/mystery_box_thumb.png',
      );
    });
  }

  void _handlePurchase() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text(
            'Purchase this ${widget.title} for \$${widget.price.toStringAsFixed(2)}?'),
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
                product: _hiddenProduct,
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
      child: Container(
        width: 180,
        height: 220,
        margin: const EdgeInsets.all(8),
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
        child: _buildMysteryContent(),
      ),
    );
  }

  Widget _buildMysteryContent() {
    return Stack(
      children: [
        // Mystery pattern
        Positioned.fill(
          child: CustomPaint(
            painter: MysteryPatternPainter(),
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
              const SizedBox(height: 12),

              // Title
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
