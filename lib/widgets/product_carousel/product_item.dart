import 'package:e_commerce_app/screen/deals/super_deals_page.dart';
import 'package:e_commerce_app/screen/product/product_details_screen.dart';
import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

// Extracted Context Menu Widget
class ProductContextMenu extends StatelessWidget {
  const ProductContextMenu({
    super.key,
  });

  List<CupertinoContextMenuAction> _buildContextMenuActions(
      BuildContext context) {
    void handleMenuAction(VoidCallback action) {
      action();
      Navigator.of(context, rootNavigator: true).pop();
    }

    return [
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.heart,
        onPressed: () => handleMenuAction(() {
          // Add your like logic here
        }),
        child: const Text('Like'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.share,
        onPressed: () => handleMenuAction(() {
          // Add your share logic here
        }),
        child: const Text('Share'),
      ),
      CupertinoContextMenuAction(
        isDefaultAction: true,
        trailingIcon: CupertinoIcons.cart_badge_plus,
        onPressed: () => handleMenuAction(() {
          // Add your add to cart logic here
        }),
        child: const Text('Add to Cart'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.bag,
        onPressed: () => handleMenuAction(() {
          // Add your buy now logic here
        }),
        child: const Text('Buy Now'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.ellipsis,
        onPressed: () => handleMenuAction(() {
          // Add your more options logic here
        }),
        child: const Text('More'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: _buildContextMenuActions(context),
      child: Container(), // This will be replaced by previewBuilder
    );
  }
}

class ProductItemWrapper extends StatelessWidget {
  final Product product;
  final num index;
  final String? category;
  final bool? promo;
  final bool forGrid;
  final Animation<Decoration> Function(Animation<double>)
      boxDecorationAnimation;

  const ProductItemWrapper({
    super.key,
    required this.product,
    required this.boxDecorationAnimation,
    required this.index,
    this.category,
    this.promo,
    this.forGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        width: forGrid ? null : 160,
        child: CupertinoContextMenu.builder(
          actions: const ProductContextMenu()._buildContextMenuActions(context),
          builder: (BuildContext context, Animation<double> animation) {
            final Animation<Decoration> decorationAnimation =
                boxDecorationAnimation(animation);
            return Container(
              decoration:
                  animation.value < CupertinoContextMenu.animationOpensAt
                      ? decorationAnimation.value
                      : null,
              child: _buildProductItem(
                context,
                product,
                animation,
                index,
                category,
                promo,
                forGrid: forGrid,
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildProductItem(BuildContext context, Product product,
    Animation<double> animation, num index, String? category, bool? promo,
    {bool forGrid = false}) {
  final bool isExpanded =
      animation.value >= CupertinoContextMenu.animationOpensAt;

  final boxShadow = BoxShadow(
    color: CupertinoColors.systemGrey.withOpacity(0.5),
    offset: const Offset(0, 4),
    blurRadius: 4,
    spreadRadius: 0,
  );

  final heroTag = 'product-${product.id}-${product.thumbnail}-$index-$category';
  Widget screenToShow = promo == true
      ? const SuperDealsScreen()
      : ProductDetailsScreen(
          product: product,
          heroTag: heroTag,
        );

  Widget buildProductDetails() {
    if (!forGrid) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          product.title,
          style: TextStyle(
            fontSize: isExpanded ? 16 : 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: TextStyle(
              fontSize: isExpanded ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            product.brand,
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF05001E).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.activeOrange,
                ),
              ),
              if (product.discountPercentage > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '-${product.discountPercentage.round()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.activeOrange,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                CupertinoIcons.star_fill,
                color: CupertinoColors.systemYellow,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                product.rating.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              if (product.stock > 0)
                Text(
                  '${product.stock} in stock',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF05001E).withOpacity(0.6),
                  ),
                )
              else
                const Text(
                  'Out of stock',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      Navigator.of(context, rootNavigator: !(promo ?? false))
          .push(CupertinoPageRoute(builder: (context) => screenToShow));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      width: isExpanded
          ? MediaQuery.of(context).size.width
          : (forGrid ? null : 160),
      height: isExpanded ? 440 : (forGrid ? 300 : 220),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [boxShadow],
      ),
      child: Stack(
        // Changed from Column to Stack
        children: [
          // Image takes full space
          Container(
            decoration: BoxDecoration(
              boxShadow: [boxShadow],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: heroTag,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const ShimmerLoading(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    Image.network(
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
                  ],
                ),
              ),
            ),
          ),
          // Product details overlay at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CupertinoColors.white.withOpacity(0.7),
                    CupertinoColors.white,
                  ],
                ),
              ),
              child: buildProductDetails(),
            ),
          ),
        ],
      ),
    ),
  );
}
