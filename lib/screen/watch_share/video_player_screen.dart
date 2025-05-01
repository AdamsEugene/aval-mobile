import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String username;
  final String title;
  final String description;
  final String likes;
  final String comments;
  final String reward;
  final bool isVerified;

  const VideoPlayerScreen({
    super.key,
    required this.username,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
    required this.reward,
    this.isVerified = false,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = true;
  bool _isMuted = false;
  bool _isLiked = false;
  bool _isSaved = false;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            // Video Content
            Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Container(
                  color: const Color(0xFFFEEAD1),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Video placeholder
                        if (!_isPlaying)
                          const Icon(
                            CupertinoIcons.play_circle_fill,
                            size: 72,
                            color: CupertinoColors.white,
                          ),
                        
                        // Video progress bar
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: (_progress * 100).toInt(),
                                  child: Container(
                                    color: CupertinoColors.activeOrange,
                                  ),
                                ),
                                Expanded(
                                  flex: 100 - (_progress * 100).toInt(),
                                  child: Container(
                                    color: CupertinoColors.white.withOpacity(0.5),
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
            ),
            
            // Top controls
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      _isMuted ? CupertinoIcons.volume_mute : CupertinoIcons.volume_up,
                      color: CupertinoColors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isMuted = !_isMuted;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            // Right side actions
            Positioned(
              right: 16,
              bottom: 120,
              child: Column(
                children: [
                  _buildActionButton(
                    icon: _isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    label: widget.likes,
                    color: _isLiked ? CupertinoColors.systemRed : CupertinoColors.white,
                    onTap: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: CupertinoIcons.chat_bubble,
                    label: widget.comments,
                    onTap: () {
                      _showCommentsSheet(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: CupertinoIcons.share,
                    label: 'Share',
                    onTap: () {
                      _showShareOptions(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: _isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                    label: 'Save',
                    color: _isSaved ? CupertinoColors.activeBlue : CupertinoColors.white,
                    onTap: () {
                      setState(() {
                        _isSaved = !_isSaved;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildRewardButton(context),
                ],
              ),
            ),
            
            // Bottom info
            Positioned(
              left: 16,
              right: 72,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CupertinoColors.systemGrey5,
                          border: Border.all(
                            color: CupertinoColors.white,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.person_fill,
                            size: 24,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.username,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (widget.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          CupertinoIcons.checkmark_seal_fill,
                          size: 16,
                          color: CupertinoColors.activeBlue,
                        ),
                      ],
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoColors.activeOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Follow',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Handle follow
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 14,
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = CupertinoColors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle reward
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.black,
              border: Border.all(
                color: CupertinoColors.systemYellow,
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.bitcoin,
                size: 24,
                color: CupertinoColors.systemYellow,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.reward,
            style: const TextStyle(
              color: CupertinoColors.systemYellow,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.xmark),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CupertinoColors.systemGrey5,
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.person_fill,
                              size: 20,
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'This is a great video! I really enjoyed watching it.',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '${index + 1}h ago',
                                    style: const TextStyle(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Reply',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      placeholder: 'Add a comment...',
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    CupertinoIcons.paperplane_fill,
                    color: CupertinoColors.activeBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share to',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: const [
                  _ShareOption(
                    icon: CupertinoIcons.chat_bubble_fill,
                    label: 'Messages',
                    color: CupertinoColors.activeGreen,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.mail_solid,
                    label: 'Mail',
                    color: CupertinoColors.systemBlue,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.at,
                    label: 'Instagram',
                    color: CupertinoColors.systemPurple,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.t_bubble_fill,
                    label: 'Twitter',
                    color: CupertinoColors.activeBlue,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.f_cursive,
                    label: 'Facebook',
                    color: CupertinoColors.systemIndigo,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.paperclip,
                    label: 'Copy Link',
                    color: CupertinoColors.systemGrey,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.arrow_down_circle_fill,
                    label: 'Save Video',
                    color: CupertinoColors.systemRed,
                  ),
                  _ShareOption(
                    icon: CupertinoIcons.share,
                    label: 'More',
                    color: CupertinoColors.systemGrey2,
                  ),
                ],
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              borderRadius: BorderRadius.circular(8),
              color: CupertinoColors.systemGrey6,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 