// lib/screens/referrals/components/referral_stats_card.dart
import 'package:flutter/cupertino.dart';

class ReferralStatsCard extends StatelessWidget {
  final String totalEarned;
  final String referralsCount;
  final String conversionRate;

  const ReferralStatsCard({
    super.key,
    required this.totalEarned,
    required this.referralsCount,
    required this.conversionRate,
  });

  Widget _buildStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: CupertinoColors.white,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: CupertinoColors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF9966),
            Color(0xFFFF5E62),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9966).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStat(
                'Total Earned', totalEarned, CupertinoIcons.money_dollar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStat(
                'Referrals', referralsCount, CupertinoIcons.person_2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStat('Success Rate', conversionRate,
                CupertinoIcons.chart_bar_alt_fill),
          ),
        ],
      ),
    );
  }
}
