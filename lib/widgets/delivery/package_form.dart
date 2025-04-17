// lib/widgets/delivery/package_form.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screen/delivery/drawers/package_size_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/package_type_drawer.dart';
import 'package:e_commerce_app/screen/delivery/drawers/address_book_drawer.dart';

class PackageForm extends StatefulWidget {
  const PackageForm({super.key});

  @override
  State<PackageForm> createState() => _PackageFormState();
}

class _PackageFormState extends State<PackageForm> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();
  String _selectedPackageType = 'Select Package Type';
  String _selectedPackageSize = 'Select Package Size';
  String _pickupAddress = 'Select Pickup Address';
  String _deliveryAddress = 'Select Delivery Address';

  @override
  void dispose() {
    _weightController.dispose();
    _dimensionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Package Type Selection
        _buildSectionTitle('Package Information'),
        _buildSelectionField(
          label: _selectedPackageType,
          icon: CupertinoIcons.cube_box,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => PackageTypeDrawer(
                onSelect: (type) {
                  setState(() {
                    _selectedPackageType = type;
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Package Size Selection
        _buildSelectionField(
          label: _selectedPackageSize,
          icon: CupertinoIcons.resize,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => PackageSizeDrawer(
                onSelect: (size) {
                  setState(() {
                    _selectedPackageSize = size;
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Weight
        _buildTextField(
          controller: _weightController,
          label: 'Weight (kg)',
          icon: CupertinoIcons.arrow_down_circle,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        // Dimensions
        _buildTextField(
          controller: _dimensionsController,
          label: 'Dimensions (L x W x H) cm',
          icon: CupertinoIcons.rectangle_3_offgrid,
          keyboardType: TextInputType.text,
          placeholder: 'e.g. 30 x 20 x 15',
        ),
        const SizedBox(height: 24),

        // Addresses
        _buildSectionTitle('Pickup & Delivery'),
        _buildSelectionField(
          label: _pickupAddress,
          icon: CupertinoIcons.location,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => AddressBookDrawer(
                title: 'Select Pickup Address',
                onSelect: (address) {
                  setState(() {
                    _pickupAddress = address;
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        _buildSelectionField(
          label: _deliveryAddress,
          icon: CupertinoIcons.location_solid,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => AddressBookDrawer(
                title: 'Select Delivery Address',
                onSelect: (address) {
                  setState(() {
                    _deliveryAddress = address;
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF05001E),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: CupertinoColors.systemGrey.darkColor,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: controller,
          prefix: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              icon,
              color: const Color(0xFF05001E),
              size: 20,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CupertinoColors.systemGrey4,
              width: 1,
            ),
          ),
          placeholder: placeholder,
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildSelectionField({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: CupertinoColors.systemGrey4,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF05001E),
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: label.contains('Select')
                      ? CupertinoColors.systemGrey
                      : const Color(0xFF05001E),
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              color: CupertinoColors.systemGrey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
