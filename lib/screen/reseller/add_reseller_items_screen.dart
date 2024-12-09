// lib/screens/reseller/add_reseller_items_screen.dart

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

  Widget _buildProductCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/a.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Product Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Toggle selection
                          },
                          child: const Icon(
                            CupertinoIcons.plus_circle,
                            color: Color(0xFF05001E),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Vendor Name',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vendor Price',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey.darkColor,
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              '\$99.99',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF05001E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Suggested Price',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey.darkColor,
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              '\$129.99',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.activeGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
                  (context, index) => _buildProductCard(context),
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
