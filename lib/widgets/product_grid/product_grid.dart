// lib/widgets/product/product_grid.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/product_carousel/product_item.dart';
import 'package:e_commerce_app/models/product.dart';

class ProductGrid extends StatefulWidget {
  final List<Product> products;
  final bool? isPromo;
  final bool? ourChoice;
  final List<String>? categories;

  const ProductGrid({
    super.key,
    required this.products,
    this.isPromo,
    this.ourChoice,
    this.categories,
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final DecorationTween _tween = DecorationTween(
    begin: BoxDecoration(
      color: Colors.white,
      boxShadow: const <BoxShadow>[],
      borderRadius: BorderRadius.circular(12),
    ),
    end: BoxDecoration(
      color: Colors.white,
      boxShadow: Platform.isIOS
          ? CupertinoContextMenu.kEndBoxShadow
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
      borderRadius: BorderRadius.circular(12),
    ),
  );

  Animation<Decoration> _boxDecorationAnimation(Animation<double>? animation) {
    if (animation == null) {
      return _tween.animate(
        CurvedAnimation(
          parent: const AlwaysStoppedAnimation<double>(1.0),
          curve: const Interval(
            0.0,
            0.5, // Use custom interval for Android
            curve: Curves.easeInOut,
          ),
        ),
      );
    }

    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(
          0.0,
          0.5, // Use custom interval for Android
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Platform.isIOS ? 0 : 8, // Add spacing for Android
        crossAxisSpacing: Platform.isIOS ? 0 : 8, // Add spacing for Android
        childAspectRatio: 160 / 260,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index >= products.length) {
            return null; // Return null if the index is out of bounds
          }

          if (products.isEmpty) {
            return const SizedBox
                .shrink(); // Return an empty widget if the list is empty
          }

          print(products);

          final product = products[index];

          return Platform.isIOS
              ? ProductItemWrapper(
                  product: product,
                  boxDecorationAnimation: _boxDecorationAnimation,
                )
              : Padding(
                  // Add padding for Android to create card-like effect
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ProductItemWrapper(
                    product: product,
                    boxDecorationAnimation: _boxDecorationAnimation,
                  ),
                );
        },
        childCount: products.length,
      ),
    );
  }
}
