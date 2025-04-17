// lib/screen/delivery/drawers/delivery_preferences_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class DeliveryPreferencesDrawer extends StatefulWidget {
  const DeliveryPreferencesDrawer({super.key});

  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const DeliveryPreferencesDrawer(),
    );
  }

  @override
  State<DeliveryPreferencesDrawer> createState() =>
      _DeliveryPreferencesDrawerState();
}

class _DeliveryPreferencesDrawerState extends State<DeliveryPreferencesDrawer> {
  bool _isExpressDelivery = true;
  bool _requireSignature = true;
  bool _receiveNotifications = true;
  bool _includeInsurance = false;
  bool _useDefaultAddress = true;
  String _selectedCarrier = 'Any Available';
  String _selectedVehicleType = 'Standard';

  final List<String> _carriers = [
    'Any Available',
    'Registered Taxi',
    'DHL',
    'FedEx',
    'EMS',
  ];

  final List<String> _vehicleTypes = [
    'Standard',
    'Motorcycle',
    'Car',
    'Van',
    'Truck',
  ];

  void _showCupertinoPicker({
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelected,
    required String title,
  }) {
    final int initialIndex = options.indexOf(selectedValue);
    int tempIndex = initialIndex;
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done'),
                    onPressed: () {
                      onSelected(options[tempIndex]);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: initialIndex),
                itemExtent: 36,
                onSelectedItemChanged: (index) {
                  tempIndex = index;
                },
                children: options.map((e) => Center(child: Text(e))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoDropdown({
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        _showCupertinoPicker(
          options: options,
          selectedValue: value,
          onSelected: onChanged,
          title: title,
        );
      },
      child: Container(
        color: CupertinoColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: CupertinoColors.systemGrey4,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    color: CupertinoColors.systemGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.75,
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Save',
        textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: () {
          // Save preferences and close drawer
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Delivery Preferences',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Delivery Options'),
                  _buildSwitchOption(
                    title: 'Express Delivery',
                    subtitle: 'Faster delivery at higher cost',
                    value: _isExpressDelivery,
                    onChanged: (value) =>
                        setState(() => _isExpressDelivery = value),
                  ),
                  _buildSectionTitle('Security'),
                  _buildSwitchOption(
                    title: 'Require Signature',
                    subtitle: 'Recipient must sign for package',
                    value: _requireSignature,
                    onChanged: (value) =>
                        setState(() => _requireSignature = value),
                  ),
                  _buildSwitchOption(
                    title: 'Include Insurance',
                    subtitle: 'Protect your package up to \$1000',
                    value: _includeInsurance,
                    onChanged: (value) =>
                        setState(() => _includeInsurance = value),
                  ),
                  _buildSectionTitle('Communication'),
                  _buildSwitchOption(
                    title: 'Delivery Notifications',
                    subtitle: 'Receive updates about your package',
                    value: _receiveNotifications,
                    onChanged: (value) =>
                        setState(() => _receiveNotifications = value),
                  ),
                  _buildSectionTitle('Addresses'),
                  _buildSwitchOption(
                    title: 'Use Default Address',
                    subtitle: 'Use your primary address for deliveries',
                    value: _useDefaultAddress,
                    onChanged: (value) =>
                        setState(() => _useDefaultAddress = value),
                  ),
                  _buildSectionTitle('Carrier Preferences'),
                  _buildCupertinoDropdown(
                    title: 'Preferred Carrier',
                    value: _selectedCarrier,
                    options: _carriers,
                    onChanged: (value) =>
                        setState(() => _selectedCarrier = value),
                  ),
                  _buildCupertinoDropdown(
                    title: 'Vehicle Type',
                    value: _selectedVehicleType,
                    options: _vehicleTypes,
                    onChanged: (value) =>
                        setState(() => _selectedVehicleType = value),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: CupertinoColors.activeOrange,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: CupertinoColors.systemGrey.darkColor,
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
}
