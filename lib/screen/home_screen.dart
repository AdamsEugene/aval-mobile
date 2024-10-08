import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/shared/ads_banner.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:e_commerce_app/widgets/shared/service_features.dart';
import 'package:e_commerce_app/widgets/shared/category_scroll_list.dart';
import 'package:e_commerce_app/widgets/shared/main_banner_carousel.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:e_commerce_app/widgets/shared/product_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ButtonTabISO<String>(
      tabItems: [
        CustomTabItem(icon: CupertinoIcons.home, label: 'Home', data: 'home'),
        CustomTabItem(
          icon: CupertinoIcons.shopping_cart,
          label: 'Reseller',
          data: 'reseller',
        ),
        CustomTabItem(
            icon: CupertinoIcons.chat_bubble, label: 'Chat', data: 'chat'),
        CustomTabItem(icon: CupertinoIcons.cart, label: 'Cart', data: 'cart'),
        CustomTabItem(
            icon: CupertinoIcons.person, label: 'Account', data: 'account'),
        CustomTabItem(
            icon: CupertinoIcons.ellipsis_vertical,
            label: 'More',
            data: 'more'),
      ],
      slivers: const <Widget>[
        MainHeader(),
        MainSearchBar(),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        CategoryScrollList(),
        SliverToBoxAdapter(child: SizedBox(height: 4)),
        MainBannerCarousel(),
        SliverToBoxAdapter(child: SizedBox(height: 18)),
        ProductCarousel(ourChoice: true),
        SliverToBoxAdapter(child: SizedBox(height: 24)),
        ServiceFeatures(),
        SliverToBoxAdapter(child: SizedBox(height: 24)),
        ProductCarousel(isPromo: true, ourChoice: false),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        AdsBanner(),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        ProductCarousel(ourChoice: true),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        AdsBanner(),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        ProductCarousel(isPromo: true, ourChoice: false),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
      ],
    );
  }
}
