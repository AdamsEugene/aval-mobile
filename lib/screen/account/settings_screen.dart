// lib/screens/account/settings_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _faceIdEnabled = true;
  bool _pushNotifications = true;
  String _currency = 'USD';
  String _language = 'English';
  String _theme = 'Light';

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF05001E).withOpacity(0.6),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      color: CupertinoColors.white,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
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
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: const Color(0xFF05001E).withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing,
              if (onTap != null)
                Icon(
                  CupertinoIcons.chevron_right,
                  color: const Color(0xFF05001E).withOpacity(0.3),
                  size: 20,
                ),
            ],
          ),
        ),
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

  void _showOptions({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelect,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title),
        actions: options.map((option) {
          return CupertinoActionSheetAction(
            isDefaultAction: option == selectedValue,
            onPressed: () {
              Navigator.pop(context);
              onSelect(option);
            },
            child: Text(option),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
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
              title: 'Settings',
              showBackButton: true,
              showProfile: false,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionTitle('Security'),
              _buildSettingItem(
                title: 'Face ID / Touch ID',
                subtitle: 'Use biometrics for quick login',
                trailing: CupertinoSwitch(
                  value: _faceIdEnabled,
                  onChanged: (value) => setState(() => _faceIdEnabled = value),
                  activeColor: CupertinoColors.activeOrange,
                ),
              ),
              _buildDivider(),
              _buildSettingItem(
                title: 'Change PIN',
                onTap: () {
                  // TODO: Implement PIN change
                },
              ),
              _buildSectionTitle('Notifications'),
              _buildSettingItem(
                title: 'Push Notifications',
                subtitle: 'Receive alerts and updates',
                trailing: CupertinoSwitch(
                  value: _pushNotifications,
                  onChanged: (value) =>
                      setState(() => _pushNotifications = value),
                  activeColor: CupertinoColors.activeOrange,
                ),
              ),
              _buildSectionTitle('Preferences'),
              _buildSettingItem(
                title: 'Currency',
                subtitle: _currency,
                onTap: () => _showOptions(
                  title: 'Select Currency',
                  options: ['USD', 'EUR', 'GBP', 'JPY'],
                  selectedValue: _currency,
                  onSelect: (value) => setState(() => _currency = value),
                ),
              ),
              _buildDivider(),
              _buildSettingItem(
                title: 'Language',
                subtitle: _language,
                onTap: () => _showOptions(
                  title: 'Select Language',
                  options: ['English', 'Spanish', 'French', 'German'],
                  selectedValue: _language,
                  onSelect: (value) => setState(() => _language = value),
                ),
              ),
              _buildDivider(),
              _buildSettingItem(
                title: 'Theme',
                subtitle: _theme,
                onTap: () => _showOptions(
                  title: 'Select Theme',
                  options: ['Light', 'Dark', 'System'],
                  selectedValue: _theme,
                  onSelect: (value) => setState(() => _theme = value),
                ),
              ),
              _buildSectionTitle('App Info'),
              _buildSettingItem(
                title: 'Version',
                subtitle: '1.0.0 (123)',
              ),
              _buildDivider(),
              _buildSettingItem(
                title: 'Terms of Service',
                onTap: () {
                  // TODO: Show terms of service
                },
              ),
              _buildDivider(),
              _buildSettingItem(
                title: 'Privacy Policy',
                onTap: () {
                  // TODO: Show privacy policy
                },
              ),
              const SizedBox(height: 24),
            ]),
          ),
        ],
      ),
    );
  }
}
