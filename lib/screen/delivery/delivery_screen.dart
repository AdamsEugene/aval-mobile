// lib/screen/delivery/delivery_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screen/delivery/tabs/send_package_tab.dart';
import 'package:e_commerce_app/screen/delivery/tabs/track_package_tab.dart';
import 'package:e_commerce_app/screen/delivery/tabs/history_tab.dart';
import 'package:e_commerce_app/screen/delivery/tabs/profile_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/screen/delivery/drawers/notification_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/scan_package_drawer.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.cube_box,
      label: 'Send',
      data: 'send',
    ),
    CustomTabItem(
      icon: CupertinoIcons.location,
      label: 'Track',
      data: 'track',
    ),
    CustomTabItem(
      icon: CupertinoIcons.clock,
      label: 'History',
      data: 'history',
    ),
    CustomTabItem(
      icon: CupertinoIcons.person,
      label: 'Profile',
      data: 'profile',
    ),
  ];

  String _getHeaderTitle() {
    switch (_selectedTabIndex) {
      case 0:
        return 'Send Package';
      case 1:
        return 'Track Package';
      case 2:
        return 'Delivery History';
      case 3:
        return 'Delivery Profile';
      default:
        return 'Aval Delivery';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    return [
      HeaderAction(
        icon: CupertinoIcons.qrcode_viewfinder,
        onPressed: () {
          // Show scan package drawer
          showCupertinoModalPopup(
            context: context,
            builder: (context) => const ScanPackageDrawer(),
          );
        },
      ),
      HeaderAction(
        icon: CupertinoIcons.bell,
        onPressed: () {
          // Show notifications drawer
          showCupertinoModalPopup(
            context: context,
            builder: (context) => const NotificationDrawer(),
          );
        },
        badgeCount: 3, // Example notification count
      ),
    ];
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
      if (_bottomNavItems[index].data == 'send') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'track') {
        _selectedTabIndex = 1;
      } else if (_bottomNavItems[index].data == 'history') {
        _selectedTabIndex = 2;
      } else if (_bottomNavItems[index].data == 'profile') {
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
                        SendPackageTab(),
                        TrackPackageTab(),
                        HistoryTab(),
                        ProfileTab(),
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
