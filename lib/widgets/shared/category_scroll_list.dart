import 'package:e_commerce_app/screen/deals/category_detail_page.dart';
import 'package:flutter/cupertino.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CategoryDetailPage(category: item),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey.withOpacity(0.5),
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
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String label;
  final String imageName;

  const CategoryItem(this.label, this.imageName);
}
