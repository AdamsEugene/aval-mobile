// lib/screens/reseller/scan_reseller_items_screen.dart

import 'package:e_commerce_app/screen/reseller/manual_code_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class ScanResellerItemsScreen extends StatefulWidget {
  const ScanResellerItemsScreen({super.key});

  @override
  State<ScanResellerItemsScreen> createState() =>
      _ScanResellerItemsScreenState();
}

class _ScanResellerItemsScreenState extends State<ScanResellerItemsScreen> {
  bool _isTorchOn = false;
  final bool _isScanning = true;

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Scan Product',
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon:
              _isTorchOn ? CupertinoIcons.light_max : CupertinoIcons.light_min,
          onPressed: () {
            setState(() {
              _isTorchOn = !_isTorchOn;
              // Toggle torch
            });
          },
        ),
      ],
    );
  }

  Widget _buildScannerOverlay() {
    return Stack(
      children: [
        // Camera preview would go here
        Container(
          color: CupertinoColors.black,
          child: const Center(
            child: Text(
              'Camera Preview',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
        ),
        // Scanning frame
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: CupertinoColors.activeBlue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Scanning line animation
        if (_isScanning)
          Center(
            child: Container(
              width: 250,
              height: 2,
              color: CupertinoColors.activeBlue,
            ),
          ),
        // Instructions
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Column(
              children: [
                Text(
                  'Align barcode within frame',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Scanner will automatically detect the barcode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildManualEntry() {
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
          const Text(
            "Can't scan the barcode?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            color: const Color(0xFF05001E),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.keyboard),
                SizedBox(width: 8),
                Text('Enter Code Manually'),
              ],
            ),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => const ManualCodeDrawer(),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _onBarcodeDetected(String barcode) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
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
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/a.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Vendor Name',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: const Color(0xFF05001E),
                    child: const Text('Add to Inventory'),
                    onPressed: () {
                      Navigator.pop(context);
                      // Add to inventory
                    },
                  ),
                ),
                const SizedBox(width: 16),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              // Added CustomScrollView
              slivers: [
                _buildHeader(context),
                SliverFillRemaining(
                  // Added SliverFillRemaining
                  child: _buildScannerOverlay(),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildManualEntry(),
            ),
          ],
        ),
      ),
    );
  }
}
