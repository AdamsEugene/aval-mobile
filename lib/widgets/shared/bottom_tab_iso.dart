// lib/widgets/shared/bottom_tab_iso.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:e_commerce_app/screen/chat_screen.dart';
import 'package:e_commerce_app/screen/more_screen.dart';
import 'package:e_commerce_app/screen/reseller_screen.dart';

class ButtonTabISO<T> extends StatelessWidget {
  final Widget slivers;
  final Color backgroundColor;
  final Color tabBarBackgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const ButtonTabISO({
    super.key,
    required this.slivers,
    this.backgroundColor = const Color(0xFFEEEFF1),
    this.tabBarBackgroundColor = const Color(0xFF05001E),
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.grey,
  });

  List<CustomTabItem<String>> get tabItems => [
        CustomTabItem(
          icon: Platform.isIOS ? CupertinoIcons.home : Icons.home_outlined,
          activeIcon: Platform.isIOS ? CupertinoIcons.home : Icons.home,
          label: 'Home',
          data: 'home',
        ),
        CustomTabItem(
          icon: Platform.isIOS
              ? CupertinoIcons.shopping_cart
              : Icons.shopping_cart_outlined,
          activeIcon: Platform.isIOS
              ? CupertinoIcons.shopping_cart
              : Icons.shopping_cart,
          label: 'Reseller',
          data: 'reseller',
        ),
        CustomTabItem(
          icon: Platform.isIOS
              ? CupertinoIcons.chat_bubble
              : Icons.chat_bubble_outline,
          activeIcon: Platform.isIOS
              ? CupertinoIcons.chat_bubble_fill
              : Icons.chat_bubble,
          label: 'Chat',
          data: 'chat',
        ),
        CustomTabItem(
          icon: Platform.isIOS
              ? CupertinoIcons.cart
              : Icons.shopping_bag_outlined,
          activeIcon:
              Platform.isIOS ? CupertinoIcons.cart_fill : Icons.shopping_bag,
          label: 'Cart',
          data: 'cart',
        ),
        CustomTabItem(
          icon: Platform.isIOS
              ? CupertinoIcons.ellipsis_vertical
              : Icons.more_vert,
          activeIcon: Platform.isIOS
              ? CupertinoIcons.ellipsis_vertical
              : Icons.more_vert,
          label: 'More',
          data: 'more',
        ),
      ];

  Widget _buildScreen(String route) {
    switch (route) {
      case 'home':
        return Platform.isIOS
            ? CupertinoPageScaffold(
                backgroundColor: backgroundColor,
                child: slivers,
              )
            : Scaffold(
                backgroundColor: backgroundColor,
                body: slivers,
              );
      case 'reseller':
        return const ResellerScreen();
      case 'chat':
        return const ChatScreen();
      case 'cart':
        return const CartScreen();
      case 'more':
        return const MoreScreen();
      default:
        return Platform.isIOS
            ? CupertinoPageScaffold(
                backgroundColor: backgroundColor,
                child: slivers,
              )
            : Scaffold(
                backgroundColor: backgroundColor,
                body: slivers,
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
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
            builder: (BuildContext context) =>
                _buildScreen(tabItems[index].data),
          );
        },
      );
    }

    return Scaffold(
      body: _buildScreen(tabItems[0].data), // Default to home
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: tabBarBackgroundColor,
          indicatorColor: activeColor.withOpacity(0.1),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(
                color: activeColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              );
            }
            return TextStyle(
              color: inactiveColor,
              fontSize: 12,
            );
          }),
        ),
        child: NavigationBar(
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: tabBarBackgroundColor,
          destinations: tabItems.map((item) {
            return NavigationDestination(
              icon: Icon(item.icon, color: inactiveColor),
              selectedIcon: Icon(item.activeIcon, color: activeColor),
              label: item.label,
            );
          }).toList(),
          onDestinationSelected: (index) {
            // Handle navigation
          },
        ),
      ),
    );
  }
}

class CustomTabItem<T> {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final T data;

  CustomTabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.data,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(icon),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(activeIcon),
      ),
      label: label,
    );
  }
}
