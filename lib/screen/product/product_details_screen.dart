// lib/screens/product/product_details_screen.dart
import 'package:e_commerce_app/data/product_data.dart';
import 'package:e_commerce_app/widgets/product/color_selection.dart';
import 'package:e_commerce_app/widgets/product/coupon_section.dart';
import 'package:e_commerce_app/widgets/product/price_session.dart';
import 'package:e_commerce_app/widgets/product/product_title_section.dart';
import 'package:e_commerce_app/widgets/product/stock_info_section.dart';
import 'package:e_commerce_app/widgets/product/store_info_section.dart';
import 'package:e_commerce_app/widgets/customization/customization_options_section.dart';
import 'package:e_commerce_app/widgets/product/floating_cart_button.dart';
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
  late Future<List<Product>> relatedProductsFuture;

  @override
  void initState() {
    super.initState();
    relatedProductsFuture = ProductData.getRelatedProducts(widget.product);
  }

  int _currentImageIndex = 0;
  final List<String> _dummyImages = [
    'image1_url',
    'image2_url',
    'image3_url',
    'image4_url',
    'image5_url',
    'image6_url',
    'image7_url',
  ];

  Widget _buildTopButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  CupertinoIcons.back,
                  color: Color(0xFF05001E),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Handle favorite
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      CupertinoIcons.heart,
                      color: Color(0xFF05001E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Handle share
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      CupertinoIcons.share,
                      color: Color(0xFF05001E),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // In your ProductDetailsScreen
  Widget _buildImageCarousel() {
    return Stack(
      children: [
        Hero(
          tag: widget.heroTag,
          child: PageView.builder(
            itemCount: _dummyImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.product.thumbnail,
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
              _dummyImages.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index
                      ? const Color(0xFFFDC202)
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
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: _buildImageCarousel(),
                ),
                const PriceSession(),
                const CouponSection(),
                ColorSelection(product: widget.product),
                const ProductTitleSection(),
                const StockInfoSection(),
                const StoreInfoSection(),
                const CustomizationOptionsSection(),
                const ShippingInfoSection(),
                const SecurityInfoSection(),
                const SubscriptionInfoSection(),
                const ProtectionPlanSection(),
                const ReturnPolicySection(),
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
                SizedBox(height: MediaQuery.of(context).padding.bottom + 78),
              ],
            ),
          ),
          SafeArea(
            child: _buildTopButtons(),
          ),
          const FloatingCartButton(),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ProductBottomBar(),
          ),
        ],
      ),
    );
  }
}
