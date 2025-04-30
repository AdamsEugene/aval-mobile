// lib/screen/delivery/drawers/package_size_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class PackageSizeDrawer extends StatefulWidget {
  final Function(String) onSelect;

  const PackageSizeDrawer({
    super.key,
    required this.onSelect,
  });

  @override
  State<PackageSizeDrawer> createState() => _PackageSizeDrawerState();
}

class _PackageSizeDrawerState extends State<PackageSizeDrawer> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _packageSizes = [
    {
      'name': 'Extra Small',
      'dimensions': '10 x 10 x 10 cm',
      'weight': 'Up to 1 kg',
      'price': '₵8.00',
      'example': 'Document or small item like a phone',
      'icon': CupertinoIcons.doc_text,
    },
    {
      'name': 'Small',
      'dimensions': '25 x 20 x 15 cm',
      'weight': 'Up to 3 kg',
      'price': '₵15.00',
      'example': 'Shoes, books, small accessories',
      'icon': CupertinoIcons.cube_box,
    },
    {
      'name': 'Medium',
      'dimensions': '40 x 30 x 20 cm',
      'weight': 'Up to 5 kg',
      'price': '₵25.00',
      'example': 'Clothing, small electronics',
      'icon': CupertinoIcons.cube,
    },
    {
      'name': 'Large',
      'dimensions': '60 x 40 x 30 cm',
      'weight': 'Up to 10 kg',
      'price': '₵35.00',
      'example': 'Multiple items, small appliances',
      'icon': CupertinoIcons.bag_fill,
    },
    {
      'name': 'Extra Large',
      'dimensions': '80 x 60 x 40 cm',
      'weight': 'Up to 20 kg',
      'price': '₵50.00',
      'example': 'Large appliances, furniture parts',
      'icon': CupertinoIcons.cart_fill,
    },
    {
      'name': 'Custom Size',
      'dimensions': 'Custom',
      'weight': 'Custom',
      'price': 'Calculate',
      'example': 'Oversized or irregular items',
      'icon': CupertinoIcons.arrow_3_trianglepath,
    },
  ];

  void _selectPackageSize(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _confirmSelection() {
    final selectedSize = _packageSizes[_selectedIndex];
    widget.onSelect(_selectedIndex == 5
        ? 'Custom Size'
        : '${selectedSize['name']} (${selectedSize['dimensions']})');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.8,
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Select',
        textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: _confirmSelection,
      ),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Choose the size that fits your package',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF05001E),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _packageSizes.length,
                  itemBuilder: (context, index) {
                    final packageSize = _packageSizes[index];
                    final isSelected = index == _selectedIndex;
                    final isCustom = index == 5;

                    return GestureDetector(
                      onTap: () => _selectPackageSize(index),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF8F0E3)
                              : CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? CupertinoColors.activeOrange
                                : CupertinoColors.systemGrey5,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? CupertinoColors.activeOrange
                                        .withOpacity(0.1)
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                packageSize['icon'],
                                color: isSelected
                                    ? CupertinoColors.activeOrange
                                    : const Color(0xFF05001E),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    packageSize['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? CupertinoColors.activeOrange
                                          : const Color(0xFF05001E),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (!isCustom) ...[
                                    Text(
                                      'Dimensions: ${packageSize['dimensions']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors
                                            .systemGrey.darkColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Weight: ${packageSize['weight']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors
                                            .systemGrey.darkColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                  ],
                                  Text(
                                    'Example: ${packageSize['example']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          CupertinoColors.systemGrey.darkColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  packageSize['price'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? CupertinoColors.activeOrange
                                        : const Color(0xFF05001E),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                CupertinoRadio<int>(
                                  value: index,
                                  groupValue: _selectedIndex,
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      _selectPackageSize(value);
                                    }
                                  },
                                  activeColor: CupertinoColors.activeOrange,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (_selectedIndex != 5)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Size Visualization',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF05001E),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(5, (index) {
                                final scale = (index + 1) / 5;
                                final isCurrentSize = index == _selectedIndex;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 40 + (scale * 40),
                                      height: 40 + (scale * 60),
                                      decoration: BoxDecoration(
                                        color: isCurrentSize
                                            ? CupertinoColors.activeOrange
                                            : const Color(0xFFE0E0E0),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _packageSizes[index]['name']
                                          .split(' ')
                                          .last,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isCurrentSize
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        color: isCurrentSize
                                            ? CupertinoColors.activeOrange
                                            : CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _confirmSelection,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF05001E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Confirm Selection',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CupertinoRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color activeColor;

  const CupertinoRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor = CupertinoColors.activeBlue,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? activeColor : CupertinoColors.systemGrey3,
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
