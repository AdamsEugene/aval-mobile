// lib/screens/watch_share/tabs/history_tab.dart
import 'package:e_commerce_app/screen/watch_share/components/history_item.dart';
import 'package:flutter/cupertino.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: HistoryItem(
                  title: 'Video ${index + 1}',
                  time: 'Watched ${index + 1} days ago',
                  reward: '${(index + 1) * 100} coins earned',
                  onTap: () {
                    // Handle history item tap
                  },
                ),
              ),
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}
