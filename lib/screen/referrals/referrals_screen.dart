// lib/screens/referrals/referrals_screen.dart
import 'package:e_commerce_app/screen/referrals/tabs/invite_tab.dart';
import 'package:e_commerce_app/screen/referrals/tabs/leaderboard_tab.dart';
import 'package:e_commerce_app/screen/referrals/tabs/overview_tab.dart';
import 'package:e_commerce_app/screen/referrals/tabs/rewards_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class ReferralsScreen extends StatefulWidget {
  const ReferralsScreen({super.key});

  @override
  State<ReferralsScreen> createState() => _ReferralsScreenState();
}

class _ReferralsScreenState extends State<ReferralsScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.graph_square,
      label: 'Overview',
      data: 'overview',
    ),
    CustomTabItem(
      icon: CupertinoIcons.person_add,
      label: 'Invite',
      data: 'invite',
    ),
    CustomTabItem(
      icon: CupertinoIcons.gift,
      label: 'Rewards',
      data: 'rewards',
    ),
    CustomTabItem(
      icon: CupertinoIcons.chart_bar,
      label: 'Ranking',
      data: 'leaderboard',
    ),
  ];

  String _getHeaderTitle() {
    switch (_selectedTabIndex) {
      case 0:
        return 'Referral Program';
      case 1:
        return 'Invite Friends';
      case 2:
        return 'Referral Rewards';
      case 3:
        return 'Top Referrers';
      default:
        return 'Referral Program';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    switch (_selectedTabIndex) {
      case 0: // Overview Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.info_circle,
            onPressed: () {
              // Show program info
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.bell,
            onPressed: () {
              // Show notifications
            },
          ),
        ];
      case 1: // Invite Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.share,
            onPressed: () {
              // Share referral code
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.qrcode,
            onPressed: () {
              // Show QR code
            },
          ),
        ];
      case 2: // Rewards Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.gift,
            onPressed: () {
              // Show rewards catalog
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.time,
            onPressed: () {
              // Show rewards history
            },
          ),
        ];
      case 3: // Leaderboard Tab
        return [
          HeaderAction(
            icon: CupertinoIcons.arrow_up_arrow_down,
            onPressed: () {
              // Sort leaderboard
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.calendar,
            onPressed: () {
              // Change time period
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
      if (_bottomNavItems[index].data == 'overview') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'invite') {
        _selectedTabIndex = 1;
      } else if (_bottomNavItems[index].data == 'rewards') {
        _selectedTabIndex = 2;
      } else if (_bottomNavItems[index].data == 'leaderboard') {
        _selectedTabIndex = 3;
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
                        OverviewTab(),
                        InviteTab(),
                        ReferralRewardsTab(),
                        LeaderboardTab(),
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
