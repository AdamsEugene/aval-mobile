// lib/services/product_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_commerce_app/models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com';

  static const Map<String, List<String>> categoryGroups = {
    'Fashion': [
      'mens-shirts',
      'mens-shoes',
      'mens-watches',
      'womens-dresses',
      'womens-shoes',
      'womens-watches',
      'womens-bags',
      'womens-jewellery',
      'sunglasses'
    ],
    'Electronics': ['smartphones', 'laptops', 'tablets', 'mobile-accessories'],
    'Home & Living': ['furniture', 'home-decoration', 'kitchen-accessories'],
    'Beauty & Care': ['fragrances', 'skincare', 'beauty'],
    'Automotive': ['motorcycle', 'vehicle', 'automotive'],
    'Sports & Outdoors': ['sports-accessories'],
    'Groceries': ['groceries'],
  };

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products?limit=100'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> rawProducts = data['products'] as List;
        final Map<String, List<Product>> organizedProducts = {};

        // Initialize lists for each category group
        for (final group in categoryGroups.keys) {
          organizedProducts[group] = [];
        }

        // Organize products into their respective groups
        for (final product in rawProducts) {
          final category = product['category'] as String;

          // Find which group this category belongs to
          for (final entry in categoryGroups.entries) {
            if (entry.value.contains(category)) {
              organizedProducts[entry.key]?.add(
                Product(
                  product['title'],
                  (product['images'] as List<dynamic>)[0], // First image
                  entry.key, // Use the group name as category
                ),
              );
              break;
            }
          }
        }

        // Create final list with evenly distributed products from each group
        final List<Product> finalProducts = [];

        // Take up to 4 products from each category group
        for (final group in organizedProducts.entries) {
          if (group.value.isNotEmpty) {
            finalProducts.addAll(
              group.value.take(4).map(
                    (p) => Product(
                      p.name,
                      p.imageUrl,
                      group.key,
                    ),
                  ),
            );
          }
        }

        // Add some featured products (from mixed categories) for the "Aval Choice"
        final featuredProducts = rawProducts
            .where((p) =>
                (p['rating'] as num) >= 4.5 && (p['images'] as List).isNotEmpty)
            .take(4)
            .map((p) => Product(
                  p['title'],
                  (p['images'] as List<dynamic>)[0],
                  'Aval Choice',
                ))
            .toList();

        finalProducts.addAll(featuredProducts);

        return finalProducts;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      // If it's Aval Choice, fetch top-rated products
      if (category == 'Aval Choice') {
        final response = await http.get(
          Uri.parse('$baseUrl/products?limit=20'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return (data['products'] as List)
              .where((p) => (p['rating'] as num) >= 4.5)
              .take(10)
              .map((p) => Product(
                    p['title'],
                    (p['images'] as List<dynamic>)[0],
                    'Aval Choice',
                  ))
              .toList();
        }
      }

      // For other categories, fetch from their respective groups
      final categoryApiNames = categoryGroups[category] ?? [];
      if (categoryApiNames.isEmpty) return [];

      final allProducts = <Product>[];

      for (final apiCategory in categoryApiNames) {
        final response = await http.get(
          Uri.parse('$baseUrl/products/category/$apiCategory'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          allProducts.addAll(
            (data['products'] as List)
                .map((p) => Product(
                      p['title'],
                      (p['images'] as List<dynamic>)[0],
                      category,
                    ))
                .toList(),
          );
        }
      }

      return allProducts;
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }
}
