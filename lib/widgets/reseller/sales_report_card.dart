// lib/widgets/reseller/sales_report_card.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalesReportCard extends StatelessWidget {
  const SalesReportCard({super.key});

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
                'Sales Report',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                CupertinoIcons.graph_circle,
                color: Color(0xFF05001E),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSalesItem(
            'Today',
            45,
            '\$1,250',
            '+12.5%',
          ),
          _buildDivider(),
          _buildSalesItem(
            'This Week',
            180,
            '\$5,840',
            '+8.2%',
          ),
          _buildDivider(),
          _buildSalesItem(
            'This Month',
            384,
            '\$12,845',
            '+15.3%',
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View Detailed Report'),
                SizedBox(width: 4),
                Icon(
                  CupertinoIcons.right_chevron,
                  size: 16,
                ),
              ],
            ),
            onPressed: () {
              // Navigate to detailed report screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1),
    );
  }

  Widget _buildSalesItem(
    String period,
    int orders,
    String revenue,
    String growth,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              period,
              style: TextStyle(
                color: CupertinoColors.systemGrey.darkColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$orders Orders',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              revenue,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF05001E),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.arrow_up_right,
                  size: 14,
                  color: CupertinoColors.activeGreen,
                ),
                const SizedBox(width: 4),
                Text(
                  growth,
                  style: const TextStyle(
                    color: CupertinoColors.activeGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
