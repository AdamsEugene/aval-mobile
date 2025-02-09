// lib/screens/referrals/tabs/leaderboard_tab.dart
import 'package:flutter/cupertino.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return _buildTopReferrers();
                }
                return _buildLeaderboardItem(index);
              },
              childCount: 11, // 1 for top referrers + 10 list items
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopReferrers() {
    return Container(
      height: 280, // Increased height to accommodate all content
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // Align items to bottom
        children: [
          Expanded(child: _buildTopReferrer(2, 'User 2', '2,800', 120)),
          Expanded(child: _buildTopReferrer(1, 'User 1', '3,500', 160)),
          Expanded(child: _buildTopReferrer(3, 'User 3', '2,300', 100)),
        ],
      ),
    );
  }

  Widget _buildTopReferrer(
      int position, String name, String points, double height) {
    return SizedBox(
      height: 280, // Match parent height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min, // Take minimum space needed
        children: [
          Container(
            width: 50, // Slightly reduced size
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFEEAD1),
              shape: BoxShape.circle,
              border: Border.all(
                color: CupertinoColors.activeOrange,
                width: 2,
              ),
            ),
            child: const Icon(
              CupertinoIcons.person_fill,
              color: CupertinoColors.activeOrange,
              size: 24, // Adjusted size
            ),
          ),
          const SizedBox(height: 4), // Reduced spacing
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13, // Slightly smaller font
            ),
          ),
          Text(
            points,
            style: const TextStyle(
              color: CupertinoColors.activeOrange,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4), // Reduced spacing
          Container(
            width: 50, // Match avatar width
            height: height,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [CupertinoColors.activeOrange, Color(0xFFFEEAD1)],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                '#$position',
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFEEAD1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '${index + 3}',
                style: const TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User ${index + 3}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(20 - index)} referrals',
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 12,
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
              color: const Color(0xFFFEEAD1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${2000 - (index * 150)}',
              style: const TextStyle(
                color: CupertinoColors.activeOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
