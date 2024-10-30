import 'package:flutter/cupertino.dart';
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
      color: CupertinoColors.white,
      boxShadow: const <BoxShadow>[],
      borderRadius: BorderRadius.circular(12),
    ),
    end: BoxDecoration(
      color: CupertinoColors.white,
      boxShadow: CupertinoContextMenu.kEndBoxShadow,
      borderRadius: BorderRadius.circular(12),
    ),
  );

  Animation<Decoration> _boxDecorationAnimation(Animation<double> animation) {
    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.0,
          CupertinoContextMenu.animationOpensAt,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0, // Removed vertical spacing
          crossAxisSpacing: 2,
          childAspectRatio: 160 / 200, // Reduced height to bring items closer
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ProductItemWrapper(
              product: widget.products[index],
              boxDecorationAnimation: _boxDecorationAnimation,
            );
          },
          childCount: widget.products.length,
        ),
      ),
    );
  }
}
