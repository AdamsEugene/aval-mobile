// lib/widgets/drawers/save_for_later_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class SaveForLaterDrawer extends StatelessWidget {
  const SaveForLaterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Save For Later',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: CupertinoColors.systemGrey5,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildSaveOption(
                  context,
                  icon: CupertinoIcons.collections,
                  title: 'My Collections',
                  subtitle: 'Save to an existing collection',
                  onTap: () {
                    // Show collections list
                  },
                ),
                const SizedBox(height: 16),
                _buildSaveOption(
                  context,
                  icon: CupertinoIcons.plus_square,
                  title: 'Create New Collection',
                  subtitle: 'Start a new collection',
                  onTap: () {
                    // Show create collection dialog
                    _showCreateCollectionDialog(context);
                  },
                ),
                const SizedBox(height: 16),
                _buildSaveOption(
                  context,
                  icon: CupertinoIcons.bookmark_fill,
                  title: 'Quick Save',
                  subtitle: 'Save to default collection',
                  onTap: () {
                    // Quick save functionality
                    Navigator.pop(context);
                    // Show success message
                    _showSuccessMessage(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CupertinoColors.systemGrey5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF05001E),
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
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.right_chevron,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateCollectionDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Create Collection'),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CupertinoTextField(
            controller: controller,
            placeholder: 'Collection name',
            autofocus: true,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              // Create collection
              Navigator.pop(context);
              Navigator.pop(context);
              _showSuccessMessage(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: CupertinoColors.activeGreen,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Item saved successfully',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Done'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
