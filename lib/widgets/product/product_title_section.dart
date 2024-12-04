import 'package:e_commerce_app/widgets/product/product_info_drawer.dart';
import 'package:flutter/cupertino.dart';

class ProductTitleSection extends StatelessWidget {
  const ProductTitleSection({super.key});

  Widget _buildRatingStars(double rating) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          const color = Color(0xFFFDC202);
          if (index < rating.floor()) {
            return const Icon(CupertinoIcons.star_fill, size: 16, color: color);
          }
          if (index == rating.floor() && rating % 1 > 0) {
            return const Icon(CupertinoIcons.star_lefthalf_fill,
                size: 16, color: color);
          }
          return const Icon(CupertinoIcons.star, size: 16, color: color);
        }),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(
            color: Color(0xFFFDC202),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Ladies bag',
                  style: TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildRatingStars(4.9),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Internal features: Slip pocket with gold lip, zipped pocket, slip pocket with CARDS embossed, pocket with PHONE embossed, pocket with EARPHONES embossed, pen loop, magnetic closure',
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  ProductInfoDrawer.show(context);
                },
                child: const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: Color(0xFF05001E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
