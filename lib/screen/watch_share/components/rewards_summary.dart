// lib/screens/watch_share/components/rewards_summary.dart
import 'package:flutter/cupertino.dart';

class RewardsSummary extends StatelessWidget {
  final String totalEarned;
  final String videosWatched;
  final String daysStreak;

  const RewardsSummary({
    super.key,
    required this.totalEarned,
    required this.videosWatched,
    required this.daysStreak,
  });

  Widget _buildRewardStat(String label, String value, IconData icon) {
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
    return Row(
      children: [
        Expanded(
          child: _buildRewardStat(
              'Total Earned', totalEarned, CupertinoIcons.bitcoin),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildRewardStat(
              'Videos', videosWatched, CupertinoIcons.play_circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              _buildRewardStat('Streak', daysStreak, CupertinoIcons.flame_fill),
        ),
      ],
    );
  }
}
