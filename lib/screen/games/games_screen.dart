// lib/screens/games/games_screen.dart
import 'package:e_commerce_app/screen/games/tabs/achievements_tab.dart';
import 'package:e_commerce_app/screen/games/tabs/featured_tab.dart';
import 'package:e_commerce_app/screen/games/tabs/rewards_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.game_controller,
      label: 'Games',
      data: 'games',
    ),
    CustomTabItem(
      icon: CupertinoIcons.tortoise_fill,
      label: 'Achievements',
      data: 'achievements',
    ),
    CustomTabItem(
      icon: CupertinoIcons.gift,
      label: 'Rewards',
      data: 'rewards',
    ),
  ];

  String _getHeaderTitle() {
    switch (_selectedTabIndex) {
      case 0:
        return 'Play & Earn';
      case 1:
        return 'Achievements';
      case 2:
        return 'Game Rewards';
      default:
        return 'Games';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    switch (_selectedTabIndex) {
      case 0:
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Handle search
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.star,
            onPressed: () {
              // Handle favorites
            },
          ),
        ];
      case 1:
        return [
          HeaderAction(
            icon: CupertinoIcons.slider_horizontal_3,
            onPressed: () {
              // Handle filters
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.share,
            onPressed: () {
              // Handle share achievements
            },
          ),
        ];
      case 2:
        return [
          HeaderAction(
            icon: CupertinoIcons.info_circle,
            onPressed: () {
              // Show rewards info
            },
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            _getHeaderTitle(),
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: _getHeaderActions(),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
      if (_bottomNavItems[index].data == 'games') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'achievements') {
        _selectedTabIndex = 1;
      } else if (_bottomNavItems[index].data == 'rewards') {
        _selectedTabIndex = 2;
      }
    });

    if (_bottomNavItems[index].data == 'back') {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: CustomScrollView(
                slivers: [
                  _buildHeader(context),
                  SliverFillRemaining(
                    child: IndexedStack(
                      index: _selectedTabIndex,
                      children: const [
                        FeaturedGamesTab(),
                        AchievementsTab(),
                        GameRewardsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoTabBar(
            backgroundColor: const Color(0xFF05001E),
            activeColor: CupertinoColors.white,
            inactiveColor: CupertinoColors.systemGrey,
            currentIndex: _selectedNavIndex,
            onTap: _handleBottomNavTap,
            items: _bottomNavItems
                .map((item) => item.toBottomNavigationBarItem())
                .toList(),
          ),
        ],
      ),
    );
  }
}
