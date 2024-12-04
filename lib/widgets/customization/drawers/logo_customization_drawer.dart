// lib/widgets/customization/drawers/logo_customization_drawer.dart
import 'package:e_commerce_app/widgets/customization/widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';

class LogoCustomizationDrawer extends StatefulWidget {
  const LogoCustomizationDrawer({super.key});

  @override
  State<LogoCustomizationDrawer> createState() =>
      _LogoCustomizationDrawerState();
}

class _LogoCustomizationDrawerState extends State<LogoCustomizationDrawer> {
  String? selectedPosition;
  Color selectedColor = const Color(0xFF05001E);
  double quantity = 1;

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
            'Logo Customization',
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
                  // Logo Position Section
                  SharedCustomizationWidgets.buildSectionTitle('Logo Position'),
                  SharedCustomizationWidgets.buildOptionGrid(
                    options: ['Front', 'Back', 'Side', 'Custom'],
                    selectedOption: selectedPosition,
                    onSelect: (value) =>
                        setState(() => selectedPosition = value),
                  ),
                  const SizedBox(height: 24),

                  // Logo Color Section
                  SharedCustomizationWidgets.buildSectionTitle('Logo Color'),
                  SharedCustomizationWidgets.buildColorPicker(
                    selectedColor: selectedColor,
                    onColorChanged: (color) =>
                        setState(() => selectedColor = color),
                  ),
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
                            CupertinoIcons.photo,
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
