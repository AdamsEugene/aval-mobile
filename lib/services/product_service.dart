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

  static Map<String, dynamic> _normalizeProductData(
      Map<String, dynamic> rawProduct, String categoryGroup) {
    return {
      'id': rawProduct['id'] ?? 0,
      'title': rawProduct['title'] ?? 'Untitled Product',
      'description': rawProduct['description'] ?? 'No description available',
      'category': categoryGroup,
      'price': (rawProduct['price'] ?? 0).toDouble(),
      'discountPercentage': (rawProduct['discountPercentage'] ?? 0).toDouble(),
      'rating': (rawProduct['rating'] ?? 0).toDouble(),
      'stock': rawProduct['stock'] ?? 0,
      'tags': rawProduct['tags'] ?? ['uncategorized'],
      'brand': rawProduct['brand'] ?? 'Unknown Brand',
      'sku': (rawProduct['id'] ?? '0').toString(),
      'weight': rawProduct['weight'] ?? 0.0,
      'dimensions': rawProduct['dimensions'] ??
          {
            'width': 0.0,
            'height': 0.0,
            'depth': 0.0,
          },
      'warrantyInformation':
          rawProduct['warrantyInformation'] ?? 'Standard Warranty',
      'shippingInformation':
          rawProduct['shippingInformation'] ?? 'Standard Shipping',
      'availabilityStatus':
          (rawProduct['stock'] ?? 0) > 0 ? 'In Stock' : 'Out of Stock',
      'reviews': rawProduct['reviews'] ?? [],
      'returnPolicy': rawProduct['returnPolicy'] ?? 'Standard Return Policy',
      'minimumOrderQuantity': rawProduct['minimumOrderQuantity'] ?? 1,
      'meta': rawProduct['meta'] ??
          {
            'createdAt': DateTime.now().toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
            'barcode': (rawProduct['id'] ?? '0').toString(),
            'qrCode': 'https://dummyjson.com/qr-code/${rawProduct['id'] ?? 0}'
          },
      'images': (rawProduct['images'] as List<dynamic>?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
      'thumbnail': rawProduct['thumbnail'] ?? 'https://via.placeholder.com/150',
    };
  }

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
          final category = product['category'] as String?;
          if (category == null) continue;

          // Find which group this category belongs to
          for (final entry in categoryGroups.entries) {
            if (entry.value.contains(category)) {
              try {
                final normalizedData = _normalizeProductData(
                    product as Map<String, dynamic>, entry.key);
                final productObj = Product.fromJson(normalizedData);
                organizedProducts[entry.key]?.add(productObj);
              } catch (e) {
                print('Error processing product: ${product['id']} - $e');
                continue;
              }
              break;
            }
          }
        }

        // Create final list with evenly distributed products from each group
        final List<Product> finalProducts = [];

        // Take up to 4 products from each category group
        for (final group in organizedProducts.entries) {
          if (group.value.isNotEmpty) {
            finalProducts.addAll(group.value.take(4));
          }
        }

        // Add featured products for "Aval Choice"
        final featuredProducts = rawProducts
            .where((p) => ((p['rating'] as num?) ?? 0) >= 4.5)
            .take(4)
            .map((p) => Product.fromJson(_normalizeProductData(
                p as Map<String, dynamic>, 'Aval Choice')))
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
        final response =
            await http.get(Uri.parse('$baseUrl/products?limit=20'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return (data['products'] as List)
              .where((p) => ((p['rating'] as num?) ?? 0) >= 4.5)
              .take(10)
              .map((p) => Product.fromJson(_normalizeProductData(
                  p as Map<String, dynamic>, 'Aval Choice')))
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
                .map((p) => Product.fromJson(
                    _normalizeProductData(p as Map<String, dynamic>, category)))
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
