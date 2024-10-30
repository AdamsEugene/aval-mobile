import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/product_carousel/category_bar.dart';
import 'package:e_commerce_app/widgets/product_carousel/product_item.dart';
import 'package:e_commerce_app/data/product_data.dart';

class ProductCarousel extends StatefulWidget {
  final bool? isPromo;
  final bool? ourChoice;
  final List<String>? categories;
  final bool? isProductTile;

  const ProductCarousel(
      {super.key,
      this.isPromo,
      this.ourChoice,
      this.categories,
      this.isProductTile});

  @override
  ProductCarouselState createState() => ProductCarouselState();
}

class ProductCarouselState extends State<ProductCarousel> {
  late String _selectedCategory;
  late final List<String> _categories;

  final List<Product> products = ProductData.products;

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

  @override
  void initState() {
    super.initState();
    _categories = widget.categories ?? ['Appliances', 'Car Parts', 'Toys'];
    _selectedCategory = _categories.first;
  }

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
    return SliverToBoxAdapter(
      child: Column(
        children: [
          CategoryBar(
            isPromo: widget.isPromo,
            ourChoice: widget.ourChoice,
            isProductTile: widget.isProductTile,
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          Container(
            color: const Color(0xFFDBDCDD),
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products
                    .where((p) => p.category == _selectedCategory)
                    .length,
                itemBuilder: (context, index) {
                  final product = products
                      .where((p) => p.category == _selectedCategory)
                      .toList()[index];
                  return ProductItemWrapper(
                    product: product,
                    boxDecorationAnimation: _boxDecorationAnimation,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
