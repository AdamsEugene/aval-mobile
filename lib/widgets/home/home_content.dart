// lib/widgets/home/home_content.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/product_grid/product_grid.dart';
import 'package:e_commerce_app/widgets/shared/ads_banner.dart';
import 'package:e_commerce_app/widgets/shared/service_features.dart';
import 'package:e_commerce_app/widgets/shared/category_scroll_list.dart';
import 'package:e_commerce_app/widgets/shared/main_banner_carousel.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:e_commerce_app/widgets/product_carousel/product_carousel.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.fetchProducts();
  }

  void _refreshProducts() {
    setState(() {
      _productsFuture = ProductService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollPhysics = Platform.isIOS
        ? const AlwaysScrollableScrollPhysics()
        : const BouncingScrollPhysics();

    final content = RefreshIndicator(
      onRefresh: () async {
        _refreshProducts();
      },
      child: CustomScrollView(
        physics: scrollPhysics,
        slivers: <Widget>[
          const MainHeader(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const MainSearchBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const CategoryScrollList(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const SliverToBoxAdapter(
            child: MainBannerCarousel(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const ProductCarousel(
            ourChoice: true,
            categories: [
              'Electronics',
              'Beauty & Care',
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const ServiceFeatures(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const ProductCarousel(
            isPromo: true,
            ourChoice: false,
            categories: [
              'Electronics',
              'Beauty & Care',
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const AdsBanner(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const ProductCarousel(
            ourChoice: true,
            categories: [
              'Electronics',
              'Beauty & Care',
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const AdsBanner(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const ProductCarousel(
            isPromo: true,
            ourChoice: false,
            categories: [
              'Electronics',
              'Beauty & Care',
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const ProductCarousel(
            isPromo: false,
            ourChoice: false,
            categories: ['Home & Living'],
            isProductTile: true,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const ProductCarousel(
            isPromo: false,
            ourChoice: false,
            categories: ['Electronics'],
            isProductTile: true,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const ProductCarousel(
            isPromo: false,
            ourChoice: false,
            categories: ['Aval Choice'],
            isProductTile: true,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const _LoadingGrid();
              }

              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: _ErrorWidget(
                    error: snapshot.error,
                    onRetry: _refreshProducts,
                  ),
                );
              }

              return ProductGrid(products: snapshot.data ?? []);
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: content)
        : Scaffold(
            backgroundColor: Colors.white,
            body: content,
          );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 160 / 260,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: ShimmerLoading(
              width: 160,
              height: 260,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          );
        },
        childCount: 4,
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const _ErrorWidget({
    this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Platform.isIOS
                ? CupertinoIcons.exclamationmark_circle
                : Icons.error_outline,
            color: Platform.isIOS ? CupertinoColors.systemRed : Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading products: ${error?.toString()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Platform.isIOS
              ? CupertinoButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                )
              : TextButton(
                  onPressed: onRetry,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Retry'),
                ),
        ],
      ),
    );
  }
}
