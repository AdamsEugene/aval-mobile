// lib/screens/account_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:e_commerce_app/screen/auth/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color iconColor = const Color(0xFFFDC202),
  }) {
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap ?? () {},
        child: _buildMenuItemContent(icon, title, iconColor),
      );
    }

    return InkWell(
      onTap: onTap ?? () {},
      child: _buildMenuItemContent(icon, title, iconColor),
    );
  }

  Widget _buildMenuItemContent(IconData icon, String title, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF05001E),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(
            Platform.isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right,
            color: const Color(0xFFFDC202),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    Widget buttonChild = const Text(
      'Sign out',
      style: TextStyle(
        color: Color(0xFF05001E),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );

    void onPressed() {
      if (Platform.isIOS) {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF05001E),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Platform.isIOS
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: onPressed,
                child: buttonChild,
              )
            : TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: buttonChild,
              ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(24),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/black_friday.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HeaderDelegate(showProfile: true),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 16),
            _buildMenuItem(
              icon:
                  Platform.isIOS ? CupertinoIcons.person : Icons.person_outline,
              title: 'My profile',
            ),
            _buildMenuItem(
              icon: Platform.isIOS
                  ? CupertinoIcons.shopping_cart
                  : Icons.shopping_cart_outlined,
              title: 'My orders',
            ),
            _buildMenuItem(
              icon: Platform.isIOS ? CupertinoIcons.lock : Icons.lock_outline,
              title: 'Change password',
            ),
            _buildMenuItem(
              icon: Platform.isIOS
                  ? CupertinoIcons.creditcard
                  : Icons.credit_card_outlined,
              title: 'Payments',
            ),
            _buildMenuItem(
              icon: Platform.isIOS
                  ? CupertinoIcons.bell
                  : Icons.notifications_outlined,
              title: 'Notifications',
            ),
            _buildMenuItem(
              icon: Platform.isIOS
                  ? CupertinoIcons.chat_bubble
                  : Icons.chat_bubble_outline,
              title: 'Contact preference',
            ),
            _buildMenuItem(
              icon: Platform.isIOS
                  ? CupertinoIcons.settings
                  : Icons.settings_outlined,
              title: 'Settings',
            ),
            _buildMenuItem(
              icon: Platform.isIOS
                  ? CupertinoIcons.question_circle
                  : Icons.help_outline,
              title: 'FAQ',
            ),
            _buildSignOutButton(context),
            _buildPromoBanner(),
          ]),
        ),
      ],
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemBackground,
            child: content,
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: content,
          );
  }
}
