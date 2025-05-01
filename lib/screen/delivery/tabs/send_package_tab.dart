// lib/screen/delivery/tabs/send_package_tab.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/delivery/drawers/local_delivery_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/cross_region_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/ecommerce_shipping_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/consolidated_delivery_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/special_transport_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/route_service_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/full_vehicle_logistics_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/special_goods_drawer.dart';
import 'package:e_commerce_app/widgets/delivery/package_form.dart';
import 'package:e_commerce_app/screen/delivery/delivery_service_selection_screen.dart';

class SendPackageTab extends StatefulWidget {
  const SendPackageTab({super.key});

  @override
  State<SendPackageTab> createState() => _SendPackageTabState();
}

class _SendPackageTabState extends State<SendPackageTab> {
  // Selected delivery service
  DeliveryServiceProvider? _selectedService;
  
  @override
  void initState() {
    super.initState();
    // Schedule showing the service selection screen after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedService == null) {
        _showServiceSelectionScreen();
      }
    });
  }

  // Show service selection screen and handle selection
  Future<void> _showServiceSelectionScreen() async {
    final result = await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const DeliveryServiceSelectionScreen(),
        fullscreenDialog: true,
      ),
    );
    
    if (result != null && result is DeliveryServiceProvider) {
      setState(() {
        _selectedService = result;
      });

      // Show a confirmation snackbar
      final snackBar = CupertinoTheme(
        data: const CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        child: CupertinoPopupSurface(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _selectedService!.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _selectedService!.name.substring(0, 1),
                      style: TextStyle(
                        color: _selectedService!.color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Delivery Service Selected',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_selectedService!.name} - ${_selectedService!.deliveryTime}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showServiceSelectionScreen(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Show a toast at the bottom
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 80),
          child: snackBar,
        ),
      );
    } else if (_selectedService == null) {
      // If service is still null and user cancelled selection,
      // show service selection again to make it mandatory
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showServiceSelectionScreen();
      });
    }
  }
  
  // Handle opening specialized delivery drawers
  void _showSpecializedDelivery(String type) async {
    // If no service is selected, show the service selection screen first
    if (_selectedService == null) {
      await _showServiceSelectionScreen();
      
      // If user cancelled service selection, return
      if (_selectedService == null) {
        return;
      }
    }
    
    // Show the appropriate drawer based on type
    switch (type) {
      case 'consolidated':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const ConsolidatedDeliveryDrawer(),
        );
        break;
      case 'route':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const RouteServiceDrawer(),
        );
        break;
      case 'logistics':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const FullVehicleLogisticsDrawer(),
        );
        break;
      case 'special_goods':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const SpecialGoodsDrawer(),
        );
        break;
      case 'special_transport':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const SpecialTransportDrawer(),
        );
        break;
      case 'local':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const LocalDeliveryDrawer(),
        );
        break;
      case 'cross_region':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const CrossRegionDrawer(),
        );
        break;
      case 'ecommerce':
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const EcommerceShippingDrawer(),
        );
        break;
    }
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: CupertinoColors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializedOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    String type = '',
  }) {
    return GestureDetector(
      onTap: () => _showSpecializedDelivery(type),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF05001E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF05001E).withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            color: CupertinoColors.systemGrey,
            size: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If no service is selected, show a placeholder loading state
    if (_selectedService == null) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    
    // Otherwise, show the normal UI with selected service
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
                      onTap: () => _showSpecializedDelivery('local'),
                    ),
                    _buildQuickOption(
                      context: context,
                      icon: CupertinoIcons.location_north,
                      label: 'Cross-Region',
                      onTap: () => _showSpecializedDelivery('cross_region'),
                    ),
                    _buildQuickOption(
                      context: context,
                      icon: CupertinoIcons.bag,
                      label: 'E-commerce',
                      onTap: () => _showSpecializedDelivery('ecommerce'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Current Delivery Service Section
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _selectedService!.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedService!.color.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Service logo placeholder
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _selectedService!.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _selectedService!.name.substring(0, 1),
                      style: TextStyle(
                        color: _selectedService!.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Service details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Delivery Partner',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF05001E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedService!.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF05001E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Delivery time: ${_selectedService!.deliveryTime}',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xFF05001E).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Change button
                GestureDetector(
                  onTap: _showServiceSelectionScreen,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedService!.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: _selectedService!.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Specialized Delivery Options Section
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5E62),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Specialized Delivery Options',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                  type: 'consolidated',
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
                  type: 'route',
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
                  type: 'logistics',
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
                  type: 'special_goods',
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
                  type: 'special_transport',
                ),
              ],
            ),
          ),
        ),
        
        // Package Details Section with improved styling
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5E62),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Package Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
            child: const PackageForm(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF05001E),
                    Color(0xFF120046),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF05001E).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                onPressed: () {
                  // Submit form
                  _showOrderSuccessDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      color: CupertinoColors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Continue to Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
