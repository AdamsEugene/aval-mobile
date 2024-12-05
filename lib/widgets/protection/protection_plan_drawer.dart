// lib/widgets/protection/protection_plan_drawer.dart
import 'package:flutter/cupertino.dart';

class ProtectionPlanDrawer extends StatefulWidget {
  const ProtectionPlanDrawer({super.key});

  @override
  State<ProtectionPlanDrawer> createState() => _ProtectionPlanDrawerState();
}

class _ProtectionPlanDrawerState extends State<ProtectionPlanDrawer> {
  String? _selectedPlan;

  final Map<String, List<Map<String, dynamic>>> _planDetails = {
    '1 Year Protection': [
      {
        'title': 'Hardware Coverage',
        'icon': CupertinoIcons.device_phone_portrait,
        'description':
            'Protection against manufacturer defects and malfunctions',
      },
      {
        'title': 'Accidental Damage',
        'icon': CupertinoIcons.shield_lefthalf_fill,
        'description': 'Coverage for drops, spills, and cracks',
      },
      {
        'title': 'Basic Support',
        'icon': CupertinoIcons.chat_bubble_2,
        'description': '24/7 priority customer support',
      },
    ],
    '2 Year Protection': [
      {
        'title': 'Extended Hardware',
        'icon': CupertinoIcons.device_phone_portrait,
        'description': 'Complete coverage for all hardware issues',
      },
      {
        'title': 'Advanced Protection',
        'icon': CupertinoIcons.shield_lefthalf_fill,
        'description': 'Coverage for all accidents including water damage',
      },
      {
        'title': 'Priority Support',
        'icon': CupertinoIcons.chat_bubble_2,
        'description': 'Premium support with dedicated team',
      },
      {
        'title': 'Express Service',
        'icon': CupertinoIcons.clock,
        'description': 'Faster repairs and replacements',
      },
    ],
    '3 Year Protection': [
      {
        'title': 'Premium Hardware',
        'icon': CupertinoIcons.device_phone_portrait,
        'description': 'Lifetime hardware protection and upgrades',
      },
      {
        'title': 'Complete Protection',
        'icon': CupertinoIcons.shield_lefthalf_fill,
        'description': 'All-inclusive coverage with no limitations',
      },
      {
        'title': 'VIP Support',
        'icon': CupertinoIcons.chat_bubble_2,
        'description': 'Dedicated VIP support team',
      },
      {
        'title': 'Express Service',
        'icon': CupertinoIcons.clock,
        'description': 'Same-day service and replacements',
      },
      {
        'title': 'Bonus Features',
        'icon': CupertinoIcons.gift,
        'description': 'Additional perks and exclusive benefits',
      },
    ],
  };

  final Map<String, List<Map<String, dynamic>>> _protectedParts = {
    '1 Year Protection': [
      {
        'title': 'Screen',
        'icon': CupertinoIcons.device_phone_portrait,
        'description': 'Display & touch',
        'coverage': ['Cracks', 'Dead pixels', 'Touch response']
      },
      {
        'title': 'Battery',
        'icon': CupertinoIcons.battery_100,
        'description': 'Power & charging',
        'coverage': ['Capacity', 'Charging', 'Life cycle']
      },
      {
        'title': 'Buttons',
        'icon': CupertinoIcons.circle,
        'description': 'Physical buttons',
        'coverage': ['Power', 'Volume', 'Home']
      }
    ],
    '2 Year Protection': [
      {
        'title': 'Screen',
        'icon': CupertinoIcons.device_phone_portrait,
        'description': 'Display & touch',
        'coverage': ['Cracks', 'Dead pixels', 'Touch response']
      },
      {
        'title': 'Battery',
        'icon': CupertinoIcons.battery_100,
        'description': 'Power & charging',
        'coverage': ['Capacity', 'Charging', 'Life cycle']
      },
      {
        'title': 'Buttons',
        'icon': CupertinoIcons.circle,
        'description': 'Physical buttons',
        'coverage': ['Power', 'Volume', 'Home']
      },
      {
        'title': 'Cameras',
        'icon': CupertinoIcons.camera,
        'description': 'All cameras',
        'coverage': ['Front', 'Back', 'Sensors']
      },
      {
        'title': 'Speakers',
        'icon': CupertinoIcons.speaker_2,
        'description': 'Audio system',
        'coverage': ['Speaker', 'Microphone']
      }
    ],
    '3 Year Protection': [
      {
        'title': 'Screen',
        'icon': CupertinoIcons.device_phone_portrait,
        'description': 'Display & touch',
        'coverage': ['Cracks', 'Dead pixels', 'Touch response']
      },
      {
        'title': 'Battery',
        'icon': CupertinoIcons.battery_100,
        'description': 'Power & charging',
        'coverage': ['Capacity', 'Charging', 'Life cycle']
      },
      {
        'title': 'Buttons',
        'icon': CupertinoIcons.circle,
        'description': 'Physical buttons',
        'coverage': ['Power', 'Volume', 'Home']
      },
      {
        'title': 'Cameras',
        'icon': CupertinoIcons.camera,
        'description': 'All cameras',
        'coverage': ['Front', 'Back', 'Sensors']
      },
      {
        'title': 'Speakers',
        'icon': CupertinoIcons.speaker_2,
        'description': 'Audio system',
        'coverage': ['Speaker', 'Microphone']
      },
      {
        'title': 'Ports',
        'icon': CupertinoIcons.bolt,
        'description': 'All ports',
        'coverage': ['Charging', 'Audio', 'Data']
      },
      {
        'title': 'Sensors',
        'icon': CupertinoIcons.antenna_radiowaves_left_right,
        'description': 'All sensors',
        'coverage': ['Face ID', 'Touch ID', 'Others']
      },
      {
        'title': 'Wireless',
        'icon': CupertinoIcons.wifi,
        'description': 'Connectivity',
        'coverage': ['WiFi', 'Bluetooth', '5G']
      }
    ],
  };

  Widget _buildPlanOption({
    required String duration,
    required String price,
    required String coverage,
    bool isRecommended = false,
  }) {
    final bool isSelected = _selectedPlan == duration;
    final details = _planDetails[duration] ?? [];
    final parts = _protectedParts[duration] ?? [];

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPlan = isSelected ? null : duration;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFFFF4E5)
                  : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(12),
                bottom: isSelected ? Radius.zero : const Radius.circular(12),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isRecommended)
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
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      isSelected
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      size: 16,
                      color: const Color(0xFF05001E),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  coverage,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              border: Border.all(
                color: const Color(0xFFFDC202),
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Features & Benefits',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ...details.map((detail) => _buildDetailItem(detail)),
                // const Divider(height: 32, color: Color(0xFFEEEEEE)),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Protected Parts',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: parts.length,
                  itemBuilder: (context, index) => _buildPartItem(parts[index]),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDetailItem(Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              detail['icon'],
              color: const Color(0xFFFDC202),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail['title'],
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail['description'],
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartItem(Map<String, dynamic> part) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => _buildPartDetailsPopup(part),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFEEEEEE),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                part['icon'],
                color: const Color(0xFFFDC202),
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              part['title'],
              style: const TextStyle(
                color: Color(0xFF05001E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              part['description'],
              style: TextStyle(
                color: const Color(0xFF05001E).withOpacity(0.6),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartDetailsPopup(Map<String, dynamic> part) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  part['icon'],
                  color: const Color(0xFFFDC202),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      part['title'],
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      part['description'],
                      style: TextStyle(
                        color: const Color(0xFF05001E).withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Coverage Details',
            style: TextStyle(
              color: Color(0xFF05001E),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            (part['coverage'] as List).length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEEAD1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Color(0xFFFDC202),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    part['coverage'][index],
                    style: const TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
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
            'Protection Plan',
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
                  _buildPlanOption(
                    duration: '1 Year Protection',
                    price: 'USD 29.99',
                    coverage:
                        'Comprehensive coverage against damages and defects',
                    isRecommended: true,
                  ),
                  _buildPlanOption(
                    duration: '2 Year Protection',
                    price: 'USD 49.99',
                    coverage: 'Extended coverage with additional benefits',
                  ),
                  _buildPlanOption(
                    duration: '3 Year Protection',
                    price: 'USD 69.99',
                    coverage: 'Maximum protection with premium support',
                  ),
                  const SizedBox(height: 8),
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
                              'Important Information',
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
                          '• Protection starts from the date of purchase\n'
                          '• No deductibles or hidden fees\n'
                          '• Easy claims process\n'
                          '• Transferable coverage\n'
                          '• Cancel anytime',
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
