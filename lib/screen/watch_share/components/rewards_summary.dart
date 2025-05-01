// lib/screens/watch_share/components/rewards_summary.dart
import 'package:flutter/cupertino.dart';
import 'rewards_progress_screen.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => RewardsProgressScreen(
              totalEarned: totalEarned,
              videosWatched: videosWatched,
              daysStreak: daysStreak,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'View detailed progress',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 12,
                    color: CupertinoColors.white.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
