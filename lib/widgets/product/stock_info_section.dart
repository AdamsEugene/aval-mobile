import 'package:flutter/cupertino.dart';

class StockInfoSection extends StatelessWidget {
  const StockInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // In Stock
          Expanded(
            child: Row(
              children: [
                const Text(
                  'IN STOCK ',
                  style: TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '2500',
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Sold
          Expanded(
            child: Row(
              children: [
                const Text(
                  'SOLD ',
                  style: TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '15000+',
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Certified Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFDC202),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  size: 16,
                  color: CupertinoColors.white,
                ),
                SizedBox(width: 4),
                Text(
                  'Certified Refurb',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
