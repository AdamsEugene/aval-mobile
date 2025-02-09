// lib/screens/surveys/tabs/completed_tab.dart
import 'package:flutter/cupertino.dart';

class CompletedSurveysTab extends StatelessWidget {
  const CompletedSurveysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Stats Summary
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
                  child: Row(
                    children: [
                      Expanded(child: _buildStatItem('Total\nCompleted', '25')),
                      _buildDivider(),
                      Expanded(child: _buildStatItem('This\nMonth', '8')),
                      _buildDivider(),
                      Expanded(
                          child: _buildStatItem('Earned\nPoints', '2,500')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Completed Surveys List
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCompletedSurvey(
                title: 'Survey ${index + 1}',
                date: 'March ${index + 1}, 2024',
                reward: '${(index + 1) * 100}',
                category: index % 2 == 0 ? 'Product' : 'Service',
              ),
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
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

  Widget _buildDivider() {
    return const SizedBox(width: 12);
  }

  Widget _buildCompletedSurvey({
    required String title,
    required String date,
    required String reward,
    required String category,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle survey details tap
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFEEAD1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: CupertinoColors.activeOrange,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.bitcoin,
                    size: 14,
                    color: CupertinoColors.activeOrange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    reward,
                    style: const TextStyle(
                      color: CupertinoColors.activeOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
