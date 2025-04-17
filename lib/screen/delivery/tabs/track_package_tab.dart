// lib/screen/delivery/tabs/track_package_tab.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screen/delivery/package_tracking_screen.dart';

class TrackPackageTab extends StatefulWidget {
  const TrackPackageTab({super.key});

  @override
  State<TrackPackageTab> createState() => _TrackPackageTabState();
}

class _TrackPackageTabState extends State<TrackPackageTab> {
  final TextEditingController _trackingController = TextEditingController();
  final List<Map<String, dynamic>> _recentTrackings = [
    {
      'id': 'AVL1234567',
      'status': 'In Transit',
      'origin': 'Accra',
      'destination': 'Kumasi',
      'date': '2025-04-15',
    },
    {
      'id': 'AVL9876543',
      'status': 'Delivered',
      'origin': 'Accra',
      'destination': 'Takoradi',
      'date': '2025-04-10',
    },
    {
      'id': 'AVL5678901',
      'status': 'Processing',
      'origin': 'Accra',
      'destination': 'Tamale',
      'date': '2025-04-17',
    },
  ];

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  void _trackPackage() {
    if (_trackingController.text.isNotEmpty) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => PackageTrackingScreen(
            trackingId: _trackingController.text,
          ),
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Missing Information'),
          content: const Text('Please enter a tracking number.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF05001E),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF05001E).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Track Your Package',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: _trackingController,
                  placeholder: 'Enter tracking number',
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _trackPackage,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Track',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Recent Trackings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final tracking = _recentTrackings[index];
              return _buildTrackingItem(context, tracking);
            },
            childCount: _recentTrackings.length,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingItem(
      BuildContext context, Map<String, dynamic> tracking) {
    Color statusColor;

    switch (tracking['status']) {
      case 'Delivered':
        statusColor = CupertinoColors.activeGreen;
        break;
      case 'In Transit':
        statusColor = CupertinoColors.activeOrange;
        break;
      default:
        statusColor = CupertinoColors.systemBlue;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PackageTrackingScreen(
              trackingId: tracking['id'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tracking['id'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                    tracking['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.location,
                  size: 16,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  tracking['origin'],
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.arrow_right,
                  size: 14,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.location_solid,
                  size: 16,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  tracking['destination'],
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.calendar,
                  size: 16,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  tracking['date'],
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
