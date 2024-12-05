// lib/widgets/products/product_details_drawer.dart
import 'package:e_commerce_app/screen/product/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

class ProductDetailsDrawer extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;
  final String heroTag; // Add heroTag parameter

  const ProductDetailsDrawer({
    super.key,
    required this.product,
    required this.heroTag,
    this.onAddToCart,
    this.onBuyNow,
  });

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF05001E),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${product.stock}+ SOLD',
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF05001E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: onAddToCart,
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Color(0xFF05001E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: onBuyNow,
                color: const Color(0xFF05001E),
                borderRadius: BorderRadius.circular(12),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 16),
            onPressed: () {
              Navigator.pop(context); // Close drawer
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: product,
                    heroTag: 'product-${product.id}-${product.thumbnail}',
                  ),
                ),
              );
            },
            color: CupertinoColors.systemBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            child: const Text(
              'View Full Details',
              style: TextStyle(
                color: CupertinoColors.systemBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildInfoSection('Brand', product.brand),
                  _buildInfoSection('Category', product.category),
                  _buildInfoSection('Description', product.description),
                  _buildInfoSection('Stock', product.stock.toString()),
                  _buildInfoSection(
                    'Availability',
                    product.availabilityStatus,
                  ),
                  _buildInfoSection(
                    'Warranty',
                    product.warrantyInformation,
                  ),
                  _buildInfoSection(
                    'Return Policy',
                    product.returnPolicy,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
