// lib/screens/inventory_screen.dart
import 'package:e_commerce_app/widgets/shared/custom_segmented_control.dart';
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/inventory_item.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

enum Category { all, clothing, accessories, shoes }

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  Category _selectedPeriod = Category.all;

  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Clothing', 'Accessories', 'Shoes'];

  // Sample data - replace with your actual data source
  final List<InventoryItem> _items = [
    InventoryItem(
      id: '1',
      name: 'Premium Cotton T-Shirt',
      image: 'assets/images/a.jpg',
      currentStock: 150,
      totalStock: 200,
      price: 29.99,
      category: 'Clothing',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'White', 'Navy'],
      lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
    ),
    InventoryItem(
      id: '2',
      name: 'Slim Fit Jeans',
      image: 'assets/images/a.jpg',
      currentStock: 45,
      totalStock: 100,
      price: 59.99,
      category: 'Clothing',
      sizes: ['30', '32', '34', '36'],
      colors: ['Blue', 'Black'],
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
    ),
    InventoryItem(
      id: '3',
      name: 'Running Shoes',
      image: 'assets/images/a.jpg',
      currentStock: 12,
      totalStock: 100,
      price: 89.99,
      category: 'Shoes',
      sizes: ['40', '41', '42', '43', '44'],
      colors: ['White', 'Black', 'Red'],
      lastUpdated: DateTime.now(),
      isLowStock: true,
    ),
  ];

  List<InventoryItem> get filteredItems {
    return _items.where((item) {
      final matchesSearch =
          item.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 48, // Fixed height
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: CustomSegmentedControl<Category>(
          groupValue: _selectedPeriod,
          onValueChanged: (value) {
            if (value != null) {
              setState(() => _selectedPeriod = value);
            }
          },
          children: const {
            Category.all: SegmentItem(
              text: 'All',
              // icon: CupertinoIcons.clock,
            ),
            Category.clothing: SegmentItem(
              text: 'Clothing',
              // icon: CupertinoIcons.calendar,
            ),
            Category.accessories: SegmentItem(
              text: 'Access...',
              // icon: CupertinoIcons.calendar_badge_plus,
            ),
            Category.shoes: SegmentItem(
              text: 'Shoes',
              // icon: CupertinoIcons.calendar_circle,
            ),
          },
        ),
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
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: _buildCategories(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildInventoryItem(filteredItems[index]),
                  childCount: filteredItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            'Inventory',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.plus_circle,
          onPressed: () {
            // Add new inventory item
          },
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const MainSearchBar(),
          const SizedBox(height: 16),
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

  Widget _buildInventoryItem(InventoryItem item) {
    final percentage =
        (item.currentStock / item.totalStock * 100).clamp(0, 100);
    final statusColor = item.isLowStock
        ? CupertinoColors.destructiveRed
        : percentage < 50
            ? CupertinoColors.systemYellow
            : CupertinoColors.activeGreen;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                  item.image,
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
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF05001E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildTag('${item.sizes.length} Sizes'),
                        _buildTag('${item.colors.length} Colors'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stock Level',
                style: TextStyle(
                  color: CupertinoColors.systemGrey.darkColor,
                ),
              ),
              Text(
                '${item.currentStock}/${item.totalStock}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          if (item.isLowStock) ...[
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_triangle_fill,
                  color: CupertinoColors.destructiveRed,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Low Stock Alert',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: CupertinoColors.systemGrey.darkColor,
        ),
      ),
    );
  }
}
