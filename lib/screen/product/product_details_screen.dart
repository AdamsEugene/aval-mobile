// lib/screens/product/product_details_screen.dart
import 'package:e_commerce_app/data/product_data.dart';
import 'package:e_commerce_app/widgets/product/product_details_top_buttons.dart';
import 'package:e_commerce_app/widgets/common/floating_scroll_to_top.dart';
import 'package:e_commerce_app/widgets/product/color_selection.dart';
import 'package:e_commerce_app/widgets/product/coupon_section.dart';
import 'package:e_commerce_app/widgets/product/detail_product_images_section.dart';
import 'package:e_commerce_app/widgets/product/price_session.dart';
import 'package:e_commerce_app/widgets/product/product_details_section.dart';
import 'package:e_commerce_app/widgets/product/product_title_section.dart';
import 'package:e_commerce_app/widgets/product/seller_recommendation_section.dart';
import 'package:e_commerce_app/widgets/product/stock_info_section.dart';
import 'package:e_commerce_app/widgets/product/store_info_section.dart';
import 'package:e_commerce_app/widgets/customization/customization_options_section.dart';
import 'package:e_commerce_app/widgets/common/floating_cart_button.dart';
import 'package:e_commerce_app/widgets/product/product_bottom_bar.dart';
import 'package:e_commerce_app/widgets/products/product_details_drawer.dart';
import 'package:e_commerce_app/widgets/products/related_items_section.dart';
import 'package:e_commerce_app/widgets/protection/protection_plan_section.dart';
import 'package:e_commerce_app/widgets/return_policy/return_policy_section.dart';
import 'package:e_commerce_app/widgets/reviews/product_reviews_section.dart';
import 'package:e_commerce_app/widgets/reviews/review_gallery_section.dart';
import 'package:e_commerce_app/widgets/reviews/review_gallery_viewer.dart';
import 'package:e_commerce_app/widgets/security/security_info_section.dart';
import 'package:e_commerce_app/widgets/shipping/shipping_info_section.dart';
import 'package:e_commerce_app/widgets/subscription/subscription_info_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String heroTag; // Add heroTag parameter

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.heroTag,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  late Future<List<Product>> relatedProductsFuture;
  late Future<List<Product>> recommendedProductsFuture;

  @override
  void initState() {
    super.initState();
    relatedProductsFuture = ProductData.getRelatedProducts(widget.product);
    recommendedProductsFuture =
        ProductData.getSellerRecommendations(widget.product);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _currentImageIndex = 0;

  // In your ProductDetailsScreen
  Widget _buildImageCarousel() {
    return Stack(
      children: [
        Hero(
          tag: widget.heroTag,
          child: PageView.builder(
            itemCount: widget.product.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.product.images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: CupertinoColors.systemGrey6,
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 32,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.product.images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentImageIndex == index
                    ? 16
                    : 8, // Double width when active
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      4), // Use rounded rectangle for better look with width change
                  color: _currentImageIndex == index
                      ? CupertinoColors.activeOrange
                      : CupertinoColors.systemGrey4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> reviewCategories = {
      'High quality': 27,
      'Satisfied': 31,
      'love it': 101,
    };

    // Calculate average rating from product reviews
    final double averageRating = widget.product.reviews.isEmpty
        ? 0.0
        : widget.product.reviews.map((r) => r.rating).reduce((a, b) => a + b) /
            widget.product.reviews.length;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: _buildImageCarousel(),
                ),
                const PriceSession(),
                const CouponSection(),
                const ProductTitleSection(),
                ColorSelection(product: widget.product),
                const StockInfoSection(),
                const CustomizationOptionsSection(),
                const StoreInfoSection(),
                const ShippingInfoSection(),
                const SecurityInfoSection(),
                const ProtectionPlanSection(),
                const ReturnPolicySection(),
                const SubscriptionInfoSection(),
                ProductDetailsSection(
                  description: widget.product.description,
                  // Optional: set expandable to false for always expanded view
                  // expandable: false,
                ),
                DetailProductImagesSection(
                  images: widget.product.images,
                ),
                ProductReviewsSection(
                  product: widget.product,
                  reviews: widget.product.reviews,
                  averageRating: averageRating,
                  reviewCategories: reviewCategories,
                ),
                ReviewGallerySection(
                  images: widget.product.images,
                  onViewAll: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => ReviewGalleryViewer(
                          images: widget.product.images,
                        ),
                      ),
                    );
                  },
                ),
                FutureBuilder<List<Product>>(
                  future: relatedProductsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return RelatedItemsSection(
                        relatedProducts: snapshot.data!,
                        onProductTap: (product) {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => ProductDetailsDrawer(
                              product: product,
                              heroTag:
                                  'product-${product.id}-${product.thumbnail}',
                              onAddToCart: () {
                                // Add to cart logic here
                                Navigator.pop(context);
                              },
                              onBuyNow: () {
                                // Buy now logic here
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                FutureBuilder<List<Product>>(
                  future: recommendedProductsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SellerRecommendationSection(
                        recommendations: snapshot.data!,
                        onProductTap: (product) {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => ProductDetailsDrawer(
                              product: product,
                              heroTag:
                                  'product-${product.id}-${product.thumbnail}',
                              onAddToCart: () {
                                // Add to cart logic here
                                Navigator.pop(context);
                              },
                              onBuyNow: () {
                                // Buy now logic here
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                        onFavoriteTap: (product) {
                          // Handle favorite toggle
                          setState(() {
                            // Update favorite status in your state management
                          });
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 78),
              ],
            ),
          ),
          SafeArea(
            child: ProductDetailsTopButtons(
              scrollController: _scrollController,
            ),
          ),
          FloatingCartButton(
            product: widget.product,
          ),
          FloatingScrollToTop(
            scrollController: _scrollController,
            bottom: 170,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ProductBottomBar(product: widget.product),
          ),
        ],
      ),
    );
  }
}
