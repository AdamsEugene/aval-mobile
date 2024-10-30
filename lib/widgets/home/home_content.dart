import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/data/product_data.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/product_grid/product_grid.dart';
import 'package:e_commerce_app/widgets/shared/ads_banner.dart';
import 'package:e_commerce_app/widgets/shared/service_features.dart';
import 'package:e_commerce_app/widgets/shared/category_scroll_list.dart';
import 'package:e_commerce_app/widgets/shared/main_banner_carousel.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:e_commerce_app/widgets/product_carousel/product_carousel.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData.products;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const MainHeader(),
            const MainSearchBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const CategoryScrollList(),
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
            const MainBannerCarousel(),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            const ProductCarousel(ourChoice: true),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const ServiceFeatures(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const ProductCarousel(isPromo: true, ourChoice: false),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const AdsBanner(),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const ProductCarousel(ourChoice: true),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const AdsBanner(),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const ProductCarousel(isPromo: true, ourChoice: false),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const ProductCarousel(
              isPromo: false,
              ourChoice: false,
              categories: ['Appliances'],
              isProductTile: true,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const ProductCarousel(
              isPromo: false,
              ourChoice: false,
              categories: ['Toys'],
              isProductTile: true,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const ProductCarousel(
              isPromo: false,
              ourChoice: false,
              categories: ['Aval Choice'],
              isProductTile: true,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            ProductGrid(products: products),
          ],
        ),
      ),
    );
  }
}
