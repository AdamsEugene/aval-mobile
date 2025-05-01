// lib/screen/delivery/tabs/history_tab.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/delivery/package_tracking_screen.dart';
import 'package:e_commerce_app/screen/delivery/drawers/filter_history_drawer.dart';
import 'package:e_commerce_app/widgets/shared/custom_segmented_control.dart';

enum HistoryFilter { all, sent, received }

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  HistoryFilter _selectedFilter = HistoryFilter.all;
  final List<Map<String, dynamic>> _deliveryHistory = [
    {
      'id': 'AVL1234567',
      'status': 'Delivered',
      'origin': 'Accra',
      'destination': 'Kumasi',
      'date': '2025-04-15',
      'type': 'sent',
      'amount': 150.00,
    },
    {
      'id': 'AVL8765432',
      'status': 'Delivered',
      'origin': 'Takoradi',
      'destination': 'Accra',
      'date': '2025-04-10',
      'type': 'received',
      'amount': 120.50,
    },
    {
      'id': 'AVL5432109',
      'status': 'In Transit',
      'origin': 'Accra',
      'destination': 'Tamale',
      'date': '2025-04-17',
      'type': 'sent',
      'amount': 200.00,
    },
    {
      'id': 'AVL9876543',
      'status': 'Processing',
      'origin': 'Cape Coast',
      'destination': 'Accra',
      'date': '2025-04-16',
      'type': 'received',
      'amount': 85.75,
    },
    {
      'id': 'AVL5678901',
      'status': 'Cancelled',
      'origin': 'Accra',
      'destination': 'Ho',
      'date': '2025-04-12',
      'type': 'sent',
      'amount': 0.00,
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    if (_selectedFilter == HistoryFilter.all) {
      return _deliveryHistory;
    } else if (_selectedFilter == HistoryFilter.sent) {
      return _deliveryHistory.where((item) => item['type'] == 'sent').toList();
    } else {
      return _deliveryHistory
          .where((item) => item['type'] == 'received')
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header with gradient
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4CAF50), // Green color for history theme
                  Color(0xFF388E3C), // Darker green
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery History',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track your past and ongoing deliveries',
                  style: TextStyle(
                    color: CupertinoColors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                // Custom segment control with improved styling
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomSegmentedControl<HistoryFilter>(
                    groupValue: _selectedFilter,
                    onValueChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedFilter = value);
                      }
                    },
                    children: const {
                      HistoryFilter.all: SegmentItem(
                        text: 'All',
                        icon: CupertinoIcons.square_list,
                      ),
                      HistoryFilter.sent: SegmentItem(
                        text: 'Sent',
                        icon: CupertinoIcons.arrow_up_circle,
                      ),
                      HistoryFilter.received: SegmentItem(
                        text: 'Received',
                        icon: CupertinoIcons.arrow_down_circle,
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Filter section with accent bar
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${filteredHistory.length} Deliveries',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const FilterHistoryDrawer(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.slider_horizontal_3,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // History list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final delivery = filteredHistory[index];
              return _buildHistoryItem(context, delivery);
            },
            childCount: filteredHistory.length,
          ),
        ),
        
        // Empty history state
        SliverToBoxAdapter(
          child: filteredHistory.isEmpty 
              ? Container(
                  margin: const EdgeInsets.all(32),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cube_box,
                        size: 64,
                        color: CupertinoColors.systemGrey.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No deliveries found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your delivery history will appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(height: 24),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, Map<String, dynamic> delivery) {
    Color statusColor;
    IconData statusIcon;

    switch (delivery['status']) {
      case 'Delivered':
        statusColor = CupertinoColors.activeGreen;
        statusIcon = CupertinoIcons.checkmark_circle_fill;
        break;
      case 'In Transit':
        statusColor = CupertinoColors.activeOrange;
        statusIcon = CupertinoIcons.arrow_2_circlepath;
        break;
      case 'Cancelled':
        statusColor = CupertinoColors.destructiveRed;
        statusIcon = CupertinoIcons.xmark_circle_fill;
        break;
      default:
        statusColor = CupertinoColors.systemBlue;
        statusIcon = CupertinoIcons.clock_fill;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PackageTrackingScreen(
              trackingId: delivery['id'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          delivery['id'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          delivery['date'],
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${delivery['amount'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF05001E),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          delivery['status'],
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: CupertinoColors.systemGrey5,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.location,
                              size: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'From: ${delivery['origin']}',
                              style: const TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.location_solid,
                              size: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'To: ${delivery['destination']}',
                              style: const TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: delivery['type'] == 'sent'
                          ? const Color(0xFF4CAF50).withOpacity(0.1)
                          : CupertinoColors.systemGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          delivery['type'] == 'sent'
                              ? CupertinoIcons.arrow_up_circle
                              : CupertinoIcons.arrow_down_circle,
                          size: 16,
                          color: delivery['type'] == 'sent'
                              ? const Color(0xFF4CAF50)
                              : CupertinoColors.systemGreen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          delivery['type'].toUpperCase(),
                          style: TextStyle(
                            color: delivery['type'] == 'sent'
                                ? const Color(0xFF4CAF50)
                                : CupertinoColors.systemGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
