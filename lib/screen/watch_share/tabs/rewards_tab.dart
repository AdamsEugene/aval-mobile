// lib/screens/watch_share/tabs/rewards_tab.dart
import 'package:e_commerce_app/screen/watch_share/components/reward_card.dart';
import 'package:e_commerce_app/screen/watch_share/components/rewards_summary.dart';
import 'package:flutter/cupertino.dart';

class RewardsTab extends StatelessWidget {
  const RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Rewards Summary Section
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                        color: const Color(0xFFFF5E62).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const RewardsSummary(
                    totalEarned: '5,000',
                    videosWatched: '25',
                    daysStreak: '7',
                  ),
                ),
              ],
            ),
          ),
        ),

        // Available Rewards Section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Available Rewards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => RewardCard(
                title: 'Premium Pack ${index + 1}',
                coins: '${(index + 1) * 500}',
                description: 'Unlock exclusive content',
                progress: (index + 1) * 0.2,
                isLocked: index > 2,
                onTap: () {
                  // Handle reward tap
                },
              ),
              childCount: 6,
            ),
          ),
        ),
      ],
    );
  }
}
