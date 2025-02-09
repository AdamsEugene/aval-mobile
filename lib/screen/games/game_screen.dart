// lib/screens/games/game_screen.dart
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:flutter/cupertino.dart';

class GameScreen extends StatefulWidget {
  final String gameTitle;

  const GameScreen({
    super.key,
    required this.gameTitle,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0;

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      withBack: true,
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            widget.gameTitle,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.bitcoin,
          onPressed: () {
            // Show score details
          },
          badgeCount: _score,
        ),
        HeaderAction(
          icon: CupertinoIcons.pause,
          onPressed: () {
            // Handle pause
            showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text('Game Paused'),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Resume'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close action sheet
                      setState(() {
                        _score = 0;
                      });
                    },
                    child: const Text('Restart'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close action sheet
                      Navigator.pop(context); // Exit game
                    },
                    isDestructiveAction: true,
                    child: const Text('Exit Game'),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Score Display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.bitcoin,
                            color: CupertinoColors.activeOrange,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _score.toString(),
                            style: const TextStyle(
                              color: CupertinoColors.activeOrange,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Game content
                    const Icon(
                      CupertinoIcons.game_controller_solid,
                      size: 100,
                      color: CupertinoColors.activeOrange,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Game in Progress',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Demo controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          color: CupertinoColors.activeOrange,
                          onPressed: () {
                            setState(() {
                              _score += 100;
                            });
                          },
                          child: const Text('Score +100'),
                        ),
                        const SizedBox(width: 16),
                        CupertinoButton(
                          color: CupertinoColors.systemGrey2,
                          onPressed: () {
                            setState(() {
                              _score = 0;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
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
