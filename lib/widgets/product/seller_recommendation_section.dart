import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

class SellerRecommendationSection extends StatelessWidget {
  final List<Product> recommendations;
  final Function(Product) onProductTap;
  final Function(Product) onFavoriteTap;
  final Color? bgColor;

  const SellerRecommendationSection({
    super.key,
    required this.recommendations,
    required this.onProductTap,
    required this.onFavoriteTap,
    this.bgColor = CupertinoColors.white,
  });

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => onProductTap(product),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.4,
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: CupertinoColors.systemGrey6,
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.photo,
                              size: 32,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onFavoriteTap(product),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: CupertinoColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 16,
                        color: Color(0xFF05001E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF05001E),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${product.stock}+',
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const Text(
                        ' SOLD',
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.cart,
                        size: 16,
                        color: Color(0xFF05001E),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF3B30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${(product.discountPercentage).round()}% off',
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.cube_box,
                              size: 12,
                              color: Color(0xFF05001E),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Free Shipping',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF05001E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${(product.rating * 20).round()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFFA41C),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Buyer Rated',
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.star_fill,
                        size: 12,
                        color: Color(0xFFFFA41C),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFFA41C),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Seller Recommendation',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: recommendations.length,
            itemBuilder: (context, index) =>
                _buildProductCard(recommendations[index]),
          ),
        ],
      ),
    );
  }
}
