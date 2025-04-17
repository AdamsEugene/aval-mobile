// lib/screen/delivery/drawers/track_details_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class TrackDetailsDrawer extends StatelessWidget {
  final String trackingId;
  final Map<String, dynamic> packageDetails;

  const TrackDetailsDrawer({
    super.key,
    required this.trackingId,
    required this.packageDetails,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.8,
      // title: 'Package Details',
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        icon: const Icon(
          CupertinoIcons.share,
          color: CupertinoColors.activeBlue,
        ),
        onTap: () {
          // Handle share
          Navigator.pop(context);
          // Show share dialog
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Share Tracking'),
              content:
                  const Text('Share this tracking information with others?'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: const Text('Share'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tracking ID section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0E3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.activeOrange,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tracking Number',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.activeOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        onPressed: () {
                          // Copy tracking number
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Tracking Number Copied'),
                              content: Text(
                                  '$trackingId has been copied to clipboard.'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(
                              CupertinoIcons.doc_on_doc,
                              color: CupertinoColors.activeOrange,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Copy',
                              style: TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.activeOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        trackingId,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.activeOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Express',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.activeOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Package information
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _buildSectionHeader('Package Information'),
            ),

            _buildInfoRow(
              label: 'Service Type',
              value: packageDetails['service'] ?? 'N/A',
              icon: CupertinoIcons.cube_box,
            ),

            _buildInfoRow(
              label: 'Package Type',
              value: packageDetails['type'] ?? 'N/A',
              icon: CupertinoIcons.archivebox,
            ),

            _buildInfoRow(
              label: 'Weight',
              value: packageDetails['weight'] ?? 'N/A',
              icon: CupertinoIcons.arrow_down_circle,
            ),

            _buildInfoRow(
              label: 'Dimensions',
              value: packageDetails['dimensions'] ?? 'N/A',
              icon: CupertinoIcons.rectangle_3_offgrid,
            ),

            // Location information
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: _buildSectionHeader('Locations'),
            ),

            _buildInfoRow(
              label: 'Origin',
              value: packageDetails['origin'] ?? 'N/A',
              icon: CupertinoIcons.location,
            ),

            _buildInfoRow(
              label: 'Destination',
              value: packageDetails['destination'] ?? 'N/A',
              icon: CupertinoIcons.location_solid,
            ),

            // Contact information
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: _buildSectionHeader('Contact Information'),
            ),

            _buildInfoRow(
              label: 'Sender',
              value: packageDetails['sender'] ?? 'N/A',
              icon: CupertinoIcons.person,
            ),

            _buildInfoRow(
              label: 'Receiver',
              value: packageDetails['receiver'] ?? 'N/A',
              icon: CupertinoIcons.person_2,
            ),

            // Additional information
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: _buildSectionHeader('Delivery Information'),
            ),

            _buildInfoRow(
              label: 'Expected Delivery',
              value: packageDetails['expectedDelivery'] ?? 'N/A',
              icon: CupertinoIcons.calendar,
            ),

            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.systemBlue,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.info,
                      color: CupertinoColors.systemBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need More Help?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Contact our support team for any questions about this delivery.',
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Contact support
                  Navigator.pop(context);
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Contact Support'),
                      content: const Text(
                          'Would you like to call or message our support team?'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Call'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Message'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF05001E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Contact Support',
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

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF05001E),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey.darkColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF05001E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
