// lib/screen/delivery/drawers/addresses_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class AddressesDrawer extends StatefulWidget {
  const AddressesDrawer({super.key});

  @override
  State<AddressesDrawer> createState() => _AddressesDrawerState();
}

class _AddressesDrawerState extends State<AddressesDrawer> {
  bool _isEditing = false;
  bool _addingNewAddress = false;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();

  // Sample addresses
  final List<Map<String, dynamic>> _addresses = [
    {
      'name': 'Home',
      'recipient': 'David Johnson',
      'phone': '+233 123 456 7890',
      'address': '123 Independence Ave, Cantonments',
      'city': 'Accra',
      'region': 'Greater Accra',
      'isDefault': true,
    },
    {
      'name': 'Office',
      'recipient': 'David Johnson',
      'phone': '+233 098 765 4321',
      'address': '45 Liberation Road, Airport City',
      'city': 'Accra',
      'region': 'Greater Accra',
      'isDefault': false,
    },
    {
      'name': 'Mom\'s House',
      'recipient': 'Sarah Johnson',
      'phone': '+233 234 567 8901',
      'address': '78 Asafoatse Kotei Road',
      'city': 'Kumasi',
      'region': 'Ashanti',
      'isDefault': false,
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _regionController.dispose();
    _postcodeController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _toggleAddNewAddress() {
    setState(() {
      _addingNewAddress = !_addingNewAddress;
    });
  }

  void _saveNewAddress() {
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressLine1Controller.text.isEmpty ||
        _cityController.text.isEmpty) {
      // Show validation error
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Missing Information'),
          content: const Text('Please fill in all required fields.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    // Add new address to list (in real app, would save to database)
    final newAddress = {
      'name': _nameController.text,
      'recipient': _nameController.text,
      'phone': _phoneController.text,
      'address':
          '${_addressLine1Controller.text}${_addressLine2Controller.text.isNotEmpty ? ', ${_addressLine2Controller.text}' : ''}',
      'city': _cityController.text,
      'region': _regionController.text,
      'isDefault': false,
    };

    setState(() {
      _addresses.add(newAddress);
      _addingNewAddress = false;
    });

    // Clear form fields
    _nameController.clear();
    _phoneController.clear();
    _addressLine1Controller.clear();
    _addressLine2Controller.clear();
    _cityController.clear();
    _regionController.clear();
    _postcodeController.clear();
  }

  void _setDefaultAddress(int index) {
    setState(() {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i]['isDefault'] = i == index;
      }
    });
  }

  void _deleteAddress(int index) {
    // Don't allow deleting the default address
    if (_addresses[index]['isDefault']) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Cannot Delete'),
          content: const Text(
              'You cannot delete your default address. Please set another address as default first.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      // title: 'My Addresses',
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: _addingNewAddress
          ? null
          : DrawerAction(
              text: _isEditing ? 'Done' : 'Edit',
              textColor: CupertinoColors.activeBlue,
              onTap: _toggleEditing,
            ),
      child: _addingNewAddress ? _buildAddAddressForm() : _buildAddressList(),
    );
  }

  Widget _buildAddressList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _addresses.length,
            itemBuilder: (context, index) {
              final address = _addresses[index];

              return Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: address['isDefault']
                        ? CupertinoColors.activeOrange
                        : CupertinoColors.systemGrey5,
                    width: address['isDefault'] ? 2 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: address['isDefault']
                                  ? CupertinoColors.activeOrange
                                      .withOpacity(0.1)
                                  : const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                address['name'] == 'Home'
                                    ? CupertinoIcons.house_fill
                                    : address['name'] == 'Office'
                                        ? CupertinoIcons.building_2_fill
                                        : CupertinoIcons.location_solid,
                                color: address['isDefault']
                                    ? CupertinoColors.activeOrange
                                    : const Color(0xFF05001E),
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      address['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: address['isDefault']
                                            ? CupertinoColors.activeOrange
                                            : const Color(0xFF05001E),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (address['isDefault'])
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: CupertinoColors.activeOrange
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          'Default',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: CupertinoColors.activeOrange,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  address['recipient'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.systemGrey.darkColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  address['phone'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.systemGrey.darkColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${address['address']}, ${address['city']}, ${address['region']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.systemGrey.darkColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Action buttons when in edit mode
                    if (_isEditing)
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => _setDefaultAddress(index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: address['isDefault']
                                        ? CupertinoColors.activeOrange
                                        : CupertinoColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: address['isDefault']
                                          ? CupertinoColors.activeOrange
                                          : CupertinoColors.systemGrey3,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    address['isDefault']
                                        ? 'Default'
                                        : 'Set as Default',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: address['isDefault']
                                          ? CupertinoColors.white
                                          : CupertinoColors
                                              .systemGrey.darkColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _deleteAddress(index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: CupertinoColors.destructiveRed,
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.delete,
                                      color: CupertinoColors.destructiveRed,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.destructiveRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),

        // Add new address button
        Padding(
          padding: const EdgeInsets.all(16),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _toggleAddNewAddress,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF05001E),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    color: CupertinoColors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add New Address',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddAddressForm() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Address Name (e.g. Home, Office)',
            controller: _nameController,
            placeholder: 'Enter address name',
            keyboardType: TextInputType.text,
            icon: CupertinoIcons.house,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Phone Number',
            controller: _phoneController,
            placeholder: 'Enter phone number',
            keyboardType: TextInputType.phone,
            icon: CupertinoIcons.phone,
          ),
          const SizedBox(height: 24),
          const Text(
            'Address Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Address Line 1',
            controller: _addressLine1Controller,
            placeholder: 'Street address',
            keyboardType: TextInputType.streetAddress,
            icon: CupertinoIcons.location,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Address Line 2 (Optional)',
            controller: _addressLine2Controller,
            placeholder: 'Apartment, suite, etc.',
            keyboardType: TextInputType.text,
            icon: CupertinoIcons.building_2_fill,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'City',
            controller: _cityController,
            placeholder: 'Enter city',
            keyboardType: TextInputType.text,
            icon: CupertinoIcons.building_2_fill,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Region',
            controller: _regionController,
            placeholder: 'Enter region',
            keyboardType: TextInputType.text,
            icon: CupertinoIcons.map,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: 'Postal Code (Optional)',
            controller: _postcodeController,
            placeholder: 'Enter postal code',
            keyboardType: TextInputType.text,
            icon: CupertinoIcons.mail,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _toggleAddNewAddress,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CupertinoColors.destructiveRed,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: CupertinoColors.destructiveRed,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _saveNewAddress,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF05001E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Save',
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
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    required TextInputType keyboardType,
    required IconData icon,
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
          placeholder: placeholder,
          keyboardType: keyboardType,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CupertinoColors.systemGrey4,
              width: 1,
            ),
          ),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Icon(
              icon,
              color: const Color(0xFF05001E),
              size: 20,
            ),
          ),
          clearButtonMode: OverlayVisibilityMode.editing,
        ),
      ],
    );
  }
}
