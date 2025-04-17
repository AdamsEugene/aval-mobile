// lib/screen/delivery/tabs/profile_tab.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/delivery/drawers/addresses_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/payment_methods_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/delivery_preferences_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/help_support_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/terms_conditions_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/privacy_policy_drawer.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // User Profile Card
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF05001E),
                  Color(0xFF150050),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF05001E).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: CupertinoColors.activeOrange,
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image:
                              NetworkImage('https://i.pravatar.cc/150?img=12'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'David Johnson',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'david.johnson@example.com',
                            style: TextStyle(
                              color: CupertinoColors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '+233 123 456 7890',
                            style: TextStyle(
                              color: CupertinoColors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Edit profile
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.pencil,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('35', 'Packages\nSent'),
                    Container(
                      height: 40,
                      width: 1,
                      color: CupertinoColors.white.withOpacity(0.3),
                    ),
                    _buildStat('28', 'Packages\nReceived'),
                    Container(
                      height: 40,
                      width: 1,
                      color: CupertinoColors.white.withOpacity(0.3),
                    ),
                    _buildStat('\$850', 'Total\nSpent'),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Settings Options
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  context: context,
                  icon: CupertinoIcons.location,
                  title: 'My Addresses',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const AddressesDrawer(),
                    );
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildMenuItem(
                  context: context,
                  icon: CupertinoIcons.creditcard,
                  title: 'Payment Methods',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const PaymentMethodsDrawer(),
                    );
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildMenuItem(
                  context: context,
                  icon: CupertinoIcons.settings,
                  title: 'Delivery Preferences',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const DeliveryPreferencesDrawer(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Help & Support
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  context: context,
                  icon: CupertinoIcons.question_circle,
                  title: 'Help & Support',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const HelpSupportDrawer(),
                    );
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildMenuItem(
                  context: context,
                  icon: CupertinoIcons.doc_text,
                  title: 'Terms & Conditions',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const TermsConditionsDrawer(),
                    );
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildMenuItem(
                  context: context,
                  icon: CupertinoIcons.shield,
                  title: 'Privacy Policy',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const PrivacyPolicyDrawer(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Logout Button
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Logout confirmation
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Log Out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to previous screen
                        },
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.destructiveRed,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Version info
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: CupertinoColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CupertinoColors.white.withOpacity(0.8),
            fontSize: 12,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF05001E),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF05001E),
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
