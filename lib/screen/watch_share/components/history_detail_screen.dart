import 'package:flutter/cupertino.dart';
import '../video_player_screen.dart';

class HistoryDetailScreen extends StatelessWidget {
  final String title;
  final String watchDate;
  final String reward;
  final List<String> relatedVideos;

  const HistoryDetailScreen({
    super.key,
    required this.title,
    required this.watchDate,
    required this.reward,
    this.relatedVideos = const [],
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Watch History'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Preview
              Container(
                width: double.infinity,
                height: 240,
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
                      bottom: 16,
                      right: 16,
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        color: CupertinoColors.activeOrange,
                        borderRadius: BorderRadius.circular(20),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                username: 'Creator',
                                title: title,
                                description: 'Video you watched previously',
                                likes: '2.5K',
                                comments: '100',
                                reward: reward,
                                isVerified: true,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Watch Again',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Video Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.time,
                          size: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          watchDate,
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.bitcoin,
                          size: 16,
                          color: CupertinoColors.activeOrange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          reward,
                          style: const TextStyle(
                            color: CupertinoColors.activeOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: CupertinoColors.systemGrey5,
                    ),
                    const SizedBox(height: 16),
                    
                    // Watch Stats
                    const Text(
                      'Watch Stats',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildStatItem(
                          icon: CupertinoIcons.time,
                          label: 'Duration',
                          value: '5:32',
                        ),
                        _buildStatItem(
                          icon: CupertinoIcons.eye,
                          label: 'Watched',
                          value: '100%',
                        ),
                        _buildStatItem(
                          icon: CupertinoIcons.calendar,
                          label: 'Added',
                          value: 'Jun 12',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Related Videos
                    const Text(
                      'You Might Also Like',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _buildRelatedVideoItem(
                            context,
                            'Related Video ${index + 1}',
                            '${(index + 1) * 100}',
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(12),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.trash,
                                    size: 18,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Remove',
                                    style: TextStyle(
                                      color: CupertinoColors.systemGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              _showRemoveConfirmation(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: CupertinoColors.activeBlue,
                            borderRadius: BorderRadius.circular(12),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.share,
                                    size: 18,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              // Show share options
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: CupertinoColors.activeBlue,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedVideoItem(BuildContext context, String title, String reward) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => VideoPlayerScreen(
              username: 'Creator',
              title: title,
              description: 'Related video based on your watch history',
              likes: '1.2K',
              comments: '50',
              reward: reward,
              isVerified: false,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEEAD1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.play_circle_fill,
                      color: CupertinoColors.white,
                      size: 36,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.bitcoin,
                          size: 10,
                          color: CupertinoColors.white,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          reward,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '2.5k views • 3d ago',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 12,
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

  void _showRemoveConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Remove from History'),
        content: const Text(
          'Are you sure you want to remove this video from your watch history?'
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
} 