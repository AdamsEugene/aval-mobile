import 'package:e_commerce_app/widgets/magic_box/all_magic_boxes_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/magic_box/magic_box.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('See All'),
                  onPressed: () {
                    _showAllMagicBoxes(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: boxes.length,
              itemBuilder: (context, index) {
                final box = boxes[index];
                return MagicBox(
                  key: ValueKey('magic_box_$index'),
                  title: box.title,
                  price: box.price,
                  startColor: box.startColor,
                  endColor: box.endColor,
                  onPurchased: () {
                    // Handle purchase completion
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAllMagicBoxes(BuildContext context) {
    // Use CupertinoPageRoute to navigate to a full page instead of a bottom sheet
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => AllMagicBoxesPage(boxes: boxes),
      ),
    );
  }
}


// Magic Box theme class to make implementation easier
class MagicBoxTheme {
  final String title;
  final double price;
  final Color startColor;
  final Color endColor;

  const MagicBoxTheme({
    required this.title,
    required this.price,
    required this.startColor,
    required this.endColor,
  });
}
