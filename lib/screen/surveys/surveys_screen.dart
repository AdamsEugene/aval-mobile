// lib/screens/surveys/surveys_screen.dart
import 'package:e_commerce_app/screen/surveys/tabs/available_tab.dart';
import 'package:e_commerce_app/screen/surveys/tabs/completed_tab.dart';
import 'package:e_commerce_app/screen/surveys/tabs/rewards_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({super.key});

  @override
  State<SurveysScreen> createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.doc_text,
      label: 'Available',
      data: 'available',
    ),
    CustomTabItem(
      icon: CupertinoIcons.checkmark_circle,
      label: 'Completed',
      data: 'completed',
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
        return 'Available';
      case 1:
        return 'Completed';
      case 2:
        return 'Rewards';
      default:
        return 'Surveys';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    switch (_selectedTabIndex) {
      case 0:
        return [
          HeaderAction(
            icon: CupertinoIcons.slider_horizontal_3,
            onPressed: () {
              // Handle filters
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.bell,
            onPressed: () {
              // Handle notifications
            },
          ),
        ];
      case 1:
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Handle search
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.calendar,
            onPressed: () {
              // Handle date filter
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
      if (_bottomNavItems[index].data == 'available') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'completed') {
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
                        AvailableSurveysTab(),
                        CompletedSurveysTab(),
                        SurveyRewardsTab(),
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
