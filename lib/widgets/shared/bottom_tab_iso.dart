import 'package:flutter/cupertino.dart';

class ButtonTabISO<T> extends StatelessWidget {
  final List<CustomTabItem<T>> tabItems;
  final List<Widget> slivers;
  final Color backgroundColor;
  final Color tabBarBackgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const ButtonTabISO({
    super.key,
    required this.tabItems,
    required this.slivers,
    this.backgroundColor = const Color(0xFFEEEFF1),
    this.tabBarBackgroundColor = const Color(0xFF05001E),
    this.activeColor = CupertinoColors.white,
    this.inactiveColor = CupertinoColors.systemGrey,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: tabBarBackgroundColor,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        items:
            tabItems.map((item) => item.toBottomNavigationBarItem()).toList(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              backgroundColor: backgroundColor,
              child: SafeArea(
                child: CustomScrollView(
                  slivers: slivers,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CustomTabItem<T> {
  final IconData icon;
  final String label;
  final T data;

  CustomTabItem({required this.icon, required this.label, required this.data});

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
