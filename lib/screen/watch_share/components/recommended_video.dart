// lib/screens/watch_share/components/recommended_video.dart
import 'package:flutter/cupertino.dart';

class RecommendedVideo extends StatelessWidget {
  final String username;
  final String title;
  final String description;
  final String views;
  final String likes;
  final String timeAgo;
  final String reward;
  final bool isVerified;
  final VoidCallback? onTap;

  const RecommendedVideo({
    super.key,
    required this.username,
    required this.title,
    required this.description,
    required this.views,
    required this.likes,
    required this.timeAgo,
    required this.reward,
    this.isVerified = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Thumbnail
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(8)),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: const Color(0xFFFEEAD1),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.play_circle_fill,
                          size: 42,
                          color: CupertinoColors.white,
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '0:15',
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Reward Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemOrange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.bitcoin,
                          size: 12,
                          color: CupertinoColors.white,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          reward,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username and verification
                    Row(
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            size: 14,
                            color: CupertinoColors.activeBlue,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    // Metrics
                    Row(
                      children: [
                        Text(
                          '$views views',
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 2,
                          height: 2,
                          decoration: const BoxDecoration(
                            color: CupertinoColors.systemGrey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$likes likes',
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 2,
                          height: 2,
                          decoration: const BoxDecoration(
                            color: CupertinoColors.systemGrey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          timeAgo,
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
            ),
            // More options button
            CupertinoButton(
              padding: const EdgeInsets.all(12),
              child: const Icon(
                CupertinoIcons.ellipsis_vertical,
                color: CupertinoColors.systemGrey,
                size: 20,
              ),
              onPressed: () {
                // Handle more options
              },
            ),
          ],
        ),
      ),
    );
  }
}
