import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

class RelatedItemsSection extends StatelessWidget {
  final List<Product> relatedProducts;
  final Function(Product) onProductTap;

  const RelatedItemsSection({
    super.key,
    required this.relatedProducts,
    required this.onProductTap,
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 1.2,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF05001E),
                      ),
                    ),
                    // const Spacer(),
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
                          '${product.stock}+ SOLD',
                          style: const TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
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
              'Related items',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const crossAxisCount = 2;
                const spacing = 16.0;
                const childAspectRatio = 0.8;

                final width = (constraints.maxWidth - spacing) / crossAxisCount;
                final height = width / childAspectRatio;

                final rowCount =
                    (relatedProducts.length + crossAxisCount - 1) ~/
                        crossAxisCount;
                final gridHeight = rowCount * (height + spacing) - spacing;

                return SizedBox(
                  height: gridHeight,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: relatedProducts.length,
                    itemBuilder: (context, index) =>
                        _buildProductCard(relatedProducts[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
