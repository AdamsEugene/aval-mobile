import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/product_carousel/category_bar.dart';
import 'package:e_commerce_app/widgets/product_carousel/product_item.dart';
import 'package:e_commerce_app/services/product_service.dart';

class ProductCarousel extends StatefulWidget {
  final bool? isPromo;
  final bool? ourChoice;
  final List<String>? categories;
  final bool? isProductTile;

  const ProductCarousel({
    super.key,
    this.isPromo,
    this.ourChoice,
    this.categories,
    this.isProductTile,
  });

  @override
  ProductCarouselState createState() => ProductCarouselState();
}

class ProductCarouselState extends State<ProductCarousel> {
  late String _selectedCategory;
  late final List<String> _categories;
  late Future<List<Product>> _productsFuture;

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
    _productsFuture = ProductService.fetchProducts();
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

  Widget _buildProductList(List<Product> products) {
    final filteredProducts =
        products.where((p) => p.category == _selectedCategory).toList();

    if (filteredProducts.isEmpty) {
      return const Center(
        child: Text(
          'No products available',
          style: TextStyle(color: CupertinoColors.systemGrey),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductItemWrapper(
          product: filteredProducts[index],
          boxDecorationAnimation: _boxDecorationAnimation,
          index: index,
          category: _selectedCategory,
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4, // Show 4 shimmer loading items
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ShimmerLoading(
            width: 160,
            height: 220,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        );
      },
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
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingState();
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading products: ${snapshot.error}',
                        style: const TextStyle(
                            color: CupertinoColors.destructiveRed),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(color: CupertinoColors.systemGrey),
                      ),
                    );
                  }

                  return _buildProductList(snapshot.data!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
