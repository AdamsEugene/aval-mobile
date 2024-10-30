import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:e_commerce_app/screen/chat_screen.dart';
import 'package:e_commerce_app/screen/more_screen.dart';
import 'package:e_commerce_app/screen/reseller_screen.dart';
import 'package:flutter/cupertino.dart';

class ButtonTabISO<T> extends StatelessWidget {
  final Widget slivers;
  final Color backgroundColor;
  final Color tabBarBackgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  ButtonTabISO({
    super.key,
    required this.slivers,
    this.backgroundColor = const Color(0xFFEEEFF1),
    this.tabBarBackgroundColor = const Color(0xFF05001E),
    this.activeColor = CupertinoColors.white,
    this.inactiveColor = CupertinoColors.systemGrey,
  });

  final List<CustomTabItem<String>> tabItems = [
    CustomTabItem(icon: CupertinoIcons.home, label: 'Home', data: 'home'),
    CustomTabItem(
      icon: CupertinoIcons.shopping_cart,
      label: 'Reseller',
      data: 'reseller',
    ),
    CustomTabItem(
        icon: CupertinoIcons.chat_bubble, label: 'Chat', data: 'chat'),
    CustomTabItem(icon: CupertinoIcons.cart, label: 'Cart', data: 'cart'),
    CustomTabItem(
        icon: CupertinoIcons.ellipsis_vertical, label: 'More', data: 'more'),
  ];

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
            // Return different screens based on the tab index
            switch (tabItems[index].data) {
              case 'home':
                return slivers;
              case 'reseller':
                return const ResellerScreen();
              case 'chat':
                return const ChatScreen();
              case 'cart':
                return const CartScreen();
              case 'more':
                return const MoreScreen();
              default:
                return slivers;
            }
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
