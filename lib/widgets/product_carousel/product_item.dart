// lib/widgets/product/product_item.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
import 'package:e_commerce_app/models/product.dart';

class ProductActions extends StatelessWidget {
  const ProductActions({super.key});

  void _handleMenuAction(BuildContext context, VoidCallback action) {
    action();
    Navigator.of(context, rootNavigator: true).pop();
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = [
      {'icon': Icons.favorite_border, 'label': 'Like'},
      {'icon': Icons.share, 'label': 'Share'},
      {
        'icon': Icons.add_shopping_cart,
        'label': 'Add to Cart',
        'default': true
      },
      {'icon': Icons.shopping_bag_outlined, 'label': 'Buy Now'},
      {'icon': Icons.more_horiz, 'label': 'More'},
    ];

    if (Platform.isIOS) {
      return actions.map((action) {
        return CupertinoContextMenuAction(
          isDefaultAction: action['default'] == true,
          trailingIcon: _getIcon(action['icon'] as IconData, true),
          onPressed: () => _handleMenuAction(context, () {
            // Add action logic here
          }),
          child: Text(action['label'] as String),
        );
      }).toList();
    } else {
      return actions.map((action) {
        return ListTile(
          leading: Icon(action['icon'] as IconData),
          title: Text(action['label'] as String),
          onTap: () => _handleMenuAction(context, () {
            // Add action logic here
          }),
        );
      }).toList();
    }
  }

  IconData _getIcon(IconData materialIcon, bool isIOS) {
    if (!isIOS) return materialIcon;

    // Map Material icons to Cupertino icons
    final iconMap = {
      Icons.favorite_border: CupertinoIcons.heart,
      Icons.share: CupertinoIcons.share,
      Icons.add_shopping_cart: CupertinoIcons.cart_badge_plus,
      Icons.shopping_bag_outlined: CupertinoIcons.bag,
      Icons.more_horiz: CupertinoIcons.ellipsis,
    };

    return iconMap[materialIcon] ?? materialIcon;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoContextMenu(
        actions: _buildActions(context)
            .whereType<CupertinoContextMenuAction>()
            .toList(),
        child: Container(),
      );
    } else {
      return PopupMenuButton<void>(
        itemBuilder: (context) => _buildActions(context)
            .whereType<ListTile>()
            .map((tile) => PopupMenuItem<void>(child: tile))
            .toList(),
        child: Container(),
      );
    }
  }
}

class ProductItemWrapper extends StatelessWidget {
  final Product? product;
  final Animation<Decoration> Function(Animation<double>)
      boxDecorationAnimation;

  const ProductItemWrapper({
    super.key,
    this.product,
    required this.boxDecorationAnimation,
  });

  void _showProductActions(BuildContext context) {
    if (!Platform.isIOS) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: const ProductActions()._buildActions(context),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = Platform.isIOS
        ? CupertinoContextMenu.builder(
            actions: const ProductActions()
                ._buildActions(context)
                .whereType<CupertinoContextMenuAction>()
                .toList(),
            builder: (context, animation) {
              final decorationAnimation = boxDecorationAnimation(animation);
              return Container(
                decoration:
                    animation.value < CupertinoContextMenu.animationOpensAt
                        ? decorationAnimation.value
                        : null,
                child: _buildProductItem(context, product, animation),
              );
            },
          )
        : GestureDetector(
            onLongPress: () => _showProductActions(context),
            child: _buildProductItem(context, product, null),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(width: 160, child: child),
    );
  }
}

Widget _buildProductItem(
    BuildContext context, Product? product, Animation<double>? animation) {
  final bool isExpanded = animation != null &&
      animation.value >= CupertinoContextMenu.animationOpensAt;

  final boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    offset: const Offset(0, 4),
    blurRadius: 4,
    spreadRadius: 0,
  );

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    width: isExpanded ? MediaQuery.of(context).size.width : 160,
    height: isExpanded ? 440 : 220,
    decoration: BoxDecoration(
      color: Colors.white,
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ShimmerLoading(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                      bottom: Radius.circular(8),
                    ),
                  ),
                  if (product?.imageUrl != null)
                    Image.network(
                      product!.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Platform.isIOS
                                  ? CupertinoIcons.photo
                                  : Icons.image_not_supported_outlined,
                              size: 32,
                              color: Colors.grey,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product?.name ?? 'No product name',
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
