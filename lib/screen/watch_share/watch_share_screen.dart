import 'package:e_commerce_app/screen/watch_share/tabs/for_you_tab.dart';
import 'package:e_commerce_app/screen/watch_share/tabs/history_tab.dart';
import 'package:e_commerce_app/screen/watch_share/tabs/rewards_tab.dart';
import 'package:e_commerce_app/screen/watch_share/tabs/watch_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class WatchShareScreen extends StatefulWidget {
  const WatchShareScreen({super.key});

  @override
  State<WatchShareScreen> createState() => _WatchShareScreenState();
}

class _WatchShareScreenState extends State<WatchShareScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.play_circle,
      label: 'Watch',
      data: 'watch',
    ),
    CustomTabItem(
      icon: CupertinoIcons.heart,
      label: 'For You',
      data: 'for_you',
    ),
    CustomTabItem(
      icon: CupertinoIcons.star,
      label: 'Rewards',
      data: 'rewards',
    ),
    CustomTabItem(
      icon: CupertinoIcons.clock,
      label: 'History',
      data: 'history',
    ),
  ];

  String _getHeaderTitle() {
    switch (_selectedTabIndex) {
      case 0:
        return 'Watch & Share';
      case 1:
        return 'Recommended';
      case 2:
        return 'Your Rewards';
      case 3:
        return 'Watch History';
      default:
        return 'Watch & Share';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    switch (_selectedTabIndex) {
      case 0: // Watch Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Handle search
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.bell_fill,
            onPressed: () {
              // Handle notifications
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.person_crop_circle,
            onPressed: () {
              // Handle profile
            },
          ),
        ];
      case 1: // For You Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Handle search
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.slider_horizontal_3,
            onPressed: () {
              // Handle filters
            },
          ),
        ];
      case 2: // Rewards Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.gift,
            onPressed: () {
              // Handle rewards redemption
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.info_circle,
            onPressed: () {
              // Handle rewards info
            },
          ),
        ];
      case 3: // History Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Handle search
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.trash,
            onPressed: () {
              // Handle clear history
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
      // Update the tab index based on the navigation item
      if (_bottomNavItems[index].data == 'watch') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'for_you') {
        _selectedTabIndex = 1;
      } else if (_bottomNavItems[index].data == 'rewards') {
        _selectedTabIndex = 2;
      } else if (_bottomNavItems[index].data == 'history') {
        _selectedTabIndex = 3;
      }
    });

    switch (_bottomNavItems[index].data) {
      case 'back':
        Navigator.of(context).pop();
        break;
      case 'like':
        // Handle like action
        break;
      case 'share':
        // Handle share action
        break;
      case 'save':
        // Handle save action
        break;
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
                        WatchTab(),
                        ForYouTab(),
                        RewardsTab(),
                        HistoryTab(),
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
