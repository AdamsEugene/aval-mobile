// lib/data/product_data.dart
import 'package:e_commerce_app/models/product.dart';

class ProductData {
  static List<Product> products = [
    Product('Ladies bag 15', 'assets/images/a.png', 'Fashion'),
    Product('Shoes 55', 'assets/images/b.png', 'Fashion'),
    Product('Dress blue', 'assets/images/c.png', 'Fashion'),
    Product('Watch 3', 'assets/images/f.png', 'Fashion'),
    Product('Watch 3', 'assets/images/f.png', 'Car Parts'),
    Product('Shoes 55', 'assets/images/a.png', 'Car Parts'),
    Product('Dress blue', 'assets/images/g.png', 'Car Parts'),
    Product('Ladies bag 15', 'assets/images/h.png', 'Car Parts'),
    Product('Shoes 55', 'assets/images/i.png', 'Toys'),
    Product('Ladies bag 15', 'assets/images/j.png', 'Toys'),
    Product('Dress blue', 'assets/images/l.png', 'Toys'),
    Product('Watch 3', 'assets/images/m.png', 'Toys'),
    Product('Watch 3', 'assets/images/n.png', 'Appliances'),
    Product('Shoes 55', 'assets/images/o.png', 'Appliances'),
    Product('Dress blue', 'assets/images/p.png', 'Appliances'),
    Product('Ladies bag 15', 'assets/images/q.png', 'Appliances'),
    Product('Shoes 55', 'assets/images/c.png', 'Aval Choice'),
    Product('Ladies bag 15', 'assets/images/a.png', 'Aval Choice'),
    Product('Watch 3', 'assets/images/e.png', 'Aval Choice'),
    Product('Dress blue', 'assets/images/f.png', 'Aval Choice'),
  ];

  static List<String> categories = [
    'Fashion',
    'Car Parts',
    'Toys',
    'Appliances',
    'Aval Choice'
  ];

  static List<Product> getProductsByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }
}
