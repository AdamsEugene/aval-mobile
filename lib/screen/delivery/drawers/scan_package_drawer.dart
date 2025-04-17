// lib/screen/delivery/drawers/scan_package_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart'
    as flutter_widgets; // Prefix for Flutter widgets
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:e_commerce_app/screen/delivery/package_tracking_screen.dart'
    as tracking_screen; // Prefix for tracking screen

class ScanPackageDrawer extends StatefulWidget {
  const ScanPackageDrawer({super.key});

  @override
  State<ScanPackageDrawer> createState() => _ScanPackageDrawerState();
}

class _ScanPackageDrawerState extends State<ScanPackageDrawer> {
  final TextEditingController _codeController = TextEditingController();
  bool _isScanning = true;
  bool _torchOn = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _toggleTorch() {
    setState(() {
      _torchOn = !_torchOn;
    });
  }

  void _toggleScanType() {
    setState(() {
      _isScanning = !_isScanning;
    });
  }

  void _processTrackingCode() {
    if (_codeController.text.isEmpty) {
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
      return;
    }

    // Close drawer
    Navigator.pop(context);

    // Navigate to tracking screen
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => tracking_screen.PackageTrackingScreen(
          trackingId: _codeController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.9,
      // title: 'Scan Package',
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      child: flutter_widgets.Column(
        // Use prefixed Column
        children: [
          // Toggle between barcode scanner and manual entry
          flutter_widgets.Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: flutter_widgets.BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: flutter_widgets.BorderRadius.circular(25),
            ),
            child: flutter_widgets.Row(
              children: [
                flutter_widgets.Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onPressed: _isScanning ? null : _toggleScanType,
                    child: Text(
                      'Scan Barcode',
                      style: TextStyle(
                        color: _isScanning
                            ? const Color(0xFF05001E)
                            : CupertinoColors.systemGrey,
                        fontWeight:
                            _isScanning ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                flutter_widgets.Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onPressed: _isScanning ? _toggleScanType : null,
                    child: Text(
                      'Enter Code',
                      style: TextStyle(
                        color: _isScanning
                            ? CupertinoColors.systemGrey
                            : const Color(0xFF05001E),
                        fontWeight:
                            _isScanning ? FontWeight.normal : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scanner or manual input
          flutter_widgets.Expanded(
            child: _isScanning ? _buildScanner() : _buildManualEntry(),
          ),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    return flutter_widgets.Stack(
      fit: flutter_widgets.StackFit.expand,
      children: [
        // Mock camera/scanner view
        flutter_widgets.Container(
          margin: const EdgeInsets.all(16),
          decoration: flutter_widgets.BoxDecoration(
            color: CupertinoColors.black,
            borderRadius: flutter_widgets.BorderRadius.circular(12),
          ),
          child: flutter_widgets.Center(
            child: flutter_widgets.Column(
              mainAxisAlignment: flutter_widgets.MainAxisAlignment.center,
              children: [
                flutter_widgets.Container(
                  width: 220,
                  height: 220,
                  decoration: flutter_widgets.BoxDecoration(
                    border: flutter_widgets.Border.all(
                      color: CupertinoColors.activeOrange,
                      width: 2,
                    ),
                    borderRadius: flutter_widgets.BorderRadius.circular(12),
                  ),
                  child: const flutter_widgets.Center(
                    child: Icon(
                      CupertinoIcons.viewfinder,
                      size: 60,
                      color: CupertinoColors.activeOrange,
                    ),
                  ),
                ),
                const flutter_widgets.SizedBox(height: 24),
                const Text(
                  'Position the barcode within the frame',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Controls overlay
        flutter_widgets.Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: flutter_widgets.Row(
            mainAxisAlignment: flutter_widgets.MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: _toggleTorch,
                child: flutter_widgets.Container(
                  padding: const EdgeInsets.all(12),
                  decoration: flutter_widgets.BoxDecoration(
                    color: CupertinoColors.black.withOpacity(0.6),
                    shape: flutter_widgets.BoxShape.circle,
                  ),
                  child: Icon(
                    _torchOn
                        ? CupertinoIcons.light_max
                        : CupertinoIcons.light_min,
                    color: CupertinoColors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildManualEntry() {
    return flutter_widgets.Padding(
      padding: const EdgeInsets.all(16),
      child: flutter_widgets.Column(
        crossAxisAlignment: flutter_widgets.CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter Tracking Number',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const flutter_widgets.SizedBox(height: 16),
          CupertinoTextField(
            controller: _codeController,
            placeholder: 'e.g., AVL1234567',
            padding: const EdgeInsets.all(16),
            decoration: flutter_widgets.BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: flutter_widgets.BorderRadius.circular(12),
              border: flutter_widgets.Border.all(
                color: CupertinoColors.systemGrey4,
                width: 1,
              ),
            ),
            prefix: const flutter_widgets.Padding(
              padding: flutter_widgets.EdgeInsets.only(left: 16),
              child: Icon(
                CupertinoIcons.barcode,
                color: Color(0xFF05001E),
              ),
            ),
            clearButtonMode: OverlayVisibilityMode.editing,
            onSubmitted: (_) => _processTrackingCode(),
          ),
          const flutter_widgets.SizedBox(height: 24),
          flutter_widgets.SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: const Color(0xFF05001E),
              borderRadius: flutter_widgets.BorderRadius.circular(12),
              padding: const flutter_widgets.EdgeInsets.symmetric(vertical: 16),
              onPressed: _processTrackingCode,
              child: const Text('Track Package'),
            ),
          ),
          const flutter_widgets.SizedBox(height: 24),
          const Text(
            'Scanning Tips:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const flutter_widgets.SizedBox(height: 8),
          _buildTipItem('Make sure the barcode is clean and undamaged'),
          _buildTipItem('Hold your phone steady about 15-20cm away'),
          _buildTipItem('Scan in well-lit conditions for better results'),
          _buildTipItem('The tracking number is typically under the barcode'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return flutter_widgets.Padding(
      padding: const flutter_widgets.EdgeInsets.only(bottom: 8),
      child: flutter_widgets.Row(
        crossAxisAlignment: flutter_widgets.CrossAxisAlignment.start,
        children: [
          const Icon(
            CupertinoIcons.check_mark_circled,
            color: CupertinoColors.activeOrange,
            size: 18,
          ),
          const flutter_widgets.SizedBox(width: 8),
          flutter_widgets.Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
