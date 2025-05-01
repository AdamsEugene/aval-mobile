// lib/screens/watch_share/components/video_card.dart
import 'package:flutter/cupertino.dart';
import '../video_player_screen.dart';

class VideoCard extends StatelessWidget {
  final String username;
  final String location;
  final String title;
  final String description;
  final String likes;
  final String comments;
  final String reward;
  final String timeAgo;
  final VoidCallback? onTap;

  const VideoCard({
    super.key,
    required this.username,
    required this.location,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
    required this.reward,
    required this.timeAgo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.systemGrey5,
                    border: Border.all(
                      color: CupertinoColors.systemGrey4,
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.person_fill,
                      size: 20,
                      color: CupertinoColors.systemGrey2,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.ellipsis,
                    color: CupertinoColors.black,
                  ),
                  onPressed: () {
                    // Handle more options
                  },
                ),
              ],
            ),
          ),

          // Video Thumbnail
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    username: username,
                    title: title,
                    description: description,
                    likes: likes,
                    comments: comments,
                    reward: reward,
                    isVerified: false,
                  ),
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: const Color(0xFFFEEAD1),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.play_circle_fill,
                      size: 64,
                      color: CupertinoColors.white,
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.bitcoin,
                              size: 14,
                              color: CupertinoColors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              reward,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Engagement Actions
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildEngagementButton(
                  CupertinoIcons.heart,
                  likes,
                ),
                const SizedBox(width: 16),
                _buildEngagementButton(
                  CupertinoIcons.chat_bubble,
                  comments,
                ),
                const SizedBox(width: 16),
                _buildEngagementButton(
                  CupertinoIcons.share,
                  'Share',
                ),
                const Spacer(),
                _buildEngagementButton(
                  CupertinoIcons.bookmark,
                  'Save',
                ),
              ],
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildEngagementButton(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: CupertinoColors.black,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.black,
          ),
        ),
      ],
    );
  }
}
