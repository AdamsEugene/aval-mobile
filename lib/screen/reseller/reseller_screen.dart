// lib/screens/reseller_screen.dart
import 'package:e_commerce_app/screen/reseller/add_reseller_items_screen.dart';
import 'package:e_commerce_app/screen/reseller/bulk_upload_screen.dart';
import 'package:e_commerce_app/screen/reseller/scan_reseller_items_screen.dart';
import 'package:e_commerce_app/screen/reseller/search_vendor_products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/reseller/analytics_card.dart';
import 'package:e_commerce_app/widgets/reseller/inventory_card.dart';
import 'package:e_commerce_app/widgets/reseller/sales_report_card.dart';

class ResellerScreen extends StatelessWidget {
  const ResellerScreen({super.key});

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            'Dashboard',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.plus_circle,
          onPressed: () {
            _showAddInventoryOptions(context);
          },
        ),
        HeaderAction(
          icon: CupertinoIcons.bell,
          onPressed: () {},
          badgeCount: 2,
        ),
        HeaderAction(
          icon: CupertinoIcons.person_circle,
          onPressed: () {},
        ),
      ],
    );
  }

  void _showAddInventoryOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Add Inventory'),
        message: const Text('Choose how you want to add inventory'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const AddResellerItemsScreen(),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.cube_box, size: 20),
                SizedBox(width: 8),
                Text('Add Single Item'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const BulkUploadScreen(),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.cloud_upload, size: 20),
                SizedBox(width: 8),
                Text('Bulk Upload'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const ScanResellerItemsScreen(),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.barcode_viewfinder, size: 20),
                SizedBox(width: 8),
                Text('Scan Barcode'),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionButton(
            icon: CupertinoIcons.cube_box,
            label: 'Add Item',
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const AddResellerItemsScreen(),
                ),
              );
            },
          ),
          _buildQuickActionButton(
            icon: CupertinoIcons.barcode_viewfinder,
            label: 'Scan',
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const ScanResellerItemsScreen(),
                ),
              );
            },
          ),
          _buildQuickActionButton(
            icon: CupertinoIcons.cloud_upload,
            label: 'Upload',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const BulkUploadScreen(),
                ),
              );
            },
          ),
          _buildQuickActionButton(
            icon: CupertinoIcons.doc_text_search,
            label: 'Search',
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const SearchVendorProductsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: const Color(0xFF05001E),
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, David!',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Here's what's happening with your store today.",
                      style: TextStyle(
                        color: CupertinoColors.systemGrey.darkColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildQuickActions(context),
                    const SizedBox(height: 16),
                    const AnalyticsCard(),
                    const SizedBox(height: 16),
                    const InventoryCard(),
                    const SizedBox(height: 16),
                    const SalesReportCard(),
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
