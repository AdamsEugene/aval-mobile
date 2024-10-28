import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

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
          actions: _buildContextMenuActions(context),
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

  List<CupertinoContextMenuAction> _buildContextMenuActions(
      BuildContext context) {
    return [
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.heart,
        onPressed: () => Navigator.pop(context),
        child: const Text('Like'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.share,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Share'),
      ),
      CupertinoContextMenuAction(
        isDefaultAction: true,
        trailingIcon: CupertinoIcons.cart_badge_plus,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Add to Cart'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.bag,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Buy Now'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.ellipsis,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('More'),
      ),
    ];
  }
}

Widget _buildProductItem(
    BuildContext context, Product product, Animation<double> animation) {
  final bool isExpanded =
      animation.value >= CupertinoContextMenu.animationOpensAt;
  return Container(
    width: isExpanded ? MediaQuery.of(context).size.width : 160,
    height: isExpanded ? 300 : 220,
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
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
