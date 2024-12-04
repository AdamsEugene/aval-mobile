// lib/widgets/customization/drawers/graphics_customization_drawer.dart
import 'package:e_commerce_app/widgets/customization/base/base_customization_drawer.dart';
import 'package:e_commerce_app/widgets/customization/widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import '../models/customization_type.dart';

class GraphicsCustomizationDrawer extends BaseCustomizationDrawer {
  const GraphicsCustomizationDrawer({super.key})
      : super(type: CustomizationType.graphics);

  @override
  State<GraphicsCustomizationDrawer> createState() =>
      _GraphicsCustomizationDrawerState();
}

class _GraphicsCustomizationDrawerState
    extends State<GraphicsCustomizationDrawer> {
  String? selectedGraphicsStyle;
  String? selectedGraphicsPlacement;
  Color selectedGraphicsColor = const Color(0xFF05001E);
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
            'Graphics Customization',
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
                  // Graphics Style Section
                  SharedCustomizationWidgets.buildSectionTitle(
                      'Graphics Style'),
                  SharedCustomizationWidgets.buildOptionGrid(
                    options: ['Minimal', 'Classic', 'Modern', 'Custom'],
                    selectedOption: selectedGraphicsStyle,
                    onSelect: (value) =>
                        setState(() => selectedGraphicsStyle = value),
                  ),
                  const SizedBox(height: 24),

                  // Placement Section
                  SharedCustomizationWidgets.buildSectionTitle('Placement'),
                  SharedCustomizationWidgets.buildOptionGrid(
                    options: ['Front', 'Back', 'All-over', 'Custom'],
                    selectedOption: selectedGraphicsPlacement,
                    onSelect: (value) =>
                        setState(() => selectedGraphicsPlacement = value),
                  ),
                  const SizedBox(height: 24),

                  // Color Section
                  SharedCustomizationWidgets.buildSectionTitle(
                      'Graphics Color'),
                  SharedCustomizationWidgets.buildColorPicker(
                    selectedColor: selectedGraphicsColor,
                    onColorChanged: (color) =>
                        setState(() => selectedGraphicsColor = color),
                  ),
                  const SizedBox(height: 24),

                  // Quantity Section
                  SharedCustomizationWidgets.buildQuantitySelector(
                    quantity: quantity,
                    onChanged: (value) => setState(() => quantity = value),
                  ),
                  const SizedBox(height: 24),

                  // Preview Section (Optional)
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

                  // Price Estimate and Confirm Button
                  SharedCustomizationWidgets.buildPriceEstimate(
                    onConfirm: () {
                      // Handle graphics customization confirmation
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
