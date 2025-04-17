// lib/screen/delivery/drawers/package_type_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class PackageTypeDrawer extends StatefulWidget {
  final Function(String) onSelect;

  const PackageTypeDrawer({
    super.key,
    required this.onSelect,
  });

  @override
  State<PackageTypeDrawer> createState() => _PackageTypeDrawerState();
}

class _PackageTypeDrawerState extends State<PackageTypeDrawer> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _packageTypes = [
    {
      'name': 'Document',
      'icon': CupertinoIcons.doc,
      'description': 'Letters, papers, photos',
      'examples': 'Letters, documents, certificates, photos',
      'restrictions': 'No valuables, cash or negotiable instruments',
    },
    {
      'name': 'Small Package',
      'icon': CupertinoIcons.cube_box,
      'description': 'Small items up to 2kg',
      'examples': 'Books, clothing, accessories, small electronics',
      'restrictions': 'Nothing perishable or fragile without protection',
    },
    {
      'name': 'Medium Package',
      'icon': CupertinoIcons.cube,
      'description': 'Items between 2-5kg',
      'examples': 'Home goods, medium electronics, shoes',
      'restrictions': 'Nothing hazardous or flammable',
    },
    {
      'name': 'Large Package',
      'icon': CupertinoIcons.cart,
      'description': 'Items between 5-10kg',
      'examples': 'Small appliances, multiple items, bulky goods',
      'restrictions': 'Subject to additional handling fee',
    },
    {
      'name': 'Special Package',
      'icon': CupertinoIcons.exclamationmark_shield,
      'description': 'Fragile or oversized items',
      'examples': 'Glass, electronics, artwork, musical instruments',
      'restrictions': 'Special handling fee applies, limited availability',
    },
  ];

  void _selectPackageType(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _confirmSelection() {
    widget.onSelect(_packageTypes[_selectedIndex]['name']);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.8,
      // title: 'Select Package Type',
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
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _packageTypes.length,
              itemBuilder: (context, index) {
                final packageType = _packageTypes[index];
                final isSelected = index == _selectedIndex;

                return GestureDetector(
                  onTap: () => _selectPackageType(index),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                    child: Column(
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.all(16),
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
                                  packageType['icon'],
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
                                      packageType['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? CupertinoColors.activeOrange
                                            : const Color(0xFF05001E),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      packageType['description'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors
                                            .systemGrey.darkColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CupertinoRadio<int>(
                                value: index,
                                groupValue: _selectedIndex,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    _selectPackageType(value);
                                  }
                                },
                                activeColor: CupertinoColors.activeOrange,
                              ),
                            ],
                          ),
                        ),

                        // Details (only show if selected)
                        if (isSelected)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailItem(
                                  'Examples',
                                  packageType['examples'],
                                  CupertinoIcons.checkmark_circle,
                                ),
                                const SizedBox(height: 12),
                                _buildDetailItem(
                                  'Restrictions',
                                  packageType['restrictions'],
                                  CupertinoIcons.exclamationmark_circle,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
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
    );
  }

  Widget _buildDetailItem(String title, String content, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: CupertinoColors.systemGrey,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF05001E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey.darkColor,
                ),
              ),
            ],
          ),
        ),
      ],
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
