import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:e_commerce_app/widgets/common/conditional_widget.dart';
import 'package:e_commerce_app/widgets/product_carousel/category_buttons.dart';
import 'package:e_commerce_app/widgets/product_carousel/promo_section.dart';
import 'package:e_commerce_app/widgets/product_carousel/timer_display.dart';
import 'package:e_commerce_app/widgets/product_carousel/title_display.dart';

class CategoryBar extends StatefulWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final bool? isPromo;
  final bool? ourChoice;
  final bool? isProductTile;

  const CategoryBar(
      {super.key,
      required this.categories,
      required this.selectedCategory,
      required this.onCategorySelected,
      this.isPromo,
      this.ourChoice,
      this.isProductTile});

  @override
  CategoryBarState createState() => CategoryBarState();
}

class CategoryBarState extends State<CategoryBar> {
  late Timer _timer;
  int _secondsRemaining = 11 * 3600 + 18 * 60 + 5; // 11:18:05

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEFF1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Expanded(
            child: CategoryButtons(
              categories: widget.categories,
              selectedCategory: widget.selectedCategory,
              onCategorySelected: widget.onCategorySelected,
            ),
          ),
          ConditionalWidget(
            condition: widget.isPromo,
            whenTrue: PromoSection(
              secondsRemaining: _secondsRemaining,
              ourChoice: widget.ourChoice,
            ),
            whenFalse: ConditionalWidget(
              condition: widget.ourChoice,
              whenTrue: const TitleDisplay(title: "Aval Choice"),
              whenFalse: ConditionalWidget(
                  condition: widget.isProductTile,
                  whenTrue: const SizedBox.shrink(),
                  whenFalse: TimerDisplay(secondsRemaining: _secondsRemaining)),
            ),
          ),
        ],
      ),
    );
  }
}
