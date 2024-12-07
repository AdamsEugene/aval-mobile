// lib/screens/checkout/delivery_address_sheet.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryAddressSheet extends StatefulWidget {
  const DeliveryAddressSheet({super.key});

  @override
  State<DeliveryAddressSheet> createState() => _DeliveryAddressSheetState();
}

class _DeliveryAddressSheetState extends State<DeliveryAddressSheet> {
  final TextEditingController _searchController = TextEditingController();
  final List<SavedAddress> _savedAddresses = [
    const SavedAddress(
      title: 'Home',
      address: '123 Main Street, Apartment 4B\nNew York, NY 10001',
      isDefault: true,
    ),
    const SavedAddress(
      title: 'Work',
      address: '456 Business Ave\nNew York, NY 10002',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildMap(),
          _buildAddressList(),
          _buildAddNewButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Delivery Address',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CupertinoTextField(
        controller: _searchController,
        placeholder: 'Search for an address',
        prefix: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.systemGrey,
          ),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          final Uri url = Uri.parse('maps://?q=Current+Location');
          if (Platform.isIOS) {
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.map,
                  size: 48,
                  color: CupertinoColors.systemGrey,
                ),
                SizedBox(height: 8),
                Text(
                  'Tap to select location',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressList() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _savedAddresses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _AddressCard(address: _savedAddresses[index]);
        },
      ),
    );
  }

  Widget _buildAddNewButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Handle adding new address
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFDC202),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: Text(
              'Add New Address',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final SavedAddress address;

  const _AddressCard({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: address.isDefault
              ? const Color(0xFFFDC202)
              : CupertinoColors.systemGrey4,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(CupertinoIcons.location_solid, size: 24),
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
                          color: const Color(0xFFFDC202).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFFDC202),
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
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(CupertinoIcons.chevron_right, size: 20),
        ],
      ),
    );
  }
}

class SavedAddress {
  final String title;
  final String address;
  final bool isDefault;

  const SavedAddress({
    required this.title,
    required this.address,
    required this.isDefault,
  });
}
