import 'package:e_commerce_app/widgets/magic_box/all_magic_boxes_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widgets/magic_box/magic_box.dart';

class MagicBoxTheme {
  final String title;
  final double price;
  final Color startColor;
  final Color endColor;
  final int itemCount; // Added item count parameter

  const MagicBoxTheme({
    required this.title,
    required this.price,
    required this.startColor,
    required this.endColor,
    this.itemCount = 1, // Default to 1 item
  });
}

class MagicBoxCarousel extends StatelessWidget {
  final String title;
  final List<MagicBoxTheme> boxes;

  const MagicBoxCarousel({
    super.key,
    required this.title,
    required this.boxes,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => AllMagicBoxesPage(boxes: boxes),
                      ),
                    );
                  },
                  child: Text(
                    'Find your surprise!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: boxes.length,
              itemBuilder: (context, index) {
                final box = boxes[index];
                return MagicBox(
                  title: box.title,
                  price: box.price,
                  startColor: box.startColor,
                  endColor: box.endColor,
                  itemCount: box.itemCount, // Pass the item count to MagicBox
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
