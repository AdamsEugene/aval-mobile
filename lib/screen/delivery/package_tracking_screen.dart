import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_commerce_app/screen/delivery/drawers/track_details_drawer.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class PackageTrackingScreen extends StatefulWidget {
  final String trackingId;

  const PackageTrackingScreen({
    super.key,
    required this.trackingId,
  });

  @override
  State<PackageTrackingScreen> createState() => _PackageTrackingScreenState();
}

class _PackageTrackingScreenState extends State<PackageTrackingScreen> {
  final List<Map<String, dynamic>> _trackingSteps = [
    {
      'status': 'Order Placed',
      'location': 'Accra, Ghana',
      'datetime': '2025-04-15 09:30 AM',
      'completed': true,
    },
    {
      'status': 'Picked Up',
      'location': 'Accra, Ghana',
      'datetime': '2025-04-15 11:45 AM',
      'completed': true,
    },
    {
      'status': 'In Transit',
      'location': 'Accra-Kumasi Highway',
      'datetime': '2025-04-16 08:20 AM',
      'completed': true,
    },
    {
      'status': 'Arrived at Facility',
      'location': 'Kumasi, Ghana',
      'datetime': '2025-04-16 03:15 PM',
      'completed': true,
    },
    {
      'status': 'Out for Delivery',
      'location': 'Kumasi, Ghana',
      'datetime': '2025-04-17 10:00 AM',
      'completed': false,
    },
    {
      'status': 'Delivered',
      'location': 'Kumasi, Ghana',
      'datetime': 'Pending',
      'completed': false,
    },
  ];

  final Map<String, dynamic> _packageDetails = {
    'sender': 'John Doe',
    'receiver': 'Jane Smith',
    'origin': 'Accra, Ghana',
    'destination': 'Kumasi, Ghana',
    'weight': '2.5 kg',
    'dimensions': '30 x 20 x 15 cm',
    'type': 'Standard Package',
    'service': 'Express Delivery',
    'expectedDelivery': '2025-04-17',
  };

  final LatLng _originLocation = const LatLng(5.6037, -0.1870); // Accra, Ghana
  final LatLng _destinationLocation =
      const LatLng(6.6884, -1.6244); // Kumasi, Ghana

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            'Tracking Details',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: _getHeaderActions(),
    );
  }

  List<HeaderAction> _getHeaderActions() {
    return [
      HeaderAction(
        icon: CupertinoIcons.info_circle,
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => TrackDetailsDrawer(
              trackingId: widget.trackingId,
              packageDetails: _packageDetails,
            ),
          );
        },
        badgeCount: 3, // Example notification count
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Main Header
            _buildHeader(context),

            // Status Card
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Package Status',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _trackingSteps[4]['status'], // Out for Delivery
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.activeOrange,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                CupertinoColors.activeOrange.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            CupertinoIcons.cube_box,
                            color: CupertinoColors.activeOrange,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoColumn(
                            'Origin',
                            _packageDetails['origin'],
                            CupertinoIcons.location,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: CupertinoColors.systemGrey.withOpacity(0.2),
                        ),
                        Expanded(
                          child: _buildInfoColumn(
                            'Destination',
                            _packageDetails['destination'],
                            CupertinoIcons.location_solid,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoColumn(
                            'Expected Delivery',
                            _packageDetails['expectedDelivery'],
                            CupertinoIcons.calendar,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: CupertinoColors.systemGrey.withOpacity(0.2),
                        ),
                        Expanded(
                          child: _buildInfoColumn(
                            'Delivery Method',
                            _packageDetails['service'],
                            CupertinoIcons.cube_box_fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Tracking Timeline
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Tracking Timeline',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _buildTrackingStep(_trackingSteps[index], index == 0),
                childCount: _trackingSteps.length,
              ),
            ),

            // Delivery Map
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                height: 300,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _originLocation,
                      zoom: 7,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('origin'),
                        position: _originLocation,
                        infoWindow: const InfoWindow(title: 'Origin'),
                      ),
                      Marker(
                        markerId: const MarkerId('destination'),
                        position: _destinationLocation,
                        infoWindow: const InfoWindow(title: 'Destination'),
                      ),
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: CupertinoColors.systemGrey,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTrackingStep(Map<String, dynamic> step, bool isFirst) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline connector
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: step['completed']
                          ? CupertinoColors.activeGreen
                          : CupertinoColors.systemGrey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: step['completed']
                        ? const Icon(
                            CupertinoIcons.checkmark,
                            color: CupertinoColors.white,
                            size: 10,
                          )
                        : null,
                  ),
                  if (!isFirst)
                    Expanded(
                      child: Container(
                        width: 1,
                        color: step['completed']
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemGrey.withOpacity(0.3),
                      ),
                    ),
                ],
              ),
            ),

            // Step details
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 12, bottom: 24),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['status'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: step['completed']
                            ? const Color(0xFF05001E)
                            : CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.location,
                          size: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          step['location'],
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.time,
                          size: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          step['datetime'],
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
            ),
          ],
        ),
      ),
    );
  }
}
