// lib/screen/delivery/providers/courier_service_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class CourierServiceModel {
  final String name;
  final String logoAsset;
  final double price;
  final String deliveryTime;
  final double rating;
  final List<String> features;

  CourierServiceModel({
    required this.name,
    required this.logoAsset,
    required this.price,
    required this.deliveryTime,
    required this.rating,
    required this.features,
  });
}

void showCourierServiceProviders(BuildContext context) {
  // Sample courier services data
  final List<CourierServiceModel> services = [
    CourierServiceModel(
      name: 'Aval Express',
      logoAsset: 'assets/images/a.jpg',
      price: 15.99,
      deliveryTime: '1-2 days',
      rating: 4.8,
      features: ['Live Tracking', 'Insurance Included', 'Door-to-Door Service'],
    ),
    CourierServiceModel(
      name: 'FastTrack',
      logoAsset: 'assets/images/b.jpg',
      price: 12.50,
      deliveryTime: '2-3 days',
      rating: 4.5,
      features: ['Live Tracking', 'Signature Confirmation'],
    ),
    CourierServiceModel(
      name: 'DHL Partner',
      logoAsset: 'assets/images/c.jpg',
      price: 18.75,
      deliveryTime: 'Next Day',
      rating: 4.9,
      features: [
        'International Shipping',
        'Express Delivery',
        'Premium Support'
      ],
    ),
    CourierServiceModel(
      name: 'Local Courier',
      logoAsset: 'assets/images/d.jpg',
      price: 10.00,
      deliveryTime: '3-5 days',
      rating: 4.2,
      features: ['Affordable', 'Eco-Friendly Packaging'],
    ),
  ];

  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) =>
        _CourierServicesDrawer(services: services),
  );
}

class _CourierServicesDrawer extends StatefulWidget {
  final List<CourierServiceModel> services;

  const _CourierServicesDrawer({
    required this.services,
  });

  @override
  State<_CourierServicesDrawer> createState() => _CourierServicesDrawerState();
}

class _CourierServicesDrawerState extends State<_CourierServicesDrawer> {
  String _sortBy = 'Price: Low to High';
  int _selectedServiceIndex = 0;

  final List<String> _sortOptions = [
    'Price: Low to High',
    'Price: High to Low',
    'Fastest Delivery',
    'Highest Rating',
  ];

  List<CourierServiceModel> get _sortedServices {
    final List<CourierServiceModel> sorted = List.from(widget.services);

    switch (_sortBy) {
      case 'Price: Low to High':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Fastest Delivery':
        sorted.sort((a, b) {
          // Simple sort based on the first number in the delivery time
          final aTime = int.tryParse(a.deliveryTime.split('-').first) ??
              int.tryParse(a.deliveryTime.split(' ').first) ??
              99;
          final bTime = int.tryParse(b.deliveryTime.split('-').first) ??
              int.tryParse(b.deliveryTime.split(' ').first) ??
              99;
          return aTime.compareTo(bTime);
        });
        break;
      case 'Highest Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return sorted;
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CupertinoColors.systemGrey4,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.sort_down,
            color: Color(0xFF05001E),
            size: 16,
          ),
          const SizedBox(width: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _sortBy,
              isDense: true,
              icon: const Icon(
                CupertinoIcons.chevron_down,
                color: Color(0xFF05001E),
                size: 14,
              ),
              items: _sortOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF05001E),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _sortBy = newValue;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(CourierServiceModel service, int index) {
    final bool isSelected = index == _selectedServiceIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedServiceIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF5E62)
                : CupertinoColors.systemGrey4,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF5E62).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Logo
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(service.logoAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Service details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                          color: Color(0xFF05001E),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          // Delivery time
                          Icon(
                            CupertinoIcons.clock,
                            color: CupertinoColors.systemGrey.darkColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            service.deliveryTime,
                            style: TextStyle(
                              color: CupertinoColors.systemGrey.darkColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Rating
                          Icon(
                            CupertinoIcons.star_fill,
                            color: CupertinoColors.activeOrange,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            service.rating.toString(),
                            style: TextStyle(
                              color: CupertinoColors.systemGrey.darkColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Price
                Text(
                  '\$${service.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFFFF5E62),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // Features
            if (isSelected) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: service.features.map((feature) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEEAD1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature,
                      style: const TextStyle(
                        color: CupertinoColors.activeOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedServices = _sortedServices;

    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.75,
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Continue',
        fontWeight: FontWeight.w600,
        textColor: const Color(0xFFFF5E62),
        onTap: () {
          // Process service selection
          Navigator.of(context).pop();

          // Show confirmation
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              message: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: CupertinoColors.activeGreen,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your package has been booked!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tracking #: AVL${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You will receive a confirmation email shortly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
              cancelButton: CupertinoActionSheetAction(
                child: const Text('Done'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          );
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Available Courier Services',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Sort dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${sortedServices.length} services available',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey.darkColor,
                    fontSize: 14,
                  ),
                ),
                _buildSortDropdown(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Service listing
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: List.generate(
                  sortedServices.length,
                  (index) => _buildServiceCard(sortedServices[index], index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
