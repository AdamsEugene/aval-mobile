import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Address {
  final String id;
  final String name;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  bool isDefault;
  final String type; // Home, Work, Other

  Address({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.isDefault = false,
    required this.type,
  });
}

class ManageAddressesScreen extends StatefulWidget {
  const ManageAddressesScreen({super.key});

  @override
  State<ManageAddressesScreen> createState() => _ManageAddressesScreenState();
}

class _ManageAddressesScreenState extends State<ManageAddressesScreen> {
  // Sample addresses (would normally be fetched from a backend)
  List<Address> _addresses = [
    Address(
      id: '1',
      name: 'John Doe',
      street: '123 Main Street',
      city: 'Accra',
      state: 'Greater Accra',
      zipCode: '00233',
      country: 'Ghana',
      isDefault: true,
      type: 'Home',
    ),
    Address(
      id: '2',
      name: 'John Doe',
      street: '456 Business Avenue',
      city: 'Accra',
      state: 'Greater Accra',
      zipCode: '00233',
      country: 'Ghana',
      isDefault: false,
      type: 'Work',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFF673AB7),
        border: null,
        middle: const Text(
          'My Addresses',
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                CupertinoIcons.back,
                color: CupertinoColors.white,
                size: 18,
              ),
            ),
          ),
        ),
        trailing: GestureDetector(
          onTap: () => _showAddAddressModal(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              CupertinoIcons.add,
              color: CupertinoColors.white,
              size: 18,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: _addresses.isEmpty
            ? _buildEmptyState()
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Instructions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFD1C4E9),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF673AB7).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            CupertinoIcons.info,
                            color: Color(0xFF673AB7),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Tap on an address to edit or swipe left to delete. Your default address is used automatically for checkout.',
                            style: TextStyle(
                              color: Color(0xFF4A148C),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Address List
                  ..._addresses.map((address) => _buildAddressCard(address)).toList(),
                  
                  // Add Address Button
                  const SizedBox(height: 16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showAddAddressModal(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF673AB7).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.add,
                            color: Color(0xFF673AB7),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Add New Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF673AB7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.location,
              size: 60,
              color: Color(0xFF673AB7),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Addresses Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'You haven\'t added any delivery addresses yet. Add your first address to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF757575),
              ),
            ),
          ),
          const SizedBox(height: 32),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showAddAddressModal(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF673AB7),
                    Color(0xFF512DA8),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF673AB7).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    color: CupertinoColors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add New Address',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    return Dismissible(
      key: Key(address.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              CupertinoIcons.delete,
              color: CupertinoColors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Delete',
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmation(address);
      },
      onDismissed: (direction) {
        setState(() {
          _addresses.removeWhere((a) => a.id == address.id);
        });
        _showSuccessMessage('Address deleted successfully');
      },
      child: GestureDetector(
        onTap: () => _showEditAddressModal(context, address),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: address.isDefault
                ? Border.all(
                    color: const Color(0xFF673AB7),
                    width: 2,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF673AB7).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      address.type == 'Home'
                          ? CupertinoIcons.home
                          : address.type == 'Work'
                              ? CupertinoIcons.briefcase
                              : CupertinoIcons.location,
                      color: const Color(0xFF673AB7),
                      size: 20,
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
                              address.type,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF05001E),
                              ),
                            ),
                            if (address.isDefault) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF673AB7).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Default',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF673AB7),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF05001E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.pencil,
                    color: Color(0xFF9E9E9E),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 12),
              Text(
                '${address.street}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${address.city}, ${address.state} ${address.zipCode}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address.country,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
              if (!address.isDefault) ...[
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _setAsDefault(address.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Set as Default',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF673AB7),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _setAsDefault(String id) {
    setState(() {
      for (var address in _addresses) {
        address.isDefault ? address.isDefault = false : null;
      }
      _addresses.firstWhere((address) => address.id == id).isDefault = true;
    });
    _showSuccessMessage('Default address updated');
  }

  Future<bool> _showDeleteConfirmation(Address address) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Delete Address'),
              content: Text('Are you sure you want to delete this ${address.type.toLowerCase()} address?'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _showAddAddressModal(BuildContext context) {
    _showAddressFormModal(context, null);
  }

  void _showEditAddressModal(BuildContext context, Address address) {
    _showAddressFormModal(context, address);
  }

  void _showAddressFormModal(BuildContext context, Address? existingAddress) {
    final isEditing = existingAddress != null;
    final _formKey = GlobalKey<FormState>();
    
    final _nameController = TextEditingController(text: existingAddress?.name ?? '');
    final _streetController = TextEditingController(text: existingAddress?.street ?? '');
    final _cityController = TextEditingController(text: existingAddress?.city ?? '');
    final _stateController = TextEditingController(text: existingAddress?.state ?? '');
    final _zipCodeController = TextEditingController(text: existingAddress?.zipCode ?? '');
    final _countryController = TextEditingController(text: existingAddress?.country ?? 'Ghana');
    
    String _selectedType = existingAddress?.type ?? 'Home';
    bool _isDefault = existingAddress?.isDefault ?? (_addresses.isEmpty ? true : false);
    
    final List<String> _addressTypes = ['Home', 'Work', 'Other'];

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF673AB7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF673AB7).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      isEditing ? 'Edit Address' : 'Add New Address',
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        // Save the address
                        if (_formKey.currentState?.validate() ?? false) {
                          if (isEditing) {
                            // Update existing address
                            final updatedAddress = Address(
                              id: existingAddress.id,
                              name: _nameController.text,
                              street: _streetController.text,
                              city: _cityController.text,
                              state: _stateController.text,
                              zipCode: _zipCodeController.text,
                              country: _countryController.text,
                              isDefault: _isDefault,
                              type: _selectedType,
                            );
                            
                            setState(() {
                              final index = _addresses.indexWhere((a) => a.id == existingAddress.id);
                              if (index != -1) {
                                _addresses[index] = updatedAddress;
                                
                                // If this is now the default, update others
                                if (_isDefault) {
                                  for (var i = 0; i < _addresses.length; i++) {
                                    if (i != index) {
                                      _addresses[i].isDefault = false;
                                    }
                                  }
                                }
                              }
                            });
                            
                            _showSuccessMessage('Address updated successfully');
                          } else {
                            // Create new address
                            final newAddress = Address(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              name: _nameController.text,
                              street: _streetController.text,
                              city: _cityController.text,
                              state: _stateController.text,
                              zipCode: _zipCodeController.text,
                              country: _countryController.text,
                              isDefault: _isDefault,
                              type: _selectedType,
                            );
                            
                            setState(() {
                              // If this is the default, update others
                              if (_isDefault) {
                                for (var address in _addresses) {
                                  address.isDefault = false;
                                }
                              }
                              
                              _addresses.add(newAddress);
                            });
                            
                            _showSuccessMessage('New address added successfully');
                          }
                          
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Address Type
                      _buildSectionHeader('Address Type'),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: _addressTypes.map((type) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedType = type;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: _selectedType == type
                                          ? const Color(0xFF673AB7)
                                          : CupertinoColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        type,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _selectedType == type
                                              ? CupertinoColors.white
                                              : const Color(0xFF05001E),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      
                      // Contact Information
                      _buildSectionHeader('Contact Information'),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        placeholder: 'Enter recipient name',
                        icon: CupertinoIcons.person_fill,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the recipient name';
                          }
                          return null;
                        },
                      ),
                      
                      // Address Details
                      _buildSectionHeader('Address Details'),
                      _buildTextField(
                        controller: _streetController,
                        label: 'Street Address',
                        placeholder: 'Enter street address',
                        icon: CupertinoIcons.location_solid,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the street address';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: _cityController,
                        label: 'City',
                        placeholder: 'Enter city',
                        icon: CupertinoIcons.building_2_fill,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the city';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _stateController,
                              label: 'State/Region',
                              placeholder: 'Enter state',
                              icon: CupertinoIcons.map_fill,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the state';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _zipCodeController,
                              label: 'ZIP/Postal Code',
                              placeholder: 'Enter postal code',
                              icon: CupertinoIcons.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the postal code';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      _buildTextField(
                        controller: _countryController,
                        label: 'Country',
                        placeholder: 'Enter country',
                        icon: CupertinoIcons.globe,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the country';
                          }
                          return null;
                        },
                      ),
                      
                      // Default Address Toggle
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF673AB7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                CupertinoIcons.star_fill,
                                color: Color(0xFF673AB7),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'Set as Default Address',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF05001E),
                                ),
                              ),
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return CupertinoSwitch(
                                  value: _isDefault,
                                  activeColor: const Color(0xFF673AB7),
                                  onChanged: (value) {
                                    setState(() {
                                      _isDefault = value;
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF673AB7),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF673AB7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF673AB7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF673AB7),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(8),
              ),
              keyboardType: keyboardType,
            ),
            if (validator != null)
              Builder(
                builder: (context) {
                  final errorText = validator(controller.text);
                  return errorText != null && errorText.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8, left: 4),
                          child: Text(
                            errorText,
                            style: const TextStyle(
                              color: Color(0xFFE53935),
                              fontSize: 12,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    
    // Auto-dismiss after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }
} 