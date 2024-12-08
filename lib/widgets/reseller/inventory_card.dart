// lib/widgets/reseller/inventory_card.dart
import 'package:flutter/cupertino.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Inventory',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                CupertinoIcons.cube_box,
                color: Color(0xFF05001E),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInventoryItem(
            'T-Shirts',
            150,
            200,
            CupertinoColors.activeGreen,
          ),
          const SizedBox(height: 12),
          _buildInventoryItem(
            'Jeans',
            45,
            100,
            CupertinoColors.systemYellow,
          ),
          const SizedBox(height: 12),
          _buildInventoryItem(
            'Shoes',
            12,
            100,
            CupertinoColors.destructiveRed,
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View All Inventory'),
                SizedBox(width: 4),
                Icon(
                  CupertinoIcons.right_chevron,
                  size: 16,
                ),
              ],
            ),
            onPressed: () {
              // Navigate to inventory screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(
    String name,
    int current,
    int total,
    Color statusColor,
  ) {
    final percentage = (current / total * 100).clamp(0, 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$current/$total',
              style: TextStyle(
                color: CupertinoColors.systemGrey.darkColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
