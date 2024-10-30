import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/home/home_content.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:e_commerce_app/data/product_data.dart';
import 'package:e_commerce_app/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = ProductData.products;

  @override
  Widget build(BuildContext context) {
    return ButtonTabISO<String>(slivers: const HomeContent());
  }
}
