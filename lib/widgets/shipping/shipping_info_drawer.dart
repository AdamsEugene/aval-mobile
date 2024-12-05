// lib/widgets/shipping/shipping_info_drawer.dart
import 'dart:math';

import 'package:flutter/cupertino.dart';

class ShippingInfoDrawer extends StatefulWidget {
  const ShippingInfoDrawer({super.key});

  @override
  State<ShippingInfoDrawer> createState() => _ShippingInfoDrawerState();
}

class _ShippingInfoDrawerState extends State<ShippingInfoDrawer> {
  String? _selectedMethod;
  Map<String, String> _selectedAgencies = {};

  final Map<String, List<Map<String, dynamic>>> _shippingAgencies = {
    'Express Shipping': [
      {'name': 'DHL Express', 'price': 'USD 15.00'},
      {'name': 'FedEx Express', 'price': 'USD 16.50'},
      {'name': 'UPS Express', 'price': 'USD 15.75'},
      {'name': 'EMS Express', 'price': 'USD 14.50'},
    ],
    'Premium Shipping': [
      {'name': 'DHL Premium', 'price': 'USD 25.00'},
      {'name': 'FedEx Priority', 'price': 'USD 26.50'},
      {'name': 'UPS Premium', 'price': 'USD 24.50'},
      {'name': 'EMS Premium', 'price': 'USD 23.75'},
    ],
  };

  void _showAgencyPicker(BuildContext context, String shippingMethod) {
    final agencies = _shippingAgencies[shippingMethod]!;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                      if (_selectedAgencies[shippingMethod] == null) {
                        setState(() {
                          _selectedMethod = null;
                        });
                      }
                    },
                  ),
                  CupertinoButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      if (_selectedAgencies[shippingMethod] == null) {
                        setState(() {
                          _selectedAgencies[shippingMethod] =
                              agencies[0]['name'];
                        });
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1,
                  squeeze: 1,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  looping: true,
                  scrollController: FixedExtentScrollController(
                    initialItem: max(
                      0,
                      agencies.indexWhere(
                        (agency) =>
                            agency['name'] == _selectedAgencies[shippingMethod],
                      ),
                    ),
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedAgencies[shippingMethod] =
                          agencies[selectedItem]['name'];
                    });
                  },
                  children: agencies.map((agency) {
                    return Container(
                      height: 32.0,
                      alignment: Alignment
                          .center, // This centers the content vertically
                      child: Text(
                        '${agency['name']} - ${agency['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShippingMethod({
    required String title,
    required String duration,
    required String price,
    bool isRecommended = false,
  }) {
    final bool isSelected = _selectedMethod == title;
    final selectedAgency = _selectedAgencies[title];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedMethod == title) {
              if (title != 'Standard Shipping') {
                _showAgencyPicker(context, title);
              }
            } else {
              _selectedMethod = title;
              if (title != 'Standard Shipping') {
                _showAgencyPicker(context, title);
              }
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFFFFF4E5) : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFFDC202)
                  : const Color(0xFFEEEEEE),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (isRecommended) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEEAD1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Recommended',
                                  style: TextStyle(
                                    color: Color(0xFFFDC202),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          duration,
                          style: TextStyle(
                            color: const Color(0xFF05001E).withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                        if (selectedAgency != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            selectedAgency,
                            style: const TextStyle(
                              color: Color(0xFFFDC202),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _selectedAgencies[title] != null
                            ? _shippingAgencies[title]!.firstWhere((agency) =>
                                agency['name'] ==
                                _selectedAgencies[title])['price']
                            : price,
                        style: const TextStyle(
                          color: Color(0xFF05001E),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (title != 'Standard Shipping') ...[
                        const SizedBox(height: 4),
                        const Icon(
                          CupertinoIcons.chevron_down,
                          size: 16,
                          color: Color(0xFF05001E),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF05001E),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey4,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Shipping Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Shipping Methods',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildShippingMethod(
                    title: 'Standard Shipping',
                    duration: '20-40 days',
                    price: 'Free',
                    isRecommended: true,
                  ),
                  _buildShippingMethod(
                    title: 'Express Shipping',
                    duration: '7-14 days',
                    price: 'USD 15.00',
                  ),
                  _buildShippingMethod(
                    title: 'Premium Shipping',
                    duration: '3-7 days',
                    price: 'USD 25.00',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Ships From', 'China (Mainland)'),
                  _buildInfoRow('Tracking Available', 'Yes'),
                  _buildInfoRow('Estimated Weight', '0.5 kg'),
                  _buildInfoRow('Package Size', '30 × 20 × 10 cm'),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.info_circle_fill,
                              color: Color(0xFFFDC202),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Important Notes',
                              style: TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Delivery times are estimates and may vary based on location\n'
                          '• Customs clearance may affect delivery time\n'
                          '• Tracking information will be provided after shipping\n'
                          '• Local taxes and duties are not included',
                          style: TextStyle(
                            color: const Color(0xFF05001E).withOpacity(0.6),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
