// lib/screens/games/components/game_achievements.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameAchievements extends StatelessWidget {
  final String gameTitle;
  final List<Achievement> achievements;

  const GameAchievements({
    super.key,
    required this.gameTitle,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Achievements - $gameTitle',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: achievements.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final achievement = achievements[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: achievement.isUnlocked
                          ? const Color(0xFFF5F3FF)
                          : CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      achievement.isUnlocked
                          ? CupertinoIcons.star_fill
                          : CupertinoIcons.lock_fill,
                      color: achievement.isUnlocked
                          ? CupertinoColors.activeOrange
                          : CupertinoColors.systemGrey,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          achievement.description,
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 14,
                          ),
                        ),
                        if (!achievement.isUnlocked) ...[
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: achievement.progress,
                              backgroundColor: const Color(0xFFF5F3FF),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                CupertinoColors.activeOrange,
                              ),
                              minHeight: 4,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: achievement.isUnlocked
                          ? const Color(0xFFF5F3FF)
                          : CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${achievement.points}',
                      style: TextStyle(
                        color: achievement.isUnlocked
                            ? CupertinoColors.activeOrange
                            : CupertinoColors.systemGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class Achievement {
  final String title;
  final String description;
  final int points;
  final bool isUnlocked;
  final double progress;

  const Achievement({
    required this.title,
    required this.description,
    required this.points,
    this.isUnlocked = false,
    this.progress = 0.0,
  });
}
