// import 'package:flutter/cupertino.dart';

// import 'dart:async';
// import 'package:e_commerce_app/widgets/common/conditional_widget.dart';

// class ProductCarousel extends StatefulWidget {
//   final bool? isPromo;
//   final bool? ourChoice;

//   const ProductCarousel({super.key, this.isPromo, this.ourChoice});

//   @override
//   ProductCarouselState createState() => ProductCarouselState();
// }

// class ProductCarouselState extends State<ProductCarousel> {
//   String _selectedCategory = 'Appliances';
//   final List<String> categories = ['Appliances', 'Car Parts', 'Toys'];

//   final List<Product> products = [
//     Product('Ladies bag 15', 'assets/images/a.png', 'Fashion'),
//     Product('Shoes 55', 'assets/images/b.png', 'Fashion'),
//     Product('Dress blue', 'assets/images/c.png', 'Fashion'),
//     Product('Watch 3', 'assets/images/d.png', 'Fashion'),
//     Product('Watch 3', 'assets/images/e.png', 'Car Parts'),
//     Product('Shoes 55', 'assets/images/f.png', 'Car Parts'),
//     Product('Dress blue', 'assets/images/g.png', 'Car Parts'),
//     Product('Ladies bag 15', 'assets/images/h.png', 'Car Parts'),
//     Product('Shoes 55', 'assets/images/i.png', 'Toys'),
//     Product('Ladies bag 15', 'assets/images/j.png', 'Toys'),
//     Product('Dress blue', 'assets/images/l.png', 'Toys'),
//     Product('Watch 3', 'assets/images/m.png', 'Toys'),
//     Product('Watch 3', 'assets/images/n.png', 'Appliances'),
//     Product('Shoes 55', 'assets/images/o.png', 'Appliances'),
//     Product('Dress blue', 'assets/images/p.png', 'Appliances'),
//     Product('Ladies bag 15', 'assets/images/q.png', 'Appliances'),
//     Product('Shoes 55', 'assets/images/c.png', 'Aval Choice'),
//     Product('Ladies bag 15', 'assets/images/a.png', 'Aval Choice'),
//     Product('Watch 3', 'assets/images/e.png', 'Aval Choice'),
//     Product('Dress blue', 'assets/images/f.png', 'Aval Choice'),
//   ];

//   final DecorationTween _tween = DecorationTween(
//     begin: BoxDecoration(
//       color: CupertinoColors.white,
//       boxShadow: const <BoxShadow>[],
//       borderRadius: BorderRadius.circular(12),
//     ),
//     end: BoxDecoration(
//       color: CupertinoColors.white,
//       boxShadow: CupertinoContextMenu.kEndBoxShadow,
//       borderRadius: BorderRadius.circular(12),
//     ),
//   );

//   Animation<Decoration> _boxDecorationAnimation(Animation<double> animation) {
//     return _tween.animate(
//       CurvedAnimation(
//         parent: animation,
//         curve: Interval(
//           0.0,
//           CupertinoContextMenu.animationOpensAt,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           CategoryBar(
//             isPromo: widget.isPromo,
//             ourChoice: widget.ourChoice,
//             categories: categories,
//             selectedCategory: _selectedCategory,
//             onCategorySelected: (category) {
//               setState(() {
//                 _selectedCategory = category;
//               });
//             },
//           ),
//           Container(
//             color: const Color(0xFFDBDCDD),
//             child: SizedBox(
//               height: 220,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: products
//                     .where((p) => p.category == _selectedCategory)
//                     .length,
//                 itemBuilder: (context, index) {
//                   final product = products
//                       .where((p) => p.category == _selectedCategory)
//                       .toList()[index];
//                   return Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                     child: SizedBox(
//                       width: 160,
//                       child: CupertinoContextMenu.builder(
//                         actions: [
//                           CupertinoContextMenuAction(
//                             trailingIcon: CupertinoIcons.heart,
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Like'),
//                           ),
//                           CupertinoContextMenuAction(
//                             trailingIcon: CupertinoIcons.share,
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Share'),
//                           ),
//                           CupertinoContextMenuAction(
//                             isDefaultAction: true,
//                             trailingIcon: CupertinoIcons.cart_badge_plus,
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Add to Cart'),
//                           ),
//                           CupertinoContextMenuAction(
//                             trailingIcon: CupertinoIcons.bag,
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Buy Now'),
//                           ),
//                           CupertinoContextMenuAction(
//                             trailingIcon: CupertinoIcons.ellipsis,
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('More'),
//                           ),
//                         ],
//                         builder: (BuildContext context,
//                             Animation<double> animation) {
//                           final Animation<Decoration> boxDecorationAnimation =
//                               _boxDecorationAnimation(animation);
//                           return Container(
//                             decoration: animation.value <
//                                     CupertinoContextMenu.animationOpensAt
//                                 ? boxDecorationAnimation.value
//                                 : null,
//                             child:
//                                 _buildProductItem(context, product, animation),
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildProductItem(
//     BuildContext context, Product product, Animation<double> animation) {
//   final bool isExpanded =
//       animation.value >= CupertinoContextMenu.animationOpensAt;
//   return Container(
//     width: isExpanded ? MediaQuery.of(context).size.width : 160,
//     height: isExpanded ? 300 : 220,
//     decoration: BoxDecoration(
//       color: CupertinoColors.white,
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           child: ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.asset(
//               product.imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             product.name,
//             style: TextStyle(
//               fontSize: isExpanded ? 16 : 14,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// class CategoryBar extends StatefulWidget {
//   final List<String> categories;
//   final String selectedCategory;
//   final Function(String) onCategorySelected;
//   final bool? isPromo;
//   final bool? ourChoice;

//   const CategoryBar({
//     super.key,
//     required this.categories,
//     required this.selectedCategory,
//     required this.onCategorySelected,
//     this.isPromo,
//     this.ourChoice,
//   });

//   @override
//   CategoryBarState createState() => CategoryBarState();
// }

// class CategoryBarState extends State<CategoryBar> {
//   late Timer _timer;
//   int _secondsRemaining = 11 * 3600 + 18 * 60 + 5; // 11:18:05

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_secondsRemaining > 0) {
//           _secondsRemaining--;
//         } else {
//           _timer.cancel();
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 34,
//       decoration: const BoxDecoration(
//         color: Color(0xFFEEEFF1),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12),
//           topRight: Radius.circular(12),
//         ),
//       ),
//       clipBehavior: Clip.hardEdge,
//       child: Row(
//         children: [
//           Expanded(
//             child: CategoryButtons(
//               categories: widget.categories,
//               selectedCategory: widget.selectedCategory,
//               onCategorySelected: widget.onCategorySelected,
//             ),
//           ),
//           ConditionalWidget(
//             condition: widget.isPromo,
//             whenTrue: PromoSection(
//               secondsRemaining: _secondsRemaining,
//               ourChoice: widget.ourChoice,
//             ),
//             whenFalse: ConditionalWidget(
//               condition: widget.ourChoice,
//               whenTrue: const TitleDisplay(title: "Aval Choice"),
//               whenFalse: TimerDisplay(secondsRemaining: _secondsRemaining),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryButtons extends StatelessWidget {
//   final List<String> categories;
//   final String selectedCategory;
//   final Function(String) onCategorySelected;

//   const CategoryButtons({
//     super.key,
//     required this.categories,
//     required this.selectedCategory,
//     required this.onCategorySelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: List.generate(categories.length, (index) {
//         bool isSelected = selectedCategory == categories[index];
//         return Positioned(
//           left: index * 90.0,
//           child: GestureDetector(
//             onTap: () => onCategorySelected(categories[index]),
//             child: Container(
//               width: 96,
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? CupertinoColors.activeOrange
//                     : CupertinoColors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft:
//                       index == 0 ? const Radius.circular(25) : Radius.zero,
//                   topRight: index + 1 == categories.length
//                       ? const Radius.circular(25)
//                       : Radius.zero,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: CupertinoColors.systemGrey.withOpacity(0.5),
//                     spreadRadius: 0,
//                     blurRadius: 4,
//                     offset: const Offset(2, 4),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//                   child: Text(
//                     categories[index],
//                     style: TextStyle(
//                       color: isSelected
//                           ? CupertinoColors.white
//                           : CupertinoColors.black,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).reversed.toList(),
//     );
//   }
// }

// class PromoSection extends StatelessWidget {
//   final int secondsRemaining;
//   final bool? ourChoice;
//   const PromoSection(
//       {super.key, required this.secondsRemaining, this.ourChoice});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.centerRight,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           width: 151,
//           decoration: const BoxDecoration(
//             color: CupertinoColors.systemRed,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//             ),
//           ),
//           child: const Text(
//             '-58%',
//             style: TextStyle(
//               color: CupertinoColors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         ConditionalWidget(
//           condition: ourChoice,
//           whenTrue: const TitleDisplay(title: "Aval Choice"),
//           whenFalse: TimerDisplay(secondsRemaining: secondsRemaining),
//         ),
//       ],
//     );
//   }
// }

// class TimerDisplay extends StatelessWidget {
//   final int secondsRemaining;

//   const TimerDisplay({super.key, required this.secondsRemaining});

//   String _formatTime(int seconds) {
//     int hours = seconds ~/ 3600;
//     int minutes = (seconds % 3600) ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: const BoxDecoration(
//         color: Color(0xFF1C1939),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(8),
//         ),
//       ),
//       child: Text(
//         _formatTime(secondsRemaining),
//         style: const TextStyle(
//           color: CupertinoColors.white,
//         ),
//       ),
//     );
//   }
// }

// class TitleDisplay extends StatelessWidget {
//   final String title;

//   const TitleDisplay({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: const BoxDecoration(
//         color: Color(0xFF1C1939),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(8),
//         ),
//       ),
//       child: Text(
//         (title),
//         style: const TextStyle(
//           color: CupertinoColors.white,
//         ),
//       ),
//     );
//   }
// }

// class Product {
//   final String name;
//   final String imageUrl;
//   final String category;

//   Product(this.name, this.imageUrl, this.category);
// }
