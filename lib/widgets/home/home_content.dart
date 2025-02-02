import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: <Widget>[
                const MainHeader(),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                const MainSearchBar(),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                const CategoryScrollList(),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                const MainBannerCarousel(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Product carousels will handle their own loading states
                const ProductCarousel(
                  ourChoice: true,
                  categories: [
                    'Electronics',
                    'Beauty & Care',
                  ],
                ),
                // const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const ServiceFeatures(),
                // const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const ProductCarousel(
                  isPromo: true,
                  ourChoice: false,
                  categories: ['Home & Living'],
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const AdsBanner(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const ProductCarousel(
                  ourChoice: true,
                  categories: ['Groceries'],
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const AdsBanner(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const ProductCarousel(
                  isPromo: true,
                  ourChoice: false,
                  categories: ['Fashion'],
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                // const ProductCarousel(
                //   isPromo: false,
                //   ourChoice: false,
                //   categories: ['Home & Living'],
                //   isProductTile: true,
                // ),
                // const SliverToBoxAdapter(child: SizedBox(height: 12)),
                // const ProductCarousel(
                //   isPromo: false,
                //   ourChoice: false,
                //   categories: ['Electronics'],
                //   isProductTile: true,
                // ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                const ProductCarousel(
                  isPromo: false,
                  ourChoice: false,
                  categories: ['Aval Choice'],
                  isProductTile: true,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                // Product grid with loading state
                snapshot.connectionState == ConnectionState.waiting
                    ? const _LoadingGrid()
                    : snapshot.hasError
                        ? SliverToBoxAdapter(
                            child: _ErrorWidget(error: snapshot.error),
                          )
                        : ProductGrid(products: snapshot.data ?? []),

                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        ),
      ),
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

  const _ErrorWidget({this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_circle,
            color: CupertinoColors.systemRed,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading products: ${error?.toString()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            onPressed: () {
              // Trigger a rebuild of the HomeContent widget
              // You might want to add a proper refresh mechanism here
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => const HomeContent(),
                ),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// Make sure you have the ShimmerLoading widget from the previous example