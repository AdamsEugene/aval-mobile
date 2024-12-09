// lib/screens/reseller/bulk_upload_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class BulkUploadScreen extends StatefulWidget {
  const BulkUploadScreen({super.key});

  @override
  State<BulkUploadScreen> createState() => _BulkUploadScreenState();
}

class _BulkUploadScreenState extends State<BulkUploadScreen> {
  final TextEditingController _codesController = TextEditingController();
  bool _isProcessing = false;
  List<String> _processedCodes = [];
  bool _showPreview = false;

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
            'Bulk Upload',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
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

  void _handleUpload() {
    setState(() {
      _isProcessing = true;
      _processedCodes = _codesController.text
          .split('\n')
          .where((code) => code.trim().isNotEmpty)
          .toList();
    });

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _showPreview = true;
        });
      }
    });
  }

  Widget _buildUploadSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed: Made the Row wrap and adjusted layout
          Wrap(
            spacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Handle file upload
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF05001E),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // Added this
                    children: [
                      Icon(
                        CupertinoIcons.doc_text,
                        color: Color(0xFF05001E),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Upload CSV/Excel',
                        style: TextStyle(
                          color: Color(0xFF05001E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'or paste codes below',
                style: TextStyle(
                  color: CupertinoColors.systemGrey.darkColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CupertinoTextField(
            controller: _codesController,
            placeholder: 'Enter product codes (one per line)',
            minLines: 6,
            maxLines: 10,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                CupertinoIcons.info_circle,
                size: 16,
                color: CupertinoColors.systemGrey,
              ),
              const SizedBox(width: 8),
              Text(
                'Enter one product code per line',
                style: TextStyle(
                  color: CupertinoColors.systemGrey.darkColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: const Color(0xFF05001E),
              onPressed: _codesController.text.isEmpty ? null : _handleUpload,
              child: _isProcessing
                  ? const CupertinoActivityIndicator(
                      color: CupertinoColors.white,
                    )
                  : const Text('Process Codes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection() {
    if (!_showPreview) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${_processedCodes.length} items',
                style: TextStyle(
                  color: CupertinoColors.systemGrey.darkColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _processedCodes.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.barcode,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _processedCodes[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: const Color(0xFF05001E),
              onPressed: () {
                // Handle adding to inventory
              },
              child: const Text('Add All to Inventory'),
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
              child: Column(
                children: [
                  _buildUploadSection(),
                  _buildPreviewSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codesController.dispose();
    super.dispose();
  }
}
