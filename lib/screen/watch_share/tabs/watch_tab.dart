// lib/screens/watch_share/tabs/watch_tab.dart
import 'package:flutter/cupertino.dart';
import '../components/video_card.dart';

class WatchTab extends StatelessWidget {
  const WatchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => VideoCard(
              username: 'user_${index + 1}',
              location: 'Location ${index + 1}',
              title: 'Video ${index + 1}',
              description: 'Check out this amazing video! #trending #viral',
              likes: '${(index + 1) * 1000}',
              comments: '${(index + 1) * 100}',
              reward: '${(index + 1) * 100}',
              timeAgo: '${index + 1}h ago',
              onTap: () {
                // Handle video tap
              },
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
