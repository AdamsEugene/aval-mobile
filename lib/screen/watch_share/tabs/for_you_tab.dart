// lib/screens/watch_share/tabs/for_you_tab.dart
import 'package:e_commerce_app/screen/watch_share/components/recommended_video.dart';
import 'package:flutter/cupertino.dart';

class ForYouTab extends StatelessWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // const SliverToBoxAdapter(
        //   child: Padding(
        //     padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        //     child: Text(
        //       'Recommended for you',
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RecommendedVideo(
                  username: 'creator_${index + 1}',
                  title: 'Recommended Video ${index + 1}',
                  description: 'Trending in your network',
                  views: '${(index + 1) * 10}K',
                  likes: '${(index + 1) * 1000}',
                  timeAgo: '${index + 1}h ago',
                  reward: '${(index + 1) * 150}',
                  isVerified: index % 3 == 0,
                  onTap: () {
                    // Handle video tap
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
