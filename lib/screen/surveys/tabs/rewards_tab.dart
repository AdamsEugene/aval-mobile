// lib/screens/surveys/tabs/rewards_tab.dart
import 'package:flutter/cupertino.dart';

class SurveyRewardsTab extends StatelessWidget {
  const SurveyRewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
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
                  color: CupertinoColors.activeOrange.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Earnings',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.bitcoin,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '2,500',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildStat('Surveys\nCompleted', '25'),
                    Container(
                      width: 1,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: CupertinoColors.white.withOpacity(0.3),
                    ),
                    _buildStat('Average\nReward', '100'),
                    Container(
                      width: 1,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: CupertinoColors.white.withOpacity(0.3),
                    ),
                    _buildStat('This\nMonth', '500'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Reward Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildRewardProgress(
                currentPoints: (index + 1) * 500,
                targetPoints: (index + 2) * 500,
                reward: 'Premium ${index + 1}',
                description: 'Complete ${(index + 1) * 5} surveys',
              ),
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CupertinoColors.white.withOpacity(0.8),
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardProgress({
    required int currentPoints,
    required int targetPoints,
    required String reward,
    required String description,
  }) {
    final progress = (currentPoints / targetPoints).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEAD1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.gift_fill,
                  color: CupertinoColors.activeOrange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: progress >= 1.0
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFEEAD1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  progress >= 1.0
                      ? CupertinoIcons.checkmark_circle_fill
                      : CupertinoIcons.lock_fill,
                  size: 20,
                  color: progress >= 1.0
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.activeOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEAD1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        CupertinoColors.activeOrange,
                        Color(0xFFFEEAD1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentPoints / $targetPoints points',
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 12,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
