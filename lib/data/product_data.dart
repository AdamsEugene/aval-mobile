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

  static Future<List<Product>> getRelatedProducts(
      Product currentProduct) async {
    final products = await getProducts();

    // Filter products in the same category but exclude current product
    final categoryProducts = products
        .where((product) =>
            product.category == currentProduct.category &&
            product.id != currentProduct.id)
        .toList();

    // If we don't have enough products in the same category,
    // add products with similar price range
    if (categoryProducts.length < 6) {
      final priceRange = currentProduct.price * 0.2; // 20% price range
      final similarPriceProducts = products
          .where((product) =>
              product.id != currentProduct.id &&
              !categoryProducts.contains(product) &&
              (product.price >= currentProduct.price - priceRange) &&
              (product.price <= currentProduct.price + priceRange))
          .toList();

      // Sort by rating to get the best products
      similarPriceProducts.sort((a, b) => b.rating.compareTo(a.rating));

      // Add the best similar price products to fill up to 6 items
      categoryProducts.addAll(
        similarPriceProducts.take(6 - categoryProducts.length),
      );
    }

    // Sort the final list by rating
    categoryProducts.sort((a, b) => b.rating.compareTo(a.rating));

    // Take up to 6 products
    return categoryProducts.take(6).toList();
  }
}
