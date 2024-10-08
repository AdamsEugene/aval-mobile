import 'package:flutter/cupertino.dart';

import 'dart:async';

import 'package:e_commerce_app/widgets/common/conditional_widget.dart';

class ProductCarousel extends StatefulWidget {
  final bool? isPromo;
  final bool? ourChoice;

  const ProductCarousel({super.key, this.isPromo, this.ourChoice});

  @override
  ProductCarouselState createState() => ProductCarouselState();
}

class ProductCarouselState extends State<ProductCarousel> {
  String _selectedCategory = 'Appliances';
  final List<String> categories = ['Appliances', 'Car Parts', 'Toys'];

  final List<Product> products = [
    Product('Ladies bag 15', 'assets/images/a.jpg', 'Fashion'),
    Product('Shoes 55', 'assets/images/c.jpg', 'Fashion'),
    Product('Dress blue', 'assets/images/f.jpg', 'Fashion'),
    Product('Watch 3', 'assets/images/e.jpg', 'Fashion'),
    Product('Watch 3', 'assets/images/e.jpg', 'Car Parts'),
    Product('Shoes 55', 'assets/images/c.jpg', 'Car Parts'),
    Product('Dress blue', 'assets/images/f.jpg', 'Car Parts'),
    Product('Ladies bag 15', 'assets/images/a.jpg', 'Car Parts'),
    Product('Shoes 55', 'assets/images/c.jpg', 'Toys'),
    Product('Ladies bag 15', 'assets/images/a.jpg', 'Toys'),
    Product('Dress blue', 'assets/images/f.jpg', 'Toys'),
    Product('Watch 3', 'assets/images/e.jpg', 'Toys'),
    Product('Watch 3', 'assets/images/e.jpg', 'Appliances'),
    Product('Shoes 55', 'assets/images/c.jpg', 'Appliances'),
    Product('Dress blue', 'assets/images/f.jpg', 'Appliances'),
    Product('Ladies bag 15', 'assets/images/a.jpg', 'Appliances'),
    Product('Shoes 55', 'assets/images/c.jpg', 'Aval Choice'),
    Product('Ladies bag 15', 'assets/images/a.jpg', 'Aval Choice'),
    Product('Watch 3', 'assets/images/e.jpg', 'Aval Choice'),
    Product('Dress blue', 'assets/images/f.jpg', 'Aval Choice'),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: CategoryBar(
              isPromo: widget.isPromo,
              ourChoice: widget.ourChoice,
              categories: categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          ),
          Container(
            color: const Color(0xFFDBDCDD),
            // padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products
                    .where((p) => p.category == _selectedCategory)
                    .length,
                itemBuilder: (context, index) {
                  final product = products
                      .where((p) => p.category == _selectedCategory)
                      .toList()[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemGrey
                                        .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Image.asset(
                                product.imageUrl,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBar extends StatefulWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final bool? isPromo;
  final bool? ourChoice;

  const CategoryBar(
      {super.key,
      required this.categories,
      required this.selectedCategory,
      required this.onCategorySelected,
      this.isPromo,
      this.ourChoice});

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
              whenFalse: TimerDisplay(secondsRemaining: _secondsRemaining),
            ),
          ),
        ],
      ),
    );
  }
}

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

class PromoSection extends StatelessWidget {
  final int secondsRemaining;
  final bool? ourChoice;
  const PromoSection(
      {super.key, required this.secondsRemaining, this.ourChoice});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          width: 151,
          decoration: const BoxDecoration(
            color: CupertinoColors.systemRed,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
            ),
          ),
          child: const Text(
            '-58%',
            style: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ConditionalWidget(
          condition: ourChoice,
          whenTrue: const TitleDisplay(title: "Aval Choice"),
          whenFalse: TimerDisplay(secondsRemaining: secondsRemaining),
        ),
      ],
    );
  }
}

class TimerDisplay extends StatelessWidget {
  final int secondsRemaining;

  const TimerDisplay({super.key, required this.secondsRemaining});

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1939),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(8),
        ),
      ),
      child: Text(
        _formatTime(secondsRemaining),
        style: const TextStyle(
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}

class TitleDisplay extends StatelessWidget {
  final String title;

  const TitleDisplay({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1939),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(8),
        ),
      ),
      child: Text(
        (title),
        style: const TextStyle(
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String category;

  Product(this.name, this.imageUrl, this.category);
}
