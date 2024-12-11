// lib/screens/delivery_location_screen.dart
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:flutter/material.dart';

class DeliveryLocationScreen extends StatefulWidget {
  const DeliveryLocationScreen({super.key});

  @override
  State<DeliveryLocationScreen> createState() => _DeliveryLocationScreenState();
}

class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  static const List<Address> _savedAddresses = [
    Address(
      id: '1',
      title: 'Home',
      address: '123 Main Street, Kumasi',
      isDefault: true,
      icon: CupertinoIcons.house_fill,
    ),
    Address(
      id: '2',
      title: 'Work',
      address: '456 Office Plaza, Accra',
      icon: CupertinoIcons.briefcase_fill,
    ),
    Address(
      id: '3',
      title: 'Gym',
      address: '789 Fitness Ave, Tema',
      icon: CupertinoIcons.sportscourt_fill,
    ),
  ];

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Delivery Location',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.map,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCurrentLocation() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Handle current location
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF05001E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                CupertinoIcons.location_fill,
                color: CupertinoColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use my current location',
                  style: TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Enable location services',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.right_chevron,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedAddresses() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        // color: CupertinoColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Saved Addresses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.plus,
                      color: Color(0xFF05001E),
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Add New',
                      style: TextStyle(
                        color: Color(0xFF05001E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // Handle add new address
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _savedAddresses.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final address = _savedAddresses[index];
              return CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 12),
                onPressed: () {
                  Navigator.pop(context, address);
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        address.icon,
                        color: const Color(0xFF05001E),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                address.title,
                                style: const TextStyle(
                                  color: Color(0xFF05001E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (address.isDefault) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF05001E)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Default',
                                    style: TextStyle(
                                      color: Color(0xFF05001E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            address.address,
                            style: TextStyle(
                              color: CupertinoColors.systemGrey.darkColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.right_chevron,
                      color: CupertinoColors.systemGrey,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            const MainSearchBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildCurrentLocation(),
                  _buildSavedAddresses(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class Address {
  final String id;
  final String title;
  final String address;
  final IconData icon;
  final bool isDefault;

  const Address({
    required this.id,
    required this.title,
    required this.address,
    required this.icon,
    this.isDefault = false,
  });
}
