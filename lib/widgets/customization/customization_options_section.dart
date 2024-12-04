// lib/widgets/customization/customization_options_section.dart
import 'package:flutter/cupertino.dart';
import 'drawers/logo_customization_drawer.dart';
import 'drawers/package_customization_drawer.dart';
import 'drawers/graphics_customization_drawer.dart';
import 'models/customization_type.dart';

class CustomizationOptionsSection extends StatelessWidget {
  const CustomizationOptionsSection({super.key});

  Widget _buildCustomizationTile({
    required String title,
    required IconData icon,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF05001E),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Color(0xFF05001E),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomizationDrawer(BuildContext context, CustomizationType type) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        switch (type) {
          case CustomizationType.logo:
            return const LogoCustomizationDrawer();
          case CustomizationType.package:
            return const PackageCustomizationDrawer();
          case CustomizationType.graphics:
            return const GraphicsCustomizationDrawer();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
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
          Row(
            children: [
              const Text(
                'Customization Options',
                style: TextStyle(
                  color: Color(0xFF05001E),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEAD1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Available',
                  style: TextStyle(
                    color: Color(0xFFFDC202),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCustomizationTile(
            title: 'Logo Customization',
            icon: CupertinoIcons.paintbrush_fill,
            context: context,
            onTap: () =>
                _showCustomizationDrawer(context, CustomizationType.logo),
          ),
          _buildCustomizationTile(
            title: 'Package Customization',
            icon: CupertinoIcons.gift_fill,
            context: context,
            onTap: () =>
                _showCustomizationDrawer(context, CustomizationType.package),
          ),
          _buildCustomizationTile(
            title: 'Graphics Customization',
            icon: CupertinoIcons.pencil_outline,
            context: context,
            onTap: () =>
                _showCustomizationDrawer(context, CustomizationType.graphics),
          ),
        ],
      ),
    );
  }
}
