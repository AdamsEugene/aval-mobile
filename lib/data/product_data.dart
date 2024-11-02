// lib/data/product_data.dart
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/product_service.dart';

class ProductData {
  static Future<List<Product>> getProducts() async {
    return await ProductService.fetchProducts();
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    final products = await getProducts();
    return products.where((product) => product.category == category).toList();
  }
}
