// lib/widgets/customization/widgets/shared_widgets.dart
import 'package:flutter/cupertino.dart';

class SharedCustomizationWidgets {
  static Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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

  static Widget buildOptionGrid({
    required List<String> options,
    required String? selectedOption,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedOption == option;
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => onSelect(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFFDC202)
                  : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFFDC202)
                    : const Color(0xFFEEEEEE),
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? CupertinoColors.white
                    : const Color(0xFF05001E),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  static Widget buildColorPicker({
    required Color selectedColor,
    required Function(Color) onColorChanged,
  }) {
    final colors = [
      const Color(0xFF05001E),
      const Color(0xFFFDC202),
      const Color(0xFF2ECC71),
      const Color(0xFF3498DB),
      const Color(0xFFE74C3C),
      const Color(0xFF9B59B6),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((color) {
        final isSelected = selectedColor == color;
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => onColorChanged(color),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFFDC202)
                    : const Color(0x00FFFFFF),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(
                    CupertinoIcons.checkmark,
                    color: CupertinoColors.white,
                    size: 20,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }

  static Widget buildQuantitySelector({
    required double quantity,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle('Quantity'),
        Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (quantity > 1) {
                  onChanged(quantity - 1);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.minus,
                  size: 16,
                  color: Color(0xFF05001E),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                quantity.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF05001E),
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => onChanged(quantity + 1),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.plus,
                  size: 16,
                  color: Color(0xFF05001E),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildPriceEstimate({
    required VoidCallback onConfirm,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated Price',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF05001E),
                ),
              ),
              Text(
                'USD 10.00',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF05001E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onConfirm,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDC202),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Confirm Customization',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
