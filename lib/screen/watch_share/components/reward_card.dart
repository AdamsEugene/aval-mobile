// lib/screens/watch_share/components/reward_card.dart
import 'package:flutter/cupertino.dart';
import 'reward_redemption_screen.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final String coins;
  final String description;
  final double progress;
  final bool isLocked;
  final VoidCallback? onTap;

  const RewardCard({
    super.key,
    required this.title,
    required this.coins,
    required this.description,
    this.progress = 0.0,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => RewardRedemptionScreen(
              title: title,
              coins: coins,
              description: description,
              progress: progress,
              isLocked: isLocked,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Reward Icon Container
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isLocked
                      ? [
                          CupertinoColors.systemGrey4,
                          CupertinoColors.systemGrey3,
                        ]
                      : [
                          const Color(0xFFFFA53E),
                          const Color(0xFFFF7643),
                        ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    CupertinoIcons.gift_fill,
                    size: 48,
                    color: isLocked
                        ? CupertinoColors.systemGrey
                        : CupertinoColors.white,
                  ),
                  if (isLocked)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        CupertinoIcons.lock_fill,
                        size: 20,
                        color: CupertinoColors.white.withOpacity(0.8),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.bitcoin,
                          size: 16,
                          color: isLocked
                              ? CupertinoColors.systemGrey
                              : const Color(0xFFFF7643),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          coins,
                          style: TextStyle(
                            color: isLocked
                                ? CupertinoColors.systemGrey
                                : const Color(0xFFFF7643),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Progress Bar
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isLocked
                                  ? [
                                      CupertinoColors.systemGrey3,
                                      CupertinoColors.systemGrey2,
                                    ]
                                  : [
                                      const Color(0xFFFFA53E),
                                      const Color(0xFFFF7643),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
