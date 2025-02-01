// lib/screens/account_screen.dart
import 'package:e_commerce_app/screen/account/contact_preferences_screen.dart';
import 'package:e_commerce_app/screen/account/faq_screen.dart';
import 'package:e_commerce_app/screen/account/orders_screen.dart';
import 'package:e_commerce_app/screen/account/payments_screen.dart';
import 'package:e_commerce_app/screen/account/profile_screen.dart';
import 'package:e_commerce_app/screen/account/settings_screen.dart';
import 'package:e_commerce_app/screen/auth/change_password_screen.dart';
import 'package:e_commerce_app/widgets/shared/profile_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:e_commerce_app/screen/auth/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Widget _buildMenuItem({
    required BuildContext context, // Add this parameter
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color iconColor = CupertinoColors.activeOrange,
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
            delegate: HeaderDelegate(
                showProfile: true,
                profileImage: const ProfileImage(
                  rounded: 48,
                  avatar: true,
                ),
                imageSize: 70,
                showBackButton: true),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildMenuItem(
                context: context, // Add the context here
                icon: CupertinoIcons.person,
                title: 'My profile',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.shopping_cart,
                title: 'My orders',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const OrdersScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.lock,
                title: 'Change password',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.creditcard,
                title: 'Payments',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const PaymentsScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.bell,
                title: 'Notifications',
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.chat_bubble,
                title: 'Contact preference',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const ContactPreferencesScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.settings,
                title: 'Settings',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context: context,
                icon: CupertinoIcons.question_circle,
                title: 'FAQ',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => const FAQScreen(),
                    ),
                  );
                },
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
