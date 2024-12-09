// lib/screens/cart_screen.dart
import 'package:e_commerce_app/data/product_data.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screen/home_screen.dart';
import 'package:e_commerce_app/widgets/product/seller_recommendation_section.dart';
import 'package:e_commerce_app/widgets/products/product_details_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/widgets/cart/cart_summary.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Product>> recommendedProductsFuture;

  // final Product product = P

  @override
  void initState() {
    super.initState();
    recommendedProductsFuture = ProductData.getSellerRecommendations();
  }

  final List<CartItem> _items = [
    CartItem(
      id: '1',
      name: 'Premium Cotton T-Shirt',
      image: 'assets/images/a.jpg',
      price: 29.99,
      size: 'M',
      color: 'Black',
    ),
    CartItem(
      id: '2',
      name: 'Slim Fit Jeans',
      image: 'assets/images/a.jpg',
      price: 59.99,
      size: '32',
      color: 'Blue',
    ),
    CartItem(
      id: '3',
      name: 'Sport Shoes',
      image: 'assets/images/a.jpg',
      price: 89.99,
      size: '42',
      color: 'White',
    ),
  ];

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        _items[index].quantity = newQuantity;
      }
    });
  }

  void _removeItem(int index) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Remove Item'),
        content: Text('Remove ${_items[index].name} from cart?'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              setState(() => _items.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            'Cart',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.bell,
          onPressed: () {},
          badgeCount: 2,
        ),
        HeaderAction(
          icon: CupertinoIcons.person,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCartItem(int index) {
    final item = _items[index];
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product name and details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (item.size != null || item.color != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${item.size ?? ''} ${item.color ?? ''}'.trim(),
                              style: TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.systemGrey.darkColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Delete button
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _removeItem(index),
                      child: const Icon(
                        CupertinoIcons.delete,
                        color: CupertinoColors.destructiveRed,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Price and Quantity Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF05001E),
                      ),
                    ),
                    // Quantity controls in container
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              _updateQuantity(index, item.quantity - 1),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFFEEEEEE),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.minus,
                              size: 14,
                              color: Color(0xFF05001E),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 36,
                          child: Text(
                            item.quantity.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              _updateQuantity(index, item.quantity + 1),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFFEEEEEE),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.plus,
                              size: 14,
                              color: Color(0xFF05001E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            if (_items.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.shopping_cart,
                        size: 64,
                        color: CupertinoColors.systemGrey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        child: const Text('Continue Shopping'),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            if (_items.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(top: 16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _items.length,
                        itemBuilder: (context, index) => _buildCartItem(index),
                      ),
                      CartSummary(
                        items: _items,
                        onCheckout: () {
                          // Handle checkout
                        },
                      ),
                    ],
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            // Recommendations always shown
            SliverToBoxAdapter(
              child: FutureBuilder<List<Product>>(
                future: recommendedProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SellerRecommendationSection(
                      bgColor: const Color(0xFFEEEEEE),
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
            ),
          ],
        ),
      ),
    );
  }
}
