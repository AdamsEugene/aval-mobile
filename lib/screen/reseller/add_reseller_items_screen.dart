// lib/screens/reseller/add_reseller_items_screen.dart

import 'package:e_commerce_app/screen/reseller/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';

class AddResellerItemsScreen extends StatefulWidget {
  const AddResellerItemsScreen({super.key});

  @override
  State<AddResellerItemsScreen> createState() => _AddResellerItemsScreenState();
}

class _AddResellerItemsScreenState extends State<AddResellerItemsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Clothing',
    'Electronics',
    'Home',
    'Beauty'
  ];

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
            'Add Items',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.cart_badge_plus,
          onPressed: () {
            // Handle selected items
          },
          badgeCount: 0, // Number of selected items
        ),
      ],
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
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: _categories.map((category) {
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
                  }).toList(),
                ),
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
