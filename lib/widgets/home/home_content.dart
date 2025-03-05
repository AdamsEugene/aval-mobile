import 'package:e_commerce_app/widgets/magic_box/first_time_modal.dart';
import 'package:e_commerce_app/widgets/magic_box/magic_box_carousel.dart';
import 'package:e_commerce_app/widgets/magic_box/new_box_manager.dart';
import 'package:e_commerce_app/widgets/magic_box/new_box_floating_button.dart';
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
  final NewBoxManager _boxManager = NewBoxManager();
  NewBoxData? _currentBox;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.fetchProducts();

    // Initialize NewBoxManager
    _boxManager.initialize();

    // Listen for new boxes
    _boxManager.boxStream.listen((boxData) {
      setState(() {
        _currentBox = boxData;
      });
    });

    // Show the first-time modal after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirstTimeMagicBoxModal.showFirstTime(context);
    });
  }

  @override
  void dispose() {
    _boxManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          SafeArea(
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

                    // Updated MagicBoxCarousel with item counts for each box
                    const MagicBoxCarousel(
                      title: 'Magic Boxes',
                      boxes: [
                        MagicBoxTheme(
                          title: 'Basic Magic',
                          price: 9.99,
                          startColor: Color(0xFFDA4453),
                          endColor: Color(0xFF89216B),
                          itemCount: 1, // Single item box
                        ),
                        MagicBoxTheme(
                          title: 'Premium Bundle',
                          price: 19.99,
                          startColor: Color.fromARGB(255, 73, 218, 68),
                          endColor: Color.fromARGB(255, 33, 137, 61),
                          itemCount: 3, // 3 items bundle
                        ),
                        MagicBoxTheme(
                          title: 'Deluxe Pack',
                          price: 29.99,
                          startColor: Color(0xFF1A2980),
                          endColor: Color(0xFF26D0CE),
                          itemCount: 4, // 4 items pack
                        ),
                        MagicBoxTheme(
                          title: 'Supreme Collection',
                          price: 39.99,
                          startColor: Color(0xFF8E2DE2),
                          endColor: Color(0xFF4A00E0),
                          itemCount: 5, // 5 items collection
                        ),
                        MagicBoxTheme(
                          title: 'Ultimate Treasure',
                          price: 49.99,
                          startColor: Color(0xFFFF8008),
                          endColor: Color(0xFFFFC837),
                          itemCount: 7, // 7 items mega pack
                        ),
                      ],
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 24)),

                    // Featured Collections with different item counts
                    const MagicBoxCarousel(
                      title: 'Featured Collections',
                      boxes: [
                        MagicBoxTheme(
                          title: 'Tech Bundle',
                          price: 34.99,
                          startColor: Color(0xFF614385),
                          endColor: Color(0xFF516395),
                          itemCount: 4, // 4 tech items
                        ),
                        MagicBoxTheme(
                          title: 'Beauty Kit',
                          price: 24.99,
                          startColor: Color(0xFFEC008C),
                          endColor: Color(0xFFFC6767),
                          itemCount: 5, // 5 beauty items
                        ),
                        MagicBoxTheme(
                          title: 'Home Essentials',
                          price: 29.99,
                          startColor: Color(0xFF00B4DB),
                          endColor: Color(0xFF0083B0),
                          itemCount: 3, // 3 home items
                        ),
                        MagicBoxTheme(
                          title: 'Fashion Pack',
                          price: 39.99,
                          startColor: Color(0xFFEE9CA7),
                          endColor: Color(0xFFFFDDE1),
                          itemCount: 4, // 4 fashion items
                        ),
                      ],
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 24)),

                    // Limited Edition boxes with unique item counts
                    const MagicBoxCarousel(
                      title: 'Limited Edition',
                      boxes: [
                        MagicBoxTheme(
                          title: 'Collector\'s Box',
                          price: 59.99,
                          startColor: Color(0xFF141E30),
                          endColor: Color(0xFF243B55),
                          itemCount: 3, // 3 collector items
                        ),
                        MagicBoxTheme(
                          title: 'Luxury Surprise',
                          price: 99.99,
                          startColor: Color(0xFFBC4E9C),
                          endColor: Color(0xFFF80759),
                          itemCount: 2, // 2 luxury items
                        ),
                        MagicBoxTheme(
                          title: 'Elite Box',
                          price: 79.99,
                          startColor: Color(0xFF000428),
                          endColor: Color(0xFF004E92),
                          itemCount: 4, // 4 elite items
                        ),
                      ],
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 24)),

                    // Product carousels will handle their own loading states
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
                    const SliverToBoxAdapter(
                        child: SizedBox(height: 100)), // Extra padding for FAB
                  ],
                );
              },
            ),
          ),

          // Floating button for new magic box
          if (_currentBox != null)
            Positioned(
              bottom: 24,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Time remaining indicator
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: CupertinoColors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.clock,
                          color: CupertinoColors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Expires in: ${_currentBox!.formattedTimeRemaining}',
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Floating button
                  NewBoxFloatingButton(
                    boxTitle: _currentBox!.title,
                    boxPrice: _currentBox!.price,
                    startColor: _currentBox!.startColor,
                    endColor: _currentBox!.endColor,
                    itemCount: _currentBox!.itemCount,
                  ),
                ],
              ),
            ),
        ],
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
