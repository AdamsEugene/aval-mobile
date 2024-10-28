import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/product_carousel/category_bar.dart';
import 'package:e_commerce_app/widgets/product_carousel/product_item.dart';

class ProductCarousel extends StatefulWidget {
  final bool? isPromo;
  final bool? ourChoice;

  const ProductCarousel({super.key, this.isPromo, this.ourChoice});

  @override
  ProductCarouselState createState() => ProductCarouselState();
}

class ProductCarouselState extends State<ProductCarousel> {
  String _selectedCategory = 'Appliances';
  final List<String> categories = ['Appliances', 'Car Parts', 'Toys'];

  final List<Product> products = [
    Product('Ladies bag 15', 'assets/images/a.png', 'Fashion'),
    Product('Shoes 55', 'assets/images/b.png', 'Fashion'),
    Product('Dress blue', 'assets/images/c.png', 'Fashion'),
    Product('Watch 3', 'assets/images/d.png', 'Fashion'),
    Product('Watch 3', 'assets/images/e.png', 'Car Parts'),
    Product('Shoes 55', 'assets/images/f.png', 'Car Parts'),
    Product('Dress blue', 'assets/images/g.png', 'Car Parts'),
    Product('Ladies bag 15', 'assets/images/h.png', 'Car Parts'),
    Product('Shoes 55', 'assets/images/i.png', 'Toys'),
    Product('Ladies bag 15', 'assets/images/j.png', 'Toys'),
    Product('Dress blue', 'assets/images/l.png', 'Toys'),
    Product('Watch 3', 'assets/images/m.png', 'Toys'),
    Product('Watch 3', 'assets/images/n.png', 'Appliances'),
    Product('Shoes 55', 'assets/images/o.png', 'Appliances'),
    Product('Dress blue', 'assets/images/p.png', 'Appliances'),
    Product('Ladies bag 15', 'assets/images/q.png', 'Appliances'),
    Product('Shoes 55', 'assets/images/c.png', 'Aval Choice'),
    Product('Ladies bag 15', 'assets/images/a.png', 'Aval Choice'),
    Product('Watch 3', 'assets/images/e.png', 'Aval Choice'),
    Product('Dress blue', 'assets/images/f.png', 'Aval Choice'),
  ];

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
    return SliverToBoxAdapter(
      child: Column(
        children: [
          CategoryBar(
            isPromo: widget.isPromo,
            ourChoice: widget.ourChoice,
            categories: categories,
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
