// lib/screens/reseller/search_vendor_products_screen.dart
import 'package:e_commerce_app/screen/reseller/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';

class SearchVendorProductsScreen extends StatefulWidget {
  const SearchVendorProductsScreen({super.key});

  @override
  State<SearchVendorProductsScreen> createState() =>
      _SearchVendorProductsScreenState();
}

class _SearchVendorProductsScreenState
    extends State<SearchVendorProductsScreen> {
  String _selectedCategory = 'All';
  String _selectedSort = 'Popular';
  final List<String> _categories = [
    'All',
    'Clothing',
    'Electronics',
    'Home',
    'Beauty'
  ];
  final List<String> _sortOptions = [
    'Popular',
    'Newest',
    'Price: Low to High',
    'Price: High to Low'
  ];
  bool _showFilters = false;

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Search Products',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.slider_horizontal_3,
          onPressed: () {
            setState(() => _showFilters = !_showFilters);
          },
        ),
      ],
    );
  }

  Widget _buildFilters() {
    if (!_showFilters) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort By',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sortOptions.length,
              itemBuilder: (context, index) {
                final option = _sortOptions[index];
                final isSelected = option == _selectedSort;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: isSelected
                        ? const Color(0xFF05001E)
                        : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(18),
                    onPressed: () => setState(() => _selectedSort = option),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected
                            ? CupertinoColors.white
                            : const Color(0xFF05001E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: isSelected
                        ? const Color(0xFF05001E)
                        : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(18),
                    onPressed: () =>
                        setState(() => _selectedCategory = category),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected
                            ? CupertinoColors.white
                            : const Color(0xFF05001E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            const MainSearchBar(),
            SliverPadding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              sliver: SliverToBoxAdapter(
                child: _buildFilters(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ProductCard(context: context),
                  childCount: 10, // Replace with actual product count
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
