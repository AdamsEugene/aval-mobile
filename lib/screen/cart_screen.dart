// lib/screens/cart_screen.dart
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
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 1,
          ),
        ),
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
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if (item.size != null || item.color != null)
                  Text(
                    '${item.size ?? ''} ${item.color ?? ''}'.trim(),
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                  ),
                const SizedBox(height: 8),
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
                    Row(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              _updateQuantity(index, item.quantity - 1),
                          child: const Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: Color(0xFF05001E),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              _updateQuantity(index, item.quantity + 1),
                          child: const Icon(
                            CupertinoIcons.plus_circle_fill,
                            color: Color(0xFF05001E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Remove Button
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _removeItem(index),
            child: const Icon(
              CupertinoIcons.delete,
              color: CupertinoColors.destructiveRed,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverToBoxAdapter(
              child: _items.isEmpty
                  ? Center(
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
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _items.length,
                          itemBuilder: (context, index) =>
                              _buildCartItem(index),
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
          ],
        ),
      ),
    );
  }
}
