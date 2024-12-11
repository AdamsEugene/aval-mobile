import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screen/checkout/checkout_screen.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:e_commerce_app/widgets/shared/custom_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String color;
  final String size;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.image,
  });
}

class CartDrawer extends StatefulWidget {
  final Product product;
  const CartDrawer({super.key, required this.product});

  static void show(BuildContext context, Product product) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CartDrawer(product: product),
    );
  }

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  int _selectedTab = 0;

  // Helper method to get the segmented control items
  Map<int, SegmentItem> get _tabItems => {
        0: SegmentItem(
          text: 'Cart (${_cartItems.length})',
          icon: CupertinoIcons.cart,
        ),
        1: SegmentItem(
          text: 'Saved (${_savedItems.length})',
          icon: CupertinoIcons.bookmark,
        ),
      };

  final List<CartItem> _cartItems = [
    CartItem(
        id: '1',
        name: 'iPhone 13 Pro',
        color: 'Sierra Blue',
        size: '256GB',
        price: 999.99,
        quantity: 1,
        image:
            'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png'),
    CartItem(
        id: '2',
        name: 'AirPods Pro',
        color: 'White',
        size: 'One Size',
        price: 249.99,
        quantity: 2,
        image:
            'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png'),
    CartItem(
        id: '3',
        name: 'Apple Watch Series 7',
        color: 'Midnight',
        size: '45mm',
        price: 399.99,
        quantity: 1,
        image:
            'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png')
  ];

  final List<CartItem> _savedItems = [
    CartItem(
        id: '4',
        name: 'iPad Air',
        color: 'Space Gray',
        size: '64GB',
        price: 599.99,
        quantity: 1,
        image:
            'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png'),
    CartItem(
        id: '5',
        name: 'MacBook Pro',
        color: 'Silver',
        size: '14-inch',
        price: 1999.99,
        quantity: 1,
        image:
            'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png')
  ];

  void _moveToSavedItems(CartItem item) {
    setState(() {
      _cartItems.remove(item);
      _savedItems.add(item);
    });
  }

  void _moveToCart(CartItem item) {
    setState(() {
      _savedItems.remove(item);
      _cartItems.add(item);
    });
  }

  Widget _buildProductItem(CartItem item, bool isCart) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Color: ${item.color} • Size: ${item.size}',
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'USD ${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isCart) ...[
                      // Quantity Controls for Cart Items
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFEEEEEE)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (item.quantity > 1) {
                                  setState(() => item.quantity--);
                                }
                              },
                              child: const Icon(CupertinoIcons.minus, size: 16),
                            ),
                            SizedBox(
                              width: 32,
                              child: Text(
                                item.quantity.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() => item.quantity++);
                              },
                              child: const Icon(CupertinoIcons.plus, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                // Save for Later / Move to Cart Button
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (isCart) {
                      _moveToSavedItems(item);
                    } else {
                      _moveToCart(item);
                    }
                  },
                  child: Text(
                    isCart ? 'Save for Later' : 'Move to Cart',
                    style: const TextStyle(
                      color: CupertinoColors.activeOrange,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Calculate total price for cart items
  double get _totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(isTotal ? 1 : 0.6),
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF05001E),
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = _totalPrice;
    final double tax = subtotal * 0.1; // 10% tax rate
    final double total = subtotal + tax;

    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shopping Cart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF05001E),
                      ),
                    ),
                    Text(
                      '${_cartItems.length} items',
                      style: TextStyle(
                        color: const Color(0xFF05001E).withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: CustomSegmentedControl<int>(
              groupValue: _selectedTab,
              children: _tabItems,
              onValueChanged: (value) {
                if (value != null) {
                  setState(() => _selectedTab = value);
                }
              },
              backgroundColor: const Color(0xFFF5F5F5),
              thumbColor: const Color(0xFF05001E),
              selectedTextColor: CupertinoColors.white,
              unselectedTextColor: const Color(0xFF666666),
            ),
          ),
          // Content Area
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: _selectedTab == 0
                    ? _cartItems
                        .map((item) => _buildProductItem(item, true))
                        .toList()
                    : _savedItems
                        .map((item) => _buildProductItem(item, false))
                        .toList(),
              ),
            ),
          ),

          // Summary and Checkout (only shown in cart tab)
          if (_selectedTab == 0)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                      'Subtotal', 'USD ${subtotal.toStringAsFixed(2)}'),
                  _buildSummaryRow('Shipping', 'Free'),
                  _buildSummaryRow('Tax', 'USD ${tax.toStringAsFixed(2)}'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  _buildSummaryRow('Total', 'USD ${total.toStringAsFixed(2)}',
                      isTotal: true),
                  const SizedBox(height: 16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) =>
                              CheckoutScreen(product: widget.product),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeOrange,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
    );
  }
}
