// lib/screen/delivery/drawers/local_delivery_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class LocalDeliveryDrawer extends StatefulWidget {
  const LocalDeliveryDrawer({super.key});

  @override
  State<LocalDeliveryDrawer> createState() => _LocalDeliveryDrawerState();
}

class _LocalDeliveryDrawerState extends State<LocalDeliveryDrawer> {
  final List<Map<String, dynamic>> _serviceOptions = [
    {
      'title': 'Standard Delivery',
      'description': 'Delivery within 2-3 hours',
      'price': 10.00,
      'icon': CupertinoIcons.cube_box,
      'selected': true,
    },
    {
      'title': 'Express Delivery',
      'description': 'Delivery within 1 hour',
      'price': 15.00,
      'icon': CupertinoIcons.clock,
      'selected': false,
    },
    {
      'title': 'Scheduled Delivery',
      'description': 'Choose your delivery time',
      'price': 12.00,
      'icon': CupertinoIcons.calendar,
      'selected': false,
    },
  ];

  final List<Map<String, dynamic>> _couriers = [
    {
      'name': 'Motor Bike',
      'icon': CupertinoIcons.car_detailed,
      'description': 'Fast delivery for small packages',
      'maxWeight': '5kg',
      'selected': true,
    },
    {
      'name': 'Car',
      'icon': CupertinoIcons.car_fill,
      'description': 'Suitable for medium packages',
      'maxWeight': '20kg',
      'selected': false,
    },
    {
      'name': 'Van',
      'icon': CupertinoIcons.bus,
      'description': 'Best for large packages',
      'maxWeight': '100kg',
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

  void _selectCourier(int index) {
    setState(() {
      for (int i = 0; i < _couriers.length; i++) {
        _couriers[i]['selected'] = i == index;
      }
    });
  }

  void _confirmOptions() {
    Navigator.pop(context);

    // Show confirmation
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Service Selected'),
        content: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'You selected: ${_serviceOptions.firstWhere((element) => element['selected'])['title']} with ${_couriers.firstWhere((element) => element['selected'])['name']}',
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
      height: MediaQuery.of(context).size.height * 0.85,
      // title: 'Local Delivery Options',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _buildSectionHeader('Choose Service'),
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
              child: _buildSectionHeader('Choose Courier'),
            ),
            ..._couriers.asMap().entries.map((entry) {
              final index = entry.key;
              final courier = entry.value;
              return _buildCourierOption(
                name: courier['name'],
                description: courier['description'],
                icon: courier['icon'],
                maxWeight: courier['maxWeight'],
                isSelected: courier['selected'],
                onTap: () => _selectCourier(index),
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
              '\$${price.toStringAsFixed(2)}',
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

  Widget _buildCourierOption({
    required String name,
    required String description,
    required IconData icon,
    required String maxWeight,
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
                'Max: $maxWeight',
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
