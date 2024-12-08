// lib/models/cart_item.dart
class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int quantity;
  final String? size;
  final String? color;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.size,
    this.color,
  });
}
