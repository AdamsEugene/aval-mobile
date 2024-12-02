// lib/widgets/shared/category_buttons.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

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

  Color get _selectedColor => Platform.isIOS
      ? CupertinoColors.activeOrange
      : const Color(0xFFFFA000); // Material amber

  BoxShadow get _platformShadow => Platform.isIOS
      ? BoxShadow(
          color: CupertinoColors.systemGrey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(2, 4),
        )
      : BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 6,
          offset: const Offset(0, 3),
        );

  Widget _buildButton(int index, bool isSelected, String category) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCategorySelected(category),
        borderRadius: BorderRadius.only(
          bottomLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
          topRight: index + 1 == categories.length
              ? const Radius.circular(25)
              : Radius.zero,
        ),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: isSelected ? _selectedColor : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
              topRight: index + 1 == categories.length
                  ? const Radius.circular(25)
                  : Radius.zero,
            ),
            boxShadow: [_platformShadow],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List.generate(categories.length, (index) {
        bool isSelected = selectedCategory == categories[index];
        return Positioned(
          left: index * 110.0,
          child: AnimatedScale(
            scale: isSelected ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: _buildButton(index, isSelected, categories[index]),
            ),
          ),
        );
      }).reversed.toList(),
    );
  }
}
