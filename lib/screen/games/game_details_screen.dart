// Updated lib/screens/games/game_details_screen.dart
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:flutter/cupertino.dart';
import 'components/game_achievements.dart';
import 'game_screen.dart';

class GameDetailsScreen extends StatelessWidget {
  final String gameTitle;

  const GameDetailsScreen({
    super.key,
    required this.gameTitle,
  });

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      withBack: true,
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            gameTitle,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.bell,
          onPressed: () {
            // Handle notifications
          },
        ),
        HeaderAction(
          icon: CupertinoIcons.settings,
          onPressed: () {
            // Handle settings
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final achievements = [
      const Achievement(
        title: 'First Win',
        description: 'Win your first game',
        points: 100,
        isUnlocked: true,
      ),
      const Achievement(
        title: 'Speed Runner',
        description: 'Complete the game in under 2 minutes',
        points: 200,
        progress: 0.6,
      ),
      const Achievement(
        title: 'Perfect Score',
        description: 'Score 1000 points in a single game',
        points: 500,
        progress: 0.3,
      ),
    ];

    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text(gameTitle),
      // ),
      backgroundColor: const Color(0xFFEEEFF1),
      child: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                _buildHeader(context),
                // Game Banner
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFFF9966),
                          const Color(0xFFFF5E62).withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            CupertinoIcons.game_controller_solid,
                            size: 64,
                            color: CupertinoColors.white.withOpacity(0.5),
                          ),
                        ),
                        // Play button overlay
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: CupertinoColors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.play_fill,
                              size: 40,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Game Info
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Action Game',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F3FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: CupertinoColors.activeOrange,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      color: CupertinoColors.activeOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'About this game',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Experience an exciting adventure game with multiple challenges and rewards.',
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GameAchievements(
                          gameTitle: gameTitle,
                          achievements: achievements,
                        ),
                        // Extra padding at bottom for the floating button
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Floating play button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: CupertinoColors.activeOrange,
              borderRadius: BorderRadius.circular(16),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => GameScreen(gameTitle: gameTitle),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.play_fill),
                  SizedBox(width: 8),
                  Text(
                    'Play Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
