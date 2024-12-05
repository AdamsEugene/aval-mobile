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

  static Future<List<Product>> getRecommendedProducts() async {
    final products = await getProducts();

    // Calculate a score for each product based on rating and stock sold
    final scoredProducts = products.map((product) {
      // Weight: 60% rating, 40% stock sold
      final ratingScore = product.rating * 0.6;
      final stockScore =
          (product.stock / 1000) * 0.4; // Normalize stock to 0-1 range
      return MapEntry(product, ratingScore + stockScore);
    }).toList();

    // Sort products by their score
    scoredProducts.sort((a, b) => b.value.compareTo(a.value));

    // Get top products with at least 4.0 rating
    final recommendations = scoredProducts
        .where((entry) => entry.key.rating >= 4.0)
        .map((entry) => entry.key)
        .take(6)
        .toList();

    // If we don't have enough products, add more based on just rating
    if (recommendations.length < 6) {
      final additionalProducts = products
          .where((product) => !recommendations.contains(product))
          .toList()
        ..sort((a, b) => b.rating.compareTo(a.rating));

      recommendations.addAll(
        additionalProducts.take(6 - recommendations.length),
      );
    }

    return recommendations;
  }

  static Future<List<Product>> getSellerRecommendations(
      Product currentProduct) async {
    final products = await getProducts();

    // First, get products from the same brand with high ratings
    final brandProducts = products
        .where((product) =>
            product.brand == currentProduct.brand &&
            product.id != currentProduct.id &&
            product.rating >= 4.0)
        .toList();

    // If we don't have enough brand products, add top-rated products
    if (brandProducts.length < 40) {
      final otherProducts = products
          .where((product) =>
              product.id != currentProduct.id &&
              !brandProducts.contains(product) &&
              product.rating >= 4.5)
          .toList();

      // Sort by rating and discount percentage
      otherProducts.sort((a, b) {
        final ratingCompare = b.rating.compareTo(a.rating);
        if (ratingCompare != 0) return ratingCompare;
        return b.discountPercentage.compareTo(a.discountPercentage);
      });

      brandProducts.addAll(otherProducts);
    }

    // Sort final list by rating and price
    brandProducts.sort((a, b) {
      final ratingCompare = b.rating.compareTo(a.rating);
      if (ratingCompare != 0) return ratingCompare;
      return a.price.compareTo(b.price); // Better deals first
    });

    return brandProducts;
  }
}
