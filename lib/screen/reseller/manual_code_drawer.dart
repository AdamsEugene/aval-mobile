// lib/widgets/reseller/manual_code_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class ManualCodeDrawer extends StatefulWidget {
  const ManualCodeDrawer({super.key});

  @override
  State<ManualCodeDrawer> createState() => _ManualCodeDrawerState();
}

class _ManualCodeDrawerState extends State<ManualCodeDrawer> {
  final TextEditingController _codeController = TextEditingController();
  bool _isSearching = false;

  void _searchProduct() {
    if (_codeController.text.isEmpty) return;

    setState(() => _isSearching = true);

    // Simulate product search
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isSearching = false);
        // Show product found dialog
        _showProductFound();
      }
    });
  }

  void _showProductFound() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Product Found'),
        content: Column(
          children: [
            const SizedBox(height: 16),
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
            const SizedBox(height: 8),
            const Text(
              'Product Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Vendor Name',
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Add to Inventory'),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close drawer
              // Add to inventory logic
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Product Code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the barcode number printed below the barcode',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey.darkColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                CupertinoTextField(
                  controller: _codeController,
                  placeholder: 'Enter barcode number',
                  keyboardType: TextInputType.number,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      CupertinoIcons.barcode,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  suffix: _codeController.text.isNotEmpty
                      ? CupertinoButton(
                          padding: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: CupertinoColors.systemGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _codeController.clear();
                            });
                          },
                        )
                      : null,
                  onChanged: (value) {
                    setState(() {});
                  },
                  onSubmitted: (_) => _searchProduct(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: const Color(0xFF05001E),
                    onPressed: _isSearching || _codeController.text.isEmpty
                        ? null
                        : _searchProduct,
                    child: _isSearching
                        ? const CupertinoActivityIndicator(
                            color: CupertinoColors.white,
                          )
                        : const Text('Search Product'),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tips',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildTip(
                  icon: CupertinoIcons.number,
                  text: 'Enter all digits including check digit',
                ),
                const SizedBox(height: 8),
                _buildTip(
                  icon: CupertinoIcons.eye,
                  text: 'Double-check the number for accuracy',
                ),
                const SizedBox(height: 8),
                _buildTip(
                  icon: CupertinoIcons.camera_viewfinder,
                  text: 'Try scanning again if number is unclear',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF05001E),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: CupertinoColors.systemGrey.darkColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
