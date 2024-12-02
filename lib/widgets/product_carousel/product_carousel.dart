// lib/widgets/product_carousel/product_carousel.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
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

  @override
  void initState() {
    super.initState();
    _categories = widget.categories ?? ['Appliances', 'Car Parts', 'Toys'];
    _selectedCategory = _categories.first;
    _productsFuture = ProductService.fetchProducts();
  }

  Animation<Decoration> _boxDecorationAnimation(Animation<double>? animation) {
    if (animation == null) {
      return _tween.animate(
        CurvedAnimation(
          parent: const AlwaysStoppedAnimation<double>(1.0),
          curve: Platform.isIOS
              ? Interval(0.0, CupertinoContextMenu.animationOpensAt)
              : const Interval(0.0, 0.5, curve: Curves.easeInOut),
        ),
      );
    }

    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Platform.isIOS
            ? Interval(0.0, CupertinoContextMenu.animationOpensAt)
            : const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    final filteredProducts =
        products.where((p) => p.category == _selectedCategory).toList();

    if (filteredProducts.isEmpty) {
      return Center(
        child: Text(
          'No products available',
          style: TextStyle(
            color: Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: Platform.isIOS
          ? const AlwaysScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        if (index >= filteredProducts.length) {
          return null; // Return null if the index is out of bounds
        }

        if (filteredProducts.isEmpty) {
          return const SizedBox
              .shrink(); // Return an empty widget if the list is empty
        }

        final product = filteredProducts[index];

        print("product is printing");
        print(product);

        return ProductItemWrapper(
          product: product,
          boxDecorationAnimation: _boxDecorationAnimation,
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: Platform.isIOS
          ? const AlwaysScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      itemCount: 4,
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

  Widget _buildError(String error) {
    return Center(
      child: Text(
        'Error loading products: $error',
        style: TextStyle(
          color: Platform.isIOS ? CupertinoColors.destructiveRed : Colors.red,
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
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingState();
                  }

                  if (snapshot.hasError) {
                    return _buildError(snapshot.error.toString());
                  }

                  final products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(
                          color: Platform.isIOS
                              ? CupertinoColors.systemGrey
                              : Colors.grey,
                        ),
                      ),
                    );
                  }

                  return _buildProductList(products);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
