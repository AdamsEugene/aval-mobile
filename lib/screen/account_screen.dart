// lib/screens/account_screen.dart
import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:e_commerce_app/screen/auth/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color iconColor = CupertinoColors.activeOrange, // Orange color for icons
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap ?? () {},
      child: Container(
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
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.activeOrange,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
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
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false, // This removes all previous routes
            );
          },
          child: const Text(
            'Sign out',
            style: TextStyle(
              color: Color(0xFF05001E),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
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
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(showProfile: true),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: CupertinoIcons.person,
                title: 'My profile',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.shopping_cart,
                title: 'My orders',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.lock,
                title: 'Change password',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.creditcard,
                title: 'Payments',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.bell,
                title: 'Notifications',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.chat_bubble,
                title: 'Contact preference',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.settings,
                title: 'Settings',
              ),
              _buildMenuItem(
                icon: CupertinoIcons.question_circle,
                title: 'FAQ',
              ),
              _buildSignOutButton(context),
              _buildPromoBanner(),
            ]),
          ),
        ],
      ),
    );
  }
}
