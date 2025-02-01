// lib/screens/profile_screen.dart
import 'package:e_commerce_app/widgets/shared/profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildInfoField({
    required String label,
    required String value,
    bool isEditable = true,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isEditable)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onTap ?? () {},
                  child: const Icon(
                    CupertinoIcons.pencil,
                    color: CupertinoColors.activeOrange,
                    size: 20,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, String title, String currentValue) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Edit $title'),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CupertinoTextField(
            controller: controller,
            autofocus: true,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Save'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              title: 'My Profile',
              showProfile: true,
              profileImage: const ProfileImage(
                rounded: 48,
                avatar: true,
              ),
              extent: 220,
              imageSize: 70,
              showBackButton: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const ProfileImage(),
              _buildInfoField(
                label: 'Full Name',
                value: 'John Doe',
                onTap: () => _showEditDialog(context, 'Full Name', 'John Doe'),
              ),
              _buildInfoField(
                label: 'Email',
                value: 'john.doe@example.com',
                onTap: () =>
                    _showEditDialog(context, 'Email', 'john.doe@example.com'),
              ),
              _buildInfoField(
                label: 'Phone Number',
                value: '+1 234 567 8900',
                onTap: () =>
                    _showEditDialog(context, 'Phone Number', '+1 234 567 8900'),
              ),
              _buildInfoField(
                label: 'Date of Birth',
                value: 'January 1, 1990',
                onTap: () => _showEditDialog(
                    context, 'Date of Birth', 'January 1, 1990'),
              ),
              _buildInfoField(
                label: 'Gender',
                value: 'Male',
                onTap: () => _showEditDialog(context, 'Gender', 'Male'),
              ),
              _buildInfoField(
                label: 'Member Since',
                value: 'December 2023',
                isEditable: false,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
