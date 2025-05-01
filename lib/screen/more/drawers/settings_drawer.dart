import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:e_commerce_app/screen/more/drawers/edit_profile_screen.dart';
import 'package:e_commerce_app/screen/more/drawers/manage_addresses_screen.dart';
import 'package:e_commerce_app/screen/more/drawers/family_sharing_screen.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  // Toggle states
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _promotionalNotifications = false;
  bool _orderUpdates = true;
  bool _deliveryUpdates = true;
  bool _biometricAuth = false;
  bool _savePaymentInfo = true;
  bool _darkMode = false;
  bool _locationServices = true;

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      leadingAction: DrawerAction(
        text: 'Close',
        textColor: const Color(0xFF3F51B5),
        fontWeight: FontWeight.w600,
        fontSize: 16,
        onTap: () => Navigator.of(context).pop(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add some extra space at the top to ensure content is visible
          const SizedBox(height: 8),
          
          // Header
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF05001E),
              ),
            ),
          ),
          
          // Settings List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSectionHeader('Account Settings'),
                _buildSettingItem(
                  icon: CupertinoIcons.person_fill,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  showArrow: true,
                  onTap: () {
                    // Navigate to profile edit screen
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.location_fill,
                  title: 'Manage Addresses',
                  subtitle: 'Add or edit your delivery addresses',
                  showArrow: true,
                  onTap: () {
                    // Navigate to addresses screen
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const ManageAddressesScreen(),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.person_2_fill,
                  title: 'Family Sharing',
                  subtitle: 'Manage your family member accounts',
                  showArrow: true,
                  onTap: () {
                    // Navigate to family sharing screen
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const FamilySharingScreen(),
                      ),
                    );
                  },
                ),
                
                _buildSectionHeader('Notification Preferences'),
                _buildToggleItem(
                  icon: CupertinoIcons.bell_fill,
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications on your device',
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                  },
                ),
                _buildToggleItem(
                  icon: CupertinoIcons.mail_solid,
                  title: 'Email Notifications',
                  subtitle: 'Receive updates via email',
                  value: _emailNotifications,
                  onChanged: (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  },
                ),
                _buildToggleItem(
                  icon: CupertinoIcons.tag_fill,
                  title: 'Promotional Notifications',
                  subtitle: 'Receive offers and discounts',
                  value: _promotionalNotifications,
                  onChanged: (value) {
                    setState(() {
                      _promotionalNotifications = value;
                    });
                  },
                ),
                _buildToggleItem(
                  icon: CupertinoIcons.cube_box_fill,
                  title: 'Order Updates',
                  subtitle: 'Notifications about your orders',
                  value: _orderUpdates,
                  onChanged: (value) {
                    setState(() {
                      _orderUpdates = value;
                    });
                  },
                ),
                _buildToggleItem(
                  icon: CupertinoIcons.cart_fill,
                  title: 'Delivery Updates',
                  subtitle: 'Get notified about shipment status',
                  value: _deliveryUpdates,
                  onChanged: (value) {
                    setState(() {
                      _deliveryUpdates = value;
                    });
                  },
                ),
                
                _buildSectionHeader('Privacy & Security'),
                _buildToggleItem(
                  icon: CupertinoIcons.lock_fill,
                  title: 'Biometric Authentication',
                  subtitle: 'Use Face ID or Touch ID to secure your account',
                  value: _biometricAuth,
                  onChanged: (value) {
                    setState(() {
                      _biometricAuth = value;
                    });
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.shield_fill,
                  title: 'Privacy Settings',
                  subtitle: 'Manage your data and privacy preferences',
                  showArrow: true,
                  onTap: () {
                    // Navigate to privacy settings
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.doc_text_fill,
                  title: 'Terms & Conditions',
                  subtitle: 'Read our terms of service',
                  showArrow: true,
                  onTap: () {
                    // Show terms and conditions
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.arrow_clockwise,
                  title: 'Clear App Cache',
                  subtitle: 'Free up storage space',
                  showArrow: false,
                  onTap: () {
                    // Clear app cache logic
                    _showSuccessMessage('Cache cleared successfully');
                  },
                ),
                
                _buildSectionHeader('App Settings'),
                _buildToggleItem(
                  icon: CupertinoIcons.moon_fill,
                  title: 'Dark Mode',
                  subtitle: 'Switch between light and dark themes',
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
                _buildToggleItem(
                  icon: CupertinoIcons.location_fill,
                  title: 'Location Services',
                  subtitle: 'Allow app to access your location',
                  value: _locationServices,
                  onChanged: (value) {
                    setState(() {
                      _locationServices = value;
                    });
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.globe,
                  title: 'Language',
                  subtitle: 'Choose your preferred language',
                  showArrow: true,
                  onTap: () {
                    // Navigate to language selection
                  },
                ),
                
                _buildSectionHeader('Payment Methods'),
                _buildSettingItem(
                  icon: CupertinoIcons.creditcard_fill,
                  title: 'Manage Payment Methods',
                  subtitle: 'Add or edit credit cards and payment options',
                  showArrow: true,
                  onTap: () {
                    // Navigate to payment methods
                  },
                ),
                _buildToggleItem(
                  icon: CupertinoIcons.lock_fill,
                  title: 'Save Payment Information',
                  subtitle: 'Securely store your payment details',
                  value: _savePaymentInfo,
                  onChanged: (value) {
                    setState(() {
                      _savePaymentInfo = value;
                    });
                  },
                ),
                
                _buildSectionHeader('Support'),
                _buildSettingItem(
                  icon: CupertinoIcons.question_circle_fill,
                  title: 'Help Center',
                  subtitle: 'Get answers to frequently asked questions',
                  showArrow: true,
                  onTap: () {
                    // Navigate to help center
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.chat_bubble_2_fill,
                  title: 'Contact Support',
                  subtitle: 'Get help from our customer service team',
                  showArrow: true,
                  onTap: () {
                    // Navigate to contact support
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.star_fill,
                  title: 'Rate the App',
                  subtitle: 'Share your feedback with us',
                  showArrow: true,
                  onTap: () {
                    // Open app store rating
                  },
                ),
                
                // Logout and Version Info
                const SizedBox(height: 16),
                _buildLogoutButton(),
                const SizedBox(height: 20),
                _buildVersionInfo(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF673AB7),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF673AB7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool showArrow,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF673AB7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF673AB7),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF05001E).withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              const Icon(
                CupertinoIcons.chevron_right,
                color: CupertinoColors.systemGrey,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF673AB7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF673AB7),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF05001E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF05001E).withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeColor: const Color(0xFF673AB7),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
  
  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {
        _showLogoutConfirmation();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.square_arrow_right,
              color: Color(0xFFFF3B30),
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF3B30),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildVersionInfo() {
    return const Center(
      child: Text(
        'Version 1.0.0 (Build 42)',
        style: TextStyle(
          fontSize: 12,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
  
  void _showLogoutConfirmation() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                // Handle logout
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close the settings drawer
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
  
  void _showSuccessMessage(String message) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    
    // Auto-dismiss after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
