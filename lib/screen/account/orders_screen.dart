// lib/screens/account/orders_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final String status;
  final String date;
  final double total;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.status,
    required this.date,
    required this.total,
    required this.items,
  });
}

class OrderItem {
  final String name;
  final String image;
  final int quantity;
  final double price;
  final String color;
  final String size;

  OrderItem({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.color,
    required this.size,
  });
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  // Sample data - In a real app, this would come from an API
  List<Order> get _orders => [
        Order(
          id: 'ORD-123456',
          status: 'Delivered',
          date: 'Dec 10, 2024',
          total: 299.97,
          items: [
            OrderItem(
              name: 'iPhone 13 Pro',
              image:
                  'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png',
              quantity: 1,
              price: 299.97,
              color: 'Sierra Blue',
              size: '256GB',
            ),
          ],
        ),
        Order(
          id: 'ORD-123455',
          status: 'In Transit',
          date: 'Dec 8, 2024',
          total: 549.98,
          items: [
            OrderItem(
              name: 'AirPods Pro',
              image:
                  'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/1.png',
              quantity: 2,
              price: 249.99,
              color: 'White',
              size: 'One Size',
            ),
          ],
        ),
      ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return CupertinoColors.activeGreen;
      case 'in transit':
        return CupertinoColors.activeOrange;
      case 'pending':
        return CupertinoColors.systemGrey;
      case 'cancelled':
        return CupertinoColors.destructiveRed;
      default:
        return CupertinoColors.systemGrey;
    }
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // TODO: Navigate to order details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.id,
                        style: const TextStyle(
                          color: Color(0xFF05001E),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.date,
                        style: TextStyle(
                          color: const Color(0xFF05001E).withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(item.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
                            const SizedBox(height: 4),
                            Text(
                              'Qty: ${item.quantity} • USD ${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'USD ${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              title: 'My Orders',
              showBackButton: true,
              showProfile: false,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              ..._orders.map((order) => _buildOrderCard(order)).toList(),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }
}
