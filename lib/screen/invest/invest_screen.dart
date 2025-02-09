// lib/screens/invest/invest_screen.dart
import 'package:e_commerce_app/screen/invest/tabs/market_tab.dart';
import 'package:e_commerce_app/screen/invest/tabs/portfolio_tab.dart';
import 'package:e_commerce_app/screen/watch_share/tabs/history_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class InvestScreen extends StatefulWidget {
  const InvestScreen({super.key});

  @override
  State<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.chart_bar_alt_fill,
      label: 'Portfolio',
      data: 'portfolio',
    ),
    CustomTabItem(
      icon: CupertinoIcons.graph_circle,
      label: 'Market',
      data: 'market',
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
        return 'My Portfolio';
      case 1:
        return 'Overview';
      case 2:
        return 'History';
      default:
        return 'Invest';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    switch (_selectedTabIndex) {
      case 0: // Portfolio
        return [
          HeaderAction(
            icon: CupertinoIcons.plus_circle,
            onPressed: () {
              // Handle new investment
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.bell,
            onPressed: () {
              // Handle notifications
            },
          ),
        ];
      case 1: // Market
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
      case 2: // History
        return [
          HeaderAction(
            icon: CupertinoIcons.calendar,
            onPressed: () {
              // Handle date filter
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.square_arrow_down,
            onPressed: () {
              // Handle export
            },
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      withBack: true,
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
      if (_bottomNavItems[index].data == 'portfolio') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'market') {
        _selectedTabIndex = 1;
      } else if (_bottomNavItems[index].data == 'history') {
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
                        PortfolioTab(),
                        MarketTab(),
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
