import 'package:flutter/cupertino.dart';

class CategoryButtons extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryButtons({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List.generate(categories.length, (index) {
        bool isSelected = selectedCategory == categories[index];
        return Positioned(
          left: index * 90.0,
          child: GestureDetector(
            onTap: () => onCategorySelected(categories[index]),
            child: Container(
              width: 96,
              decoration: BoxDecoration(
                color: isSelected
                    ? CupertinoColors.activeOrange
                    : CupertinoColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      index == 0 ? const Radius.circular(25) : Radius.zero,
                  topRight: index + 1 == categories.length
                      ? const Radius.circular(25)
                      : Radius.zero,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected
                          ? CupertinoColors.white
                          : CupertinoColors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }).reversed.toList(),
    );
  }
}
