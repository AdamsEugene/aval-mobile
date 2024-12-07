import 'package:e_commerce_app/widgets/shared/category_scroll_list.dart';
import 'package:flutter/cupertino.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryItem category;

  const CategoryDetailPage({
    super.key,
    required this.category,
  });

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  String _selectedSort = 'Recommended';
  double _priceRangeEnd = 1000;
  bool _showFilters = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.category.label),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Filter and Sort Bar
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterButton('Sort', onTap: _showSortOptions),
                  _buildFilterButton('Filter', onTap: () {
                    setState(() => _showFilters = !_showFilters);
                  }),
                  _buildFilterButton('Price', onTap: _showPriceOptions),
                ],
              ),
            ),

            // Filters Panel (expandable)
            if (_showFilters)
              Container(
                padding: const EdgeInsets.all(16),
                color: CupertinoColors.systemGrey6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price Range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    CupertinoSlider(
                      value: _priceRangeEnd,
                      min: 0,
                      max: 1000,
                      onChanged: (value) {
                        setState(() {
                          _priceRangeEnd = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Up to \$${_priceRangeEnd.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Product Grid
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildProductCard(),
                        childCount: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(color: CupertinoColors.systemBlue),
            ),
            const SizedBox(width: 4),
            const Icon(
              CupertinoIcons.chevron_down,
              size: 12,
              color: CupertinoColors.systemBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CupertinoColors.systemGrey5,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                'assets/images/a.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '\$99.99',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.systemBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.star_fill,
                      size: 12,
                      color: CupertinoColors.systemYellow,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '4.5 (128)',
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Sort By'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() => _selectedSort = 'Recommended');
              Navigator.pop(context);
            },
            child: const Text('Recommended'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() => _selectedSort = 'Price: Low to High');
              Navigator.pop(context);
            },
            child: const Text('Price: Low to High'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() => _selectedSort = 'Price: High to Low');
              Navigator.pop(context);
            },
            child: const Text('Price: High to Low'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _showPriceOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          children: [
            const Text(
              'Price Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            CupertinoSlider(
              value: _priceRangeEnd,
              min: 0,
              max: 1000,
              onChanged: (value) {
                setState(() {
                  _priceRangeEnd = value;
                });
              },
            ),
            Text(
              'Up to \$${_priceRangeEnd.toStringAsFixed(0)}',
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
