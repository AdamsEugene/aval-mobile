// lib/screen/delivery/drawers/ecommerce_shipping_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class EcommerceShippingDrawer extends StatefulWidget {
  const EcommerceShippingDrawer({super.key});

  @override
  State<EcommerceShippingDrawer> createState() =>
      _EcommerceShippingDrawerState();
}

class _EcommerceShippingDrawerState extends State<EcommerceShippingDrawer> {
  int _selectedStoreIndex = 0;
  final TextEditingController _storeUrlController = TextEditingController();
  final TextEditingController _itemUrlController = TextEditingController();
  bool _setupApiIntegration = false;

  final List<Map<String, dynamic>> _stores = [
    {
      'name': 'Aval Shop',
      'logo': 'assets/images/a.jpg',
      'isConnected': true,
    },
    {
      'name': 'Global Store',
      'logo': 'assets/images/b.jpg',
      'isConnected': false,
    },
    {
      'name': 'Electronics Hub',
      'logo': 'assets/images/c.jpg',
      'isConnected': false,
    },
    {
      'name': 'Fashion Center',
      'logo': 'assets/images/d.jpg',
      'isConnected': false,
    },
  ];

  @override
  void dispose() {
    _storeUrlController.dispose();
    _itemUrlController.dispose();
    super.dispose();
  }

  void _selectStore(int index) {
    setState(() {
      _selectedStoreIndex = index;
    });
  }

  void _toggleApiIntegration(bool value) {
    setState(() {
      _setupApiIntegration = value;
    });
  }

  void _confirmSelection() {
    Navigator.pop(context);

    // Show confirmation
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Store Connection'),
        content: Text(
          'You have connected to ${_stores[_selectedStoreIndex]['name']}. Now you can easily ship products from this store.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      // title: 'E-commerce Shipping',
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Connect',
        textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: _confirmSelection,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.activeBlue,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.activeBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.info,
                          color: CupertinoColors.activeBlue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'E-commerce Integration',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Connect your online store to easily ship products to customers. We support both direct API integration and manual product entry.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ],
              ),
            ),

            // Store selection
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: _buildSectionHeader('Select Your Store'),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _stores.length,
                itemBuilder: (context, index) {
                  final store = _stores[index];
                  final isSelected = index == _selectedStoreIndex;

                  return GestureDetector(
                    onTap: () => _selectStore(index),
                    child: Container(
                      width: 88,
                      margin: const EdgeInsets.only(right: 16),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(store['logo']),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? CupertinoColors.activeOrange
                                    : CupertinoColors.systemGrey4,
                                width: 1,
                              ),
                            ),
                            child: store['isConnected']
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.activeGreen,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: CupertinoColors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.checkmark,
                                        color: CupertinoColors.white,
                                        size: 8,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            store['name'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? CupertinoColors.activeOrange
                                  : const Color(0xFF05001E),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Manual URL Entry
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: _buildSectionHeader('Or Add Store URL'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: CupertinoTextField(
                controller: _storeUrlController,
                placeholder: 'Enter your store URL',
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    CupertinoIcons.globe,
                    color: Color(0xFF05001E),
                  ),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
            ),

            // Product URL Entry
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _buildSectionHeader('Add Product URL (Optional)'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: CupertinoTextField(
                controller: _itemUrlController,
                placeholder: 'Enter product URL',
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    CupertinoIcons.link,
                    color: Color(0xFF05001E),
                  ),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
            ),

            // API Integration Option
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CupertinoSwitch(
                    value: _setupApiIntegration,
                    onChanged: _toggleApiIntegration,
                    activeColor: CupertinoColors.activeOrange,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Set up API integration for automatic shipping',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF05001E),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // API documentation notice
            if (_setupApiIntegration)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBE6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CupertinoColors.systemYellow,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          CupertinoIcons.doc_text,
                          color: CupertinoColors.systemYellow,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'API Documentation',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.systemYellow,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Our team will contact you to help set up the API integration for your store. Full documentation will be provided.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF826600),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Handle documentation access
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: CupertinoColors.systemYellow,
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'View Documentation',
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemYellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Connect button
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
                    'Connect Store',
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF05001E),
      ),
    );
  }
}
