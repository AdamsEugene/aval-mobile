// lib/screens/account/contact_preferences_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:flutter/material.dart';

class ContactPreferencesScreen extends StatefulWidget {
  const ContactPreferencesScreen({super.key});

  @override
  State<ContactPreferencesScreen> createState() =>
      _ContactPreferencesScreenState();
}

class _ContactPreferencesScreenState extends State<ContactPreferencesScreen> {
  bool _emailMarketing = true;
  bool _smsMarketing = false;
  bool _orderUpdates = true;
  bool _deliveryUpdates = true;
  bool _promotions = true;
  bool _newsletter = false;

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF05001E),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPreferenceItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: CupertinoColors.activeOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      color: CupertinoColors.white,
      child: const Divider(
        height: 1,
        indent: 24,
        endIndent: 24,
      ),
    );
  }

  Widget _buildContactMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Methods'),
        _buildPreferenceItem(
          title: 'Email Marketing',
          subtitle: 'Receive marketing communications via email',
          value: _emailMarketing,
          onChanged: (value) => setState(() => _emailMarketing = value),
        ),
        _buildDivider(),
        _buildPreferenceItem(
          title: 'SMS Marketing',
          subtitle: 'Receive marketing communications via SMS',
          value: _smsMarketing,
          onChanged: (value) => setState(() => _smsMarketing = value),
        ),
      ],
    );
  }

  Widget _buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Notifications'),
        _buildPreferenceItem(
          title: 'Order Updates',
          subtitle: 'Get notified about your order status',
          value: _orderUpdates,
          onChanged: (value) => setState(() => _orderUpdates = value),
        ),
        _buildDivider(),
        _buildPreferenceItem(
          title: 'Delivery Updates',
          subtitle: 'Track your deliveries in real-time',
          value: _deliveryUpdates,
          onChanged: (value) => setState(() => _deliveryUpdates = value),
        ),
      ],
    );
  }

  Widget _buildPromotionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Promotions & News'),
        _buildPreferenceItem(
          title: 'Special Offers',
          subtitle: 'Receive updates about sales and promotions',
          value: _promotions,
          onChanged: (value) => setState(() => _promotions = value),
        ),
        _buildDivider(),
        _buildPreferenceItem(
          title: 'Newsletter',
          subtitle: 'Subscribe to our weekly newsletter',
          value: _newsletter,
          onChanged: (value) => setState(() => _newsletter = value),
        ),
      ],
    );
  }

  void _savePreferences() {
    // TODO: Implement save preferences logic
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Success'),
        content: const Text('Your contact preferences have been updated.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to account screen
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              title: 'Preferences',
              showBackButton: true,
              showProfile: false,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildContactMethodSection(),
                _buildNotificationSection(),
                _buildPromotionsSection(),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _savePreferences,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Save Preferences',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
