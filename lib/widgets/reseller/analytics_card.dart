// lib/widgets/reseller/analytics_card.dart
import 'package:flutter/cupertino.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({super.key});

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
                'Analytics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                CupertinoIcons.chart_bar_fill,
                color: Color(0xFF05001E),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticItem(
                  icon: CupertinoIcons.money_dollar_circle,
                  label: 'Revenue',
                  value: '\$12,845',
                  change: '+8.2%',
                  positive: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildAnalyticItem(
                  icon: CupertinoIcons.shopping_cart,
                  label: 'Orders',
                  value: '384',
                  change: '+12.5%',
                  positive: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticItem({
    required IconData icon,
    required String label,
    required String value,
    required String change,
    required bool positive,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF05001E)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: CupertinoColors.systemGrey.darkColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                positive
                    ? CupertinoIcons.arrow_up_right
                    : CupertinoIcons.arrow_down_right,
                size: 16,
                color: positive
                    ? CupertinoColors.activeGreen
                    : CupertinoColors.destructiveRed,
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  color: positive
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.destructiveRed,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
