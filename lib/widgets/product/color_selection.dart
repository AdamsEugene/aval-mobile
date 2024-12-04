import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class ColorSelection extends StatefulWidget {
  final Product product;
  const ColorSelection({super.key, required this.product});

  @override
  State<ColorSelection> createState() => _ColorSelectionState();
}

class _ColorSelectionState extends State<ColorSelection> {
  int selectedIndex = 0;

  Widget _buildColorOption(int index, String imageUrl) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 64,
        height: 64,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? const Color(0xFFFDC202) : const Color(0xFFEEEEEE),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: CupertinoColors.systemGrey6,
                child: const Center(
                  child: Icon(
                    CupertinoIcons.photo,
                    size: 24,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.product.images;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Color',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width, // Take full width
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16), // Added horizontal padding
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Spread items
                children: List.generate(
                  images.isEmpty ? 1 : images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                        right: 12), // Added spacing between items
                    child: _buildColorOption(
                      index,
                      images.isEmpty ? widget.product.thumbnail : images[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
