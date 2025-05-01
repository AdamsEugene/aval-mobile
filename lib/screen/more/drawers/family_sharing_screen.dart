import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FamilyMember {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String relationship;
  final String avatarUrl;
  final bool isPrimaryAccount;
  final List<String> permissions;

  FamilyMember({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.relationship,
    required this.avatarUrl,
    this.isPrimaryAccount = false,
    required this.permissions,
  });
}

class FamilySharingScreen extends StatefulWidget {
  const FamilySharingScreen({super.key});

  @override
  State<FamilySharingScreen> createState() => _FamilySharingScreenState();
}

class _FamilySharingScreenState extends State<FamilySharingScreen> {
  // Sample family members
  List<FamilyMember> _familyMembers = [
    FamilyMember(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+233 20 123 4567',
      relationship: 'Self',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isPrimaryAccount: true,
      permissions: ['Orders', 'Payments', 'Addresses', 'Preferences'],
    ),
    FamilyMember(
      id: '2',
      name: 'Jane Doe',
      email: 'jane.doe@example.com',
      phone: '+233 20 987 6543',
      relationship: 'Spouse',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      permissions: ['Orders', 'Addresses'],
    ),
    FamilyMember(
      id: '3',
      name: 'Alex Doe',
      email: 'alex.doe@example.com',
      relationship: 'Child',
      avatarUrl: 'https://i.pravatar.cc/150?img=7',
      permissions: ['Orders'],
    ),
  ];

  // Available permissions to manage
  final List<String> _availablePermissions = [
    'Orders',
    'Payments',
    'Addresses',
    'Preferences',
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFF673AB7),
        border: null,
        middle: const Text(
          'Family Sharing',
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
          onTap: () => _showAddFamilyMemberModal(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              CupertinoIcons.person_add,
              color: CupertinoColors.white,
              size: 18,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Info Box
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
              child: Column(
                children: [
                  Row(
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
                          'Family Sharing',
                          style: TextStyle(
                            color: Color(0xFF4A148C),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Share your account with family members and control what they can access. You can add up to 5 family members to your account.',
                    style: TextStyle(
                      color: Color(0xFF4A148C),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Primary account banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF673AB7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.person_crop_circle_badge_checkmark,
                    color: Color(0xFF673AB7),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Primary Account',
                    style: TextStyle(
                      color: Color(0xFF673AB7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_familyMembers.length}/6 Members',
                    style: const TextStyle(
                      color: Color(0xFF673AB7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Family Members List
            ..._familyMembers.map((member) => _buildFamilyMemberCard(member)).toList(),
            
            // Add Family Member Button
            const SizedBox(height: 16),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showAddFamilyMemberModal(context),
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
                      CupertinoIcons.person_add,
                      color: Color(0xFF673AB7),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Add Family Member',
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

  Widget _buildFamilyMemberCard(FamilyMember member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        border: member.isPrimaryAccount
            ? Border.all(
                color: const Color(0xFF673AB7),
                width: 2,
              )
            : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(member.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              member.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF05001E),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: member.isPrimaryAccount
                                  ? const Color(0xFF673AB7).withOpacity(0.1)
                                  : const Color(0xFFF5F5F7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              member.relationship,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: member.isPrimaryAccount
                                    ? const Color(0xFF673AB7)
                                    : const Color(0xFF757575),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        member.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF05001E).withOpacity(0.6),
                        ),
                      ),
                      if (member.phone != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          member.phone!,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF05001E).withOpacity(0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!member.isPrimaryAccount)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showRemoveFamilyMemberDialog(member),
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: Color(0xFF9E9E9E),
                      size: 22,
                    ),
                  ),
              ],
            ),
          ),
          if (!member.isPrimaryAccount) ...[
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Permissions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _availablePermissions.map((permission) {
                      final isEnabled = member.permissions.contains(permission);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isEnabled) {
                              // Remove permission
                              member.permissions.remove(permission);
                            } else {
                              // Add permission
                              member.permissions.add(permission);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isEnabled
                                ? const Color(0xFF673AB7)
                                : const Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(30),
                            border: isEnabled
                                ? null
                                : Border.all(
                                    color: const Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isEnabled
                                    ? CupertinoIcons.checkmark_circle_fill
                                    : CupertinoIcons.circle,
                                size: 16,
                                color: isEnabled
                                    ? CupertinoColors.white
                                    : const Color(0xFF9E9E9E),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                permission,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isEnabled
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: isEnabled
                                      ? CupertinoColors.white
                                      : const Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddFamilyMemberModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _phoneController = TextEditingController();
    String _relationship = 'Family Member';
    
    final List<String> _relationshipOptions = [
      'Spouse',
      'Child',
      'Parent',
      'Family Member',
      'Friend',
    ];

    List<String> _selectedPermissions = ['Orders'];

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
                    const Text(
                      'Add Family Member',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final newMember = FamilyMember(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text.isEmpty ? null : _phoneController.text,
                            relationship: _relationship,
                            avatarUrl: 'https://i.pravatar.cc/150?img=${_familyMembers.length + 3}',
                            permissions: _selectedPermissions,
                          );
                          
                          setState(() {
                            _familyMembers.add(newMember);
                          });
                          
                          Navigator.of(context).pop();
                          _showSuccessMessage('Family member added successfully');
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
                      _buildSectionHeader('Member Information'),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        placeholder: 'Enter family member name',
                        icon: CupertinoIcons.person_fill,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        placeholder: 'Enter email address',
                        icon: CupertinoIcons.mail_solid,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone (Optional)',
                        placeholder: 'Enter phone number',
                        icon: CupertinoIcons.phone_fill,
                        keyboardType: TextInputType.phone,
                      ),
                      
                      _buildSelectField(
                        label: 'Relationship',
                        value: _relationship,
                        icon: CupertinoIcons.person_2_fill,
                        onTap: () {
                          _showRelationshipPicker(context, _relationship, (value) {
                            setState(() {
                              _relationship = value;
                            });
                          });
                        },
                      ),
                      
                      _buildSectionHeader('Permissions'),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
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
                                  child: const Icon(
                                    CupertinoIcons.shield_fill,
                                    color: Color(0xFF673AB7),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Flexible(
                                  child: Text(
                                    'Select Access Permissions',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF05001E),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Choose what this family member can access:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF757575),
                              ),
                            ),
                            const SizedBox(height: 12),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _availablePermissions.map((permission) {
                                    final isSelected = _selectedPermissions.contains(permission);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedPermissions.remove(permission);
                                          } else {
                                            _selectedPermissions.add(permission);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFF673AB7)
                                              : const Color(0xFFF5F5F7),
                                          borderRadius: BorderRadius.circular(30),
                                          border: isSelected
                                              ? null
                                              : Border.all(
                                                  color: const Color(0xFFE0E0E0),
                                                  width: 1,
                                                ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              isSelected
                                                  ? CupertinoIcons.checkmark_circle_fill
                                                  : CupertinoIcons.circle,
                                              size: 16,
                                              color: isSelected
                                                  ? CupertinoColors.white
                                                  : const Color(0xFF9E9E9E),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              permission,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                                color: isSelected
                                                    ? CupertinoColors.white
                                                    : const Color(0xFF757575),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFE082),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.info,
                              color: Color(0xFFFFA000),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'An invitation will be sent to the email address. They\'ll need to accept it to join your family group.',
                                style: TextStyle(
                                  color: Color(0xFF5D4037),
                                  fontSize: 14,
                                ),
                              ),
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

  void _showRelationshipPicker(BuildContext context, String initialValue, Function(String) onSelect) {
    final List<String> _relationshipOptions = [
      'Spouse',
      'Child',
      'Parent',
      'Family Member',
      'Friend',
    ];
    
    int selectedIndex = _relationshipOptions.indexOf(initialValue);
    if (selectedIndex < 0) selectedIndex = 0;
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () {
                      onSelect(_relationshipOptions[selectedIndex]);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedIndex,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      children: _relationshipOptions
                          .map((relationship) => Center(child: Text(relationship)))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showRemoveFamilyMemberDialog(FamilyMember member) async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Remove Family Member'),
          content: Text('Are you sure you want to remove ${member.name} from your family group?'),
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
                setState(() {
                  _familyMembers.removeWhere((m) => m.id == member.id);
                });
                Navigator.of(context).pop(true);
                _showSuccessMessage('Family member removed');
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
    
    return result ?? false;
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

  Widget _buildSelectField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF05001E),
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      color: Color(0xFF05001E),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
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