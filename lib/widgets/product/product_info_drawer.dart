import 'package:flutter/cupertino.dart';

class ProductInfoDrawer extends StatelessWidget {
  const ProductInfoDrawer({super.key});

  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const ProductInfoDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF050311),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Product Information',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Internal Features',
                    'Internal features: Slip pocket with gold lip, zipped pocket, slip pocket with CARDS embossed, pocket with PHONE embossed, pocket with EARPHONES embossed, pen loop, magnetic closure',
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Material & Care',
                    'Made from premium leather\nWipe with a clean, dry cloth\nStore in a dust bag when not in use\nAvoid exposure to direct sunlight',
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Dimensions',
                    'Height: 25cm\nWidth: 35cm\nDepth: 12cm\nStrap drop: 55cm',
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Additional Information',
                    'Comes with a detachable shoulder strap\nGold-tone hardware\nFully lined interior\nZip-top closure\nDust bag included',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF05001E),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: const Color(0xFF05001E).withOpacity(0.6),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
