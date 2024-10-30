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
  final Animation<Decoration> Function(Animation<double>)
      boxDecorationAnimation;

  const ProductItemWrapper({
    super.key,
    required this.product,
    required this.boxDecorationAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        width: 160,
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
              child: _buildProductItem(context, product, animation),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildProductItem(
    BuildContext context, Product product, Animation<double> animation) {
  final bool isExpanded =
      animation.value >= CupertinoContextMenu.animationOpensAt;

  final boxShadow = BoxShadow(
    color: CupertinoColors.systemGrey.withOpacity(0.5),
    offset: const Offset(0, 4),
    blurRadius: 4,
    spreadRadius: 0,
  );

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    width: isExpanded ? MediaQuery.of(context).size.width : 160,
    height: isExpanded ? 300 : 220,
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [boxShadow],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [boxShadow],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(8),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(8),
              ),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.name,
            style: TextStyle(
              fontSize: isExpanded ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
