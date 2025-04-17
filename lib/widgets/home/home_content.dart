import 'dart:math';

import 'package:e_commerce_app/services/ads_service.dart';
import 'package:e_commerce_app/widgets/magic_box/first_time_modal.dart';
import 'package:e_commerce_app/widgets/magic_box/magic_box_carousel.dart';
import 'package:e_commerce_app/widgets/magic_box/multi_items_first_time_modal.dart';
import 'package:e_commerce_app/widgets/magic_box/new_box_manager.dart';
import 'package:e_commerce_app/widgets/magic_box/new_box_floating_button.dart';
import 'package:e_commerce_app/widgets/others/shimmer_loading.dart';
import 'package:e_commerce_app/widgets/promo/promo_ads_modal.dart';
import 'package:e_commerce_app/widgets/promo/promo_banner.dart'; // Import the promo banner
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  late Future<List<Product>> _productsFuture;
  final NewBoxManager _boxManager = NewBoxManager();
  final AdsService _adsService = AdsService(); // Initialize the ads service
  NewBoxData? _currentBox;
  bool _isBoxHidden = false;
  bool _isPromoBannerVisible = true; // Track if promo banner should be visible
  PromoAdData? _currentPromoBanner; // Track current promo banner data
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.fetchProducts();

    // Initialize slide animation
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(1.5, 0), // Slide out to the right
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Initialize NewBoxManager
    _boxManager.initialize();

    // Listen for new boxes
    _boxManager.boxStream.listen((boxData) {
      setState(() {
        _currentBox = boxData;
        _isBoxHidden = false;
        _slideController.reverse(); // Show the box when a new one arrives
      });
    });

    // Set initial promo banner
    _setInitialPromoBanner();

    FirstTimeMagicBoxModal.resetSeenStatus();

    // Show the first-time modal after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Randomize which first-time modal to show (magic box related)
      Random random = Random();
      int modalToShow = random.nextInt(2); // 0 or 1

      // Show a random modal based on the generated number
      if (modalToShow == 0) {
        await FirstTimeMagicBoxModal.showFirstTime(context);
      } else {
        await MultiItemsFirstTimeMagicBoxModal.showFirstTime(context);
      }

      // Check if we should show a promotional ad
      await _checkAndShowPromoAd();
    });
  }

  // Set initial promo banner based on available promotions
  void _setInitialPromoBanner() {
    // Try to get spring sale or fallback to highest priority ad
    try {
      _currentPromoBanner = _adsService.availableAds.firstWhere(
        (ad) => ad.id == 'spring_sale_2025',
        orElse: () {
          // Sort by priority and get highest
          final sortedAds = List<PromoAdData>.from(_adsService.availableAds)
            ..sort((a, b) => b.priority.compareTo(a.priority));
          return sortedAds.first;
        },
      );
    } catch (e) {
      // If no ads available, keep null
      _currentPromoBanner = null;
    }
  }

  Future<void> _checkAndShowPromoAd() async {
    // Add a small delay to ensure first-time modals are closed
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if we should show a promo ad
    final adData = await _adsService.shouldShowAd(context);

    if (adData != null && mounted) {
      // Show the promotional ad with the data
      PromoAdsModal.show(
        context,
        title: adData.title,
        description: adData.description,
        imageUrl: adData.imageUrl,
        buttonText: adData.buttonText,
        promoCode: adData.promoCode,
        expiryDate: adData.expiryDate,
        discount: adData.discount,
        isNewCustomerOnly: adData.isNewCustomerOnly,
        onDismiss: () {
          // Mark this ad as dismissed so it won't show again
          _adsService.markAdDismissed(adData.id);
        },
        onButtonPressed: () {
          // Handle the button press - navigate to relevant section
          _handlePromoButtonPress(adData);
        },
      );
    }
  }

  void _handlePromoButtonPress(PromoAdData adData) {
    // Handle different promotions based on their ID
    switch (adData.id) {
      case 'premium_magic_box':
        // Navigate to magic box section or open the box directly
        break;
      case 'free_shipping':
        // Maybe navigate to a special free shipping category
        break;
      case 'spring_sale_2025':
        // Navigate to spring collection
        break;
      case 'new_user_welcome':
        // Maybe show a welcome guide or navigate to popular items
        break;
      default:
        // Default action for other promotions
        break;
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _boxManager.dispose();
    super.dispose();
  }

  void _toggleBoxVisibility() {
    setState(() {
      _isBoxHidden = !_isBoxHidden;
      if (_isBoxHidden) {
        _slideController.forward();
      } else {
        _slideController.reverse();
      }
    });
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

                    // Debug button to manually trigger promo ads (can be removed in production)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: CupertinoColors.activeBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Show Promotional Ad (Debug)',
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // For testing - show a random ad
                            final ads = _adsService.availableAds;
                            final randomAd = ads[Random().nextInt(ads.length)];

                            PromoAdsModal.show(
                              context,
                              title: randomAd.title,
                              description: randomAd.description,
                              imageUrl: randomAd.imageUrl,
                              buttonText: randomAd.buttonText,
                              promoCode: randomAd.promoCode,
                              expiryDate: randomAd.expiryDate,
                              discount: randomAd.discount,
                              isNewCustomerOnly: randomAd.isNewCustomerOnly,
                            );
                          },
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),

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

                    // Promotional Banner - only visible if we have promo data and visibility is on
                    if (_currentPromoBanner != null && _isPromoBannerVisible)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: PromoBanner(
                            adData: _currentPromoBanner!,
                            onTap: () =>
                                _handlePromoButtonPress(_currentPromoBanner!),
                            onDismiss: () {
                              setState(() {
                                _isPromoBannerVisible = false;
                              });
                            },
                          ),
                        ),
                      ),

                    const SliverToBoxAdapter(child: SizedBox(height: 16)),

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

          // Floating button for new magic box with hide/show functionality
          if (_currentBox != null)
            Positioned(
              bottom: 24,
              right: _isBoxHidden ? 0 : 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Hidden state indicator tab (only visible when box is hidden)
                  if (_isBoxHidden)
                    GestureDetector(
                      onTap: _toggleBoxVisibility,
                      child: Container(
                        height: 48, // Match the height of the box button
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _currentBox!.startColor,
                              _currentBox!.endColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _currentBox!.startColor.withOpacity(0.4),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.gift_fill,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),

                  // Animated floating button
                  SlideTransition(
                    position: _slideAnimation,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Actual magic box button
                        NewBoxFloatingButton(
                          boxTitle: _currentBox!.title,
                          boxPrice: _currentBox!.price,
                          startColor: _currentBox!.startColor,
                          endColor: _currentBox!.endColor,
                          itemCount: _currentBox!.itemCount,
                        ),

                        // X button positioned in the top-right corner of the magic box
                        Positioned(
                          top: -8,
                          right: -12,
                          child: GestureDetector(
                            onTap: _toggleBoxVisibility,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.clear,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
