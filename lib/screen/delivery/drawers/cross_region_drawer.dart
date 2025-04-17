// lib/screen/delivery/drawers/cross_region_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class CrossRegionDrawer extends StatefulWidget {
  const CrossRegionDrawer({super.key});

  @override
  State<CrossRegionDrawer> createState() => _CrossRegionDrawerState();
}

class _CrossRegionDrawerState extends State<CrossRegionDrawer> {
  final List<Map<String, dynamic>> _serviceOptions = [
    {
      'title': 'Standard Delivery',
      'description': 'Delivery within 1-2 days',
      'price': 25.00,
      'icon': CupertinoIcons.cube_box,
      'selected': true,
    },
    {
      'title': 'Express Delivery',
      'description': 'Same-day delivery',
      'price': 40.00,
      'icon': CupertinoIcons.bolt,
      'selected': false,
    },
    {
      'title': 'Scheduled Delivery',
      'description': 'Choose your delivery date',
      'price': 30.00,
      'icon': CupertinoIcons.calendar,
      'selected': false,
    },
  ];

  final List<Map<String, dynamic>> _transportOptions = [
    {
      'name': 'Bus Service',
      'icon': CupertinoIcons.bus,
      'description': 'Regular bus transport',
      'duration': '4-8 hours',
      'selected': true,
    },
    {
      'name': 'Dedicated Van',
      'icon': CupertinoIcons.car_fill,
      'description': 'Private delivery van',
      'duration': '3-5 hours',
      'price': '+GHS 20.00',
      'selected': false,
    },
    {
      'name': 'Air Transport',
      'icon': CupertinoIcons.airplane,
      'description': 'Fastest option available',
      'duration': '1-2 hours',
      'price': '+GHS 50.00',
      'selected': false,
    },
  ];

  final List<Map<String, dynamic>> _transitPoints = [
    {
      'name': 'Accra Main Terminal',
      'address': '123 Independence Ave, Accra',
      'distance': '2.5 km',
      'selected': true,
    },
    {
      'name': 'Circle Transport Hub',
      'address': 'Kwame Nkrumah Circle, Accra',
      'distance': '4.3 km',
      'selected': false,
    },
    {
      'name': 'Madina Station',
      'address': 'Madina Market Road, Accra',
      'distance': '8.1 km',
      'selected': false,
    },
  ];

  void _selectService(int index) {
    setState(() {
      for (int i = 0; i < _serviceOptions.length; i++) {
        _serviceOptions[i]['selected'] = i == index;
      }
    });
  }

  void _selectTransport(int index) {
    setState(() {
      for (int i = 0; i < _transportOptions.length; i++) {
        _transportOptions[i]['selected'] = i == index;
      }
    });
  }

  void _selectTransitPoint(int index) {
    setState(() {
      for (int i = 0; i < _transitPoints.length; i++) {
        _transitPoints[i]['selected'] = i == index;
      }
    });
  }

  void _confirmOptions() {
    Navigator.pop(context);

    // Show confirmation
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Cross-Region Delivery Setup'),
        content: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'You selected ${_serviceOptions.firstWhere((element) => element['selected'])['title']} via ${_transportOptions.firstWhere((element) => element['selected'])['name']} from ${_transitPoints.firstWhere((element) => element['selected'])['name']}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.9,
      // title: 'Cross-Region Delivery',
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Apply',
        textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: _confirmOptions,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.activeBlue,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.info,
                      color: CupertinoColors.activeBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cross-Region Delivery',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'For packages traveling between cities. Your package will be transported via a transit point.',
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _buildSectionHeader('Delivery Speed'),
            ),
            ..._serviceOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final service = entry.value;
              return _buildServiceOption(
                title: service['title'],
                description: service['description'],
                price: service['price'],
                icon: service['icon'],
                isSelected: service['selected'],
                onTap: () => _selectService(index),
              );
            }),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: _buildSectionHeader('Transport Method'),
            ),
            ..._transportOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final transport = entry.value;
              return _buildTransportOption(
                name: transport['name'],
                description: transport['description'],
                icon: transport['icon'],
                duration: transport['duration'],
                extraPrice: transport['price'],
                isSelected: transport['selected'],
                onTap: () => _selectTransport(index),
              );
            }),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: _buildSectionHeader('Select Transit Point'),
            ),
            ..._transitPoints.asMap().entries.map((entry) {
              final index = entry.key;
              final point = entry.value;
              return _buildTransitPointOption(
                name: point['name'],
                address: point['address'],
                distance: point['distance'],
                isSelected: point['selected'],
                onTap: () => _selectTransitPoint(index),
              );
            }),

            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _confirmOptions,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF05001E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Confirm Selection',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF05001E),
      ),
    );
  }

  Widget _buildServiceOption({
    required String title,
    required String description,
    required double price,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8F0E3) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? CupertinoColors.activeOrange
                : CupertinoColors.systemGrey5,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? CupertinoColors.activeOrange.withOpacity(0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? CupertinoColors.activeOrange
                    : const Color(0xFF05001E),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? CupertinoColors.activeOrange
                          : const Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? CupertinoColors.activeOrange
                    : const Color(0xFF05001E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportOption({
    required String name,
    required String description,
    required IconData icon,
    required String duration,
    String? extraPrice,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8F0E3) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? CupertinoColors.activeOrange
                : CupertinoColors.systemGrey5,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? CupertinoColors.activeOrange.withOpacity(0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? CupertinoColors.activeOrange
                    : const Color(0xFF05001E),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? CupertinoColors.activeOrange
                          : const Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? CupertinoColors.activeOrange.withOpacity(0.1)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    duration,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? CupertinoColors.activeOrange
                          : const Color(0xFF05001E),
                    ),
                  ),
                ),
                if (extraPrice != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    extraPrice,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? CupertinoColors.activeOrange
                          : const Color(0xFF05001E),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransitPointOption({
    required String name,
    required String address,
    required String distance,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8F0E3) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? CupertinoColors.activeOrange
                : CupertinoColors.systemGrey5,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? CupertinoColors.activeOrange.withOpacity(0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                CupertinoIcons.location_solid,
                color: isSelected
                    ? CupertinoColors.activeOrange
                    : const Color(0xFF05001E),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? CupertinoColors.activeOrange
                          : const Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? CupertinoColors.activeOrange.withOpacity(0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                distance,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? CupertinoColors.activeOrange
                      : const Color(0xFF05001E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
