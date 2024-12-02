// lib/widgets/shared/category_scroll_list.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class CategoryScrollList extends StatelessWidget {
  const CategoryScrollList({super.key});

  final List<CategoryItem> _categories = const [
    CategoryItem('Appliances', 'a.jpg'),
    CategoryItem('Fashion', 'b.jpg'),
    CategoryItem('Car parts', 'c.jpg'),
    CategoryItem('Toys', 'd.jpg'),
    CategoryItem('Computer\nAccessories', 'e.jpg'),
    CategoryItem('Phone\nAccessories', 'f.jpg'),
    CategoryItem('Farm fresh', 'g.jpg'),
    CategoryItem('Farm fresh', 'i.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: Platform.isIOS
                ? const AlwaysScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(_categories[index], context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          // Handle category tap
        },
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageContainer(item),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: Platform.isIOS
                    ? CupertinoColors.black
                    : Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(CategoryItem item) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Shimmer loading placeholder
          Container(
            decoration: BoxDecoration(
              color: Platform.isIOS
                  ? CupertinoColors.systemGrey6
                  : Colors.grey[200],
              shape: BoxShape.circle,
            ),
          ),
          // Actual image with error handling
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/${item.imageName}',
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Platform.isIOS
                          ? CupertinoColors.systemGrey6
                          : Colors.grey[200],
                      child: Icon(
                        Platform.isIOS
                            ? CupertinoIcons.photo
                            : Icons.image_not_supported_outlined,
                        size: 24,
                        color: Platform.isIOS
                            ? CupertinoColors.systemGrey
                            : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String label;
  final String imageName;

  const CategoryItem(this.label, this.imageName);
}
