// lib/widgets/customization/drawers/package_customization_drawer.dart
import 'package:e_commerce_app/widgets/customization/base/base_customization_drawer.dart';
import 'package:e_commerce_app/widgets/customization/models/customization_type.dart';
import 'package:e_commerce_app/widgets/customization/widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';

class PackageCustomizationDrawer extends BaseCustomizationDrawer {
  const PackageCustomizationDrawer({super.key})
      : super(type: CustomizationType.package);

  @override
  State<PackageCustomizationDrawer> createState() =>
      _PackageCustomizationDrawerState();
}

class _PackageCustomizationDrawerState
    extends State<PackageCustomizationDrawer> {
  String? selectedPackageType;
  String? selectedPackageMaterial;
  bool includeGiftWrap = false;
  double quantity = 1;

  Widget _buildGiftWrapToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gift Wrapping',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF05001E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Add special gift wrapping',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF05001E).withOpacity(0.6),
                ),
              ),
            ],
          ),
          CupertinoSwitch(
            value: includeGiftWrap,
            activeColor: CupertinoColors.activeOrange,
            onChanged: (value) => setState(() => includeGiftWrap = value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Drawer Handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Package Customization',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 24),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package Type Section
                  SharedCustomizationWidgets.buildSectionTitle('Package Type'),
                  SharedCustomizationWidgets.buildOptionGrid(
                    options: [
                      'Standard Box',
                      'Gift Box',
                      'Luxury Box',
                      'Custom Box'
                    ],
                    selectedOption: selectedPackageType,
                    onSelect: (value) =>
                        setState(() => selectedPackageType = value),
                  ),
                  const SizedBox(height: 24),

                  // Material Section
                  SharedCustomizationWidgets.buildSectionTitle(
                      'Package Material'),
                  SharedCustomizationWidgets.buildOptionGrid(
                    options: [
                      'Cardboard',
                      'Recycled',
                      'Premium',
                      'Eco-friendly'
                    ],
                    selectedOption: selectedPackageMaterial,
                    onSelect: (value) =>
                        setState(() => selectedPackageMaterial = value),
                  ),
                  const SizedBox(height: 24),

                  // Gift Wrap Toggle
                  _buildGiftWrapToggle(),
                  const SizedBox(height: 24),

                  // Preview Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SharedCustomizationWidgets.buildSectionTitle('Preview'),
                        const Center(
                          child: Icon(
                            CupertinoIcons.gift,
                            size: 100,
                            color: Color(0xFFDDDDDD),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            'Preview will be available after confirmation',
                            style: TextStyle(
                              color: Color(0xFF05001E),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quantity Section
                  SharedCustomizationWidgets.buildQuantitySelector(
                    quantity: quantity,
                    onChanged: (value) => setState(() => quantity = value),
                  ),
                  const SizedBox(height: 24),

                  // Price Estimate and Confirm Button
                  SharedCustomizationWidgets.buildPriceEstimate(
                    onConfirm: () {
                      // Handle confirmation
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
