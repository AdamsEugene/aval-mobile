// lib/screen/delivery/tabs/send_package_tab.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screen/delivery/drawers/local_delivery_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/cross_region_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/ecommerce_shipping_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/consolidated_delivery_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/special_transport_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/route_service_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/full_vehicle_logistics_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/special_goods_drawer.dart';
import 'package:e_commerce_app/widgets/delivery/package_form.dart';

class SendPackageTab extends StatelessWidget {
  const SendPackageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF9966),
                  Color(0xFFFF5E62),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5E62).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Send a Package',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fast, reliable delivery to any location',
                  style: TextStyle(
                    color: CupertinoColors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickOption(
                      context: context,
                      icon: CupertinoIcons.cube_box,
                      label: 'Local',
                      onTap: () {
                        // Show local delivery drawer
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => const LocalDeliveryDrawer(),
                        );
                      },
                    ),
                    _buildQuickOption(
                      context: context,
                      icon: CupertinoIcons.location_north,
                      label: 'Cross-Region',
                      onTap: () {
                        // Show cross-region delivery drawer
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => const CrossRegionDrawer(),
                        );
                      },
                    ),
                    _buildQuickOption(
                      context: context,
                      icon: CupertinoIcons.bag,
                      label: 'E-commerce',
                      onTap: () {
                        // Show e-commerce shipping drawer
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => const EcommerceShippingDrawer(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // New Specialized Delivery Options Section
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Specialized Delivery Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
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
                _buildSpecializedOption(
                  context: context,
                  icon: CupertinoIcons.shield_fill,
                  title: 'Consolidated Delivery',
                  description: 'Special delivery cases with optimal security',
                  color: const Color(0xFF4CAF50),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.systemGrey5,
                ),
                _buildSpecializedOption(
                  context: context,
                  icon: CupertinoIcons.map_fill,
                  title: 'Route Service',
                  description: 'Service picks packages along route (slow and cheap)',
                  color: const Color(0xFF2196F3),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.systemGrey5,
                ),
                _buildSpecializedOption(
                  context: context,
                  icon: CupertinoIcons.car_fill,
                  title: 'Full Vehicle Logistics',
                  description: 'Request a whole car or van for goods transportation',
                  color: const Color(0xFF9C27B0),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.systemGrey5,
                ),
                _buildSpecializedOption(
                  context: context,
                  icon: CupertinoIcons.bandage_fill,
                  title: 'Special Goods',
                  description: 'Medical deliveries, valuable and delicate items',
                  color: const Color(0xFFFF5722),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.systemGrey5,
                ),
                _buildSpecializedOption(
                  context: context,
                  icon: CupertinoIcons.person_2_fill,
                  title: 'Special Transport',
                  description: 'Ambulance, pregnant women, school kids, elderly, disabled',
                  color: const Color(0xFFFFC107),
                ),
              ],
            ),
          ),
        ),
        
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Package Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
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
            child: const PackageForm(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: CupertinoButton(
              color: const Color(0xFF05001E),
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () {
                // Submit form
                _showOrderSuccessDialog(context);
              },
              child: const Text(
                'Continue to Payment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecializedOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Show appropriate drawer based on title
        switch (title) {
          case 'Consolidated Delivery':
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const ConsolidatedDeliveryDrawer(),
            );
            break;
          case 'Special Transport':
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const SpecialTransportDrawer(),
            );
            break;
          case 'Route Service':
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const RouteServiceDrawer(),
            );
            break;
          case 'Full Vehicle Logistics':
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const FullVehicleLogisticsDrawer(),
            );
            break;
          case 'Special Goods':
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const SpecialGoodsDrawer(),
            );
            break;
          default:
            // Show under development message for other options
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text('Coming Soon'),
                content: Text('$title feature is under development'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
        }
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
            ),
            onPressed: null, // The gesture detector handles the tap
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF5E62),
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Order Placed'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.activeGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.check_mark_circled,
                color: CupertinoColors.activeGreen,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your package has been scheduled for pickup.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tracking ID: AVL12345678',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('View Details'),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Navigate to tracking screen
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
