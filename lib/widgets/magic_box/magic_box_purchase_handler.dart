import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:e_commerce_app/widgets/magic_box/reveal_box_modal.dart';

class MagicBoxPurchaseHandler {
  static Future<void> handlePurchase(
    BuildContext context, {
    required String boxTitle,
    required double boxPrice,
    required Color startColor,
    required Color endColor,
    required int itemCount,
  }) async {
    // Use BuildContext that's valid throughout the async process
    final scaffoldContext = context;

    // Show purchase confirmation dialog
    bool confirmed = await _showPurchaseConfirmation(
      scaffoldContext,
      boxTitle: boxTitle,
      boxPrice: boxPrice,
    );

    if (confirmed) {
      // Check if the context is still valid
      if (!scaffoldContext.mounted) return;

      // Fetch products and show loading indicator
      final loadingContext = await _showLoadingIndicator(scaffoldContext);

      try {
        final products = await _fetchRandomProducts(itemCount);

        // Check if the context is still valid
        if (!scaffoldContext.mounted) return;

        // Dismiss loading indicator
        Navigator.of(loadingContext).pop();

        // Show reveal modal with the products (after a short delay to ensure UI updates)
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scaffoldContext.mounted) {
            _showRevealModal(
              scaffoldContext,
              products: products,
              boxTitle: boxTitle,
              boxPrice: boxPrice,
              startColor: startColor,
              endColor: endColor,
            );
          }
        });
      } catch (e) {
        // Check if the context is still valid
        if (!scaffoldContext.mounted) return;

        // Dismiss loading indicator
        Navigator.of(loadingContext).pop();

        // Show error dialog
        _showErrorDialog(scaffoldContext, error: e.toString());
      }
    }
  }

  static Future<bool> _showPurchaseConfirmation(
    BuildContext context, {
    required String boxTitle,
    required double boxPrice,
  }) async {
    if (!context.mounted) return false;

    return await showCupertinoDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => CupertinoAlertDialog(
            title: const Text('Confirm Purchase'),
            content: Text(
              'Purchase this $boxTitle for \$${boxPrice.toStringAsFixed(2)}?',
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Buy Now'),
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Return the dialog context to be able to dismiss it later
  static Future<BuildContext> _showLoadingIndicator(
      BuildContext context) async {
    if (!context.mounted) {
      throw Exception('Context is no longer valid');
    }

    BuildContext dialogContext = context;

    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        dialogContext = ctx;
        return const CupertinoAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoActivityIndicator(radius: 16),
              SizedBox(height: 16),
              Text(
                'Preparing your Magic box...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );

    return dialogContext;
  }

  static Future<List<Product>> _fetchRandomProducts(int count) async {
    try {
      final products = await ProductService.fetchProducts();

      if (products.isEmpty) {
        return _createFallbackProducts(count);
      }

      final random = Random();
      final selectedProducts = <Product>[];

      // Create a copy of products to avoid modifying the original list
      final availableProducts = List<Product>.from(products);

      // Get unique random products up to count
      final itemCount = min(count, availableProducts.length);

      for (var i = 0; i < itemCount; i++) {
        final randomIndex = random.nextInt(availableProducts.length);
        selectedProducts.add(availableProducts[randomIndex]);
        availableProducts.removeAt(randomIndex); // Prevent duplicates
      }

      return selectedProducts;
    } catch (e) {
      debugPrint('Error fetching products for magic box: $e');
      return _createFallbackProducts(count);
    }
  }

  static List<Product> _createFallbackProducts(int count) {
    final now = DateTime.now();
    final random = Random();
    final randomProducts = <Product>[];

    for (var i = 0; i < count; i++) {
      randomProducts.add(Product(
        id: 999 + i,
        title: 'Magic Surprise ${i + 1}',
        description: 'A special surprise item just for you!',
        category: 'Special',
        price: 9.99 * (1.0 + (i * 0.2)), // Vary the price slightly
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

    return randomProducts;
  }

  static void _showRevealModal(
    BuildContext context, {
    required List<Product> products,
    required String boxTitle,
    required double boxPrice,
    required Color startColor,
    required Color endColor,
  }) {
    if (!context.mounted) return;

    // Use a regular CupertinoPageRoute to ensure proper context handling
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (pageContext) => RevealBoxModal(
          products: products,
          boxTitle: boxTitle,
          boxPrice: boxPrice,
          startColor: startColor,
          endColor: endColor,
        ),
      ),
    );
  }

  static void _showErrorDialog(
    BuildContext context, {
    required String error,
  }) {
    if (!context.mounted) return;

    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text('Failed to prepare your Magic box: $error'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
  }
}
