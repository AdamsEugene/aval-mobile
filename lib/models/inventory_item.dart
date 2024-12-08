// lib/models/inventory_item.dart
class InventoryItem {
  final String id;
  final String name;
  final String image;
  final int currentStock;
  final int totalStock;
  final double price;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final bool isLowStock;
  final DateTime lastUpdated;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.image,
    required this.currentStock,
    required this.totalStock,
    required this.price,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.lastUpdated,
    this.isLowStock = false,
  });
}
