// lib/screen/delivery/drawers/payment_methods_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PaymentMethodsDrawer extends StatefulWidget {
  const PaymentMethodsDrawer({super.key});

  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const PaymentMethodsDrawer(),
    );
  }

  @override
  State<PaymentMethodsDrawer> createState() => _PaymentMethodsDrawerState();
}

class _PaymentMethodsDrawerState extends State<PaymentMethodsDrawer> {
  bool _isEditing = false;
  bool _addingNewPayment = false;
  int _selectedIndex = 0;

  // Form controllers
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardholderNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  // Sample payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'Visa',
      'cardNumber': '**** **** **** 4567',
      'cardHolder': 'David Johnson',
      'expiryDate': '12/25',
      'icon': CupertinoIcons.creditcard,
      'isDefault': true,
    },
    {
      'type': 'Mastercard',
      'cardNumber': '**** **** **** 8901',
      'cardHolder': 'David Johnson',
      'expiryDate': '09/24',
      'icon': CupertinoIcons.creditcard_fill,
      'isDefault': false,
    },
    {
      'type': 'Mobile Money',
      'cardNumber': '**** **** 7890',
      'cardHolder': 'David Johnson',
      'provider': 'MTN',
      'icon': CupertinoIcons.phone,
      'isDefault': false,
    },
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardholderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _toggleAddNewPayment() {
    setState(() {
      _addingNewPayment = !_addingNewPayment;
    });
  }

  void _selectPaymentMethod(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setDefaultPayment(int index) {
    setState(() {
      for (int i = 0; i < _paymentMethods.length; i++) {
        _paymentMethods[i]['isDefault'] = i == index;
      }
    });
  }

  void _deletePaymentMethod(int index) {
    if (_paymentMethods[index]['isDefault']) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Cannot Delete'),
          content: const Text('You cannot delete your default payment method. Please set another payment method as default first.'),
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
      _paymentMethods.removeAt(index);
      if (_selectedIndex >= _paymentMethods.length) {
        _selectedIndex = _paymentMethods.length - 1;
      }
    });
  }

  void _saveNewPaymentMethod() {
    if (_cardNumberController.text.isEmpty ||
        _cardholderNameController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _cvvController.text.isEmpty) {
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

    final String maskedCardNumber = '**** **** **** ${_cardNumberController.text.substring(math.max(0, _cardNumberController.text.length - 4))}';

    final newPaymentMethod = {
      'type': 'Visa',
      'cardNumber': maskedCardNumber,
      'cardHolder': _cardholderNameController.text,
      'expiryDate': _expiryDateController.text,
      'icon': CupertinoIcons.creditcard,
      'isDefault': _paymentMethods.isEmpty,
    };

    setState(() {
      _paymentMethods.add(newPaymentMethod);
      _selectedIndex = _paymentMethods.length - 1;
      _addingNewPayment = false;
    });

    _cardNumberController.clear();
    _cardholderNameController.clear();
    _expiryDateController.clear();
    _cvvController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.75,
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: _addingNewPayment
          ? null
          : DrawerAction(
              text: _isEditing ? 'Done' : 'Edit',
              textColor: CupertinoColors.activeBlue,
              onTap: _toggleEditing,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Payment Methods',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _addingNewPayment ? _buildAddPaymentForm() : _buildPaymentMethodsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return Column(
      children: [
        Expanded(
          child: _paymentMethods.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _paymentMethods.length,
                  itemBuilder: (context, index) {
                    final paymentMethod = _paymentMethods[index];
                    final isSelected = index == _selectedIndex;

                    return GestureDetector(
                      onTap: () => _selectPaymentMethod(index),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
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
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? CupertinoColors.activeOrange.withOpacity(0.1)
                                          : const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      paymentMethod['icon'],
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
                                        Row(
                                          children: [
                                            Text(
                                              paymentMethod['type'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: isSelected
                                                    ? CupertinoColors.activeOrange
                                                    : const Color(0xFF05001E),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            if (paymentMethod['isDefault'])
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: CupertinoColors.activeGreen.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: const Text(
                                                  'Default',
                                                  style: TextStyle(
                                                    color: CupertinoColors.activeGreen,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          paymentMethod['cardNumber'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: const Color(0xFF05001E).withOpacity(0.6),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          paymentMethod['provider'] != null
                                              ? 'Provider: ${paymentMethod['provider']}'
                                              : 'Expires: ${paymentMethod['expiryDate']}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: const Color(0xFF05001E).withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_isEditing)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: !paymentMethod['isDefault']
                                              ? () => _setDefaultPayment(index)
                                              : null,
                                          child: Icon(
                                            CupertinoIcons.checkmark_circle,
                                            color: paymentMethod['isDefault']
                                                ? CupertinoColors.activeGreen
                                                : CupertinoColors.systemGrey,
                                            size: 24,
                                          ),
                                        ),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () => _deletePaymentMethod(index),
                                          child: const Icon(
                                            CupertinoIcons.delete,
                                            color: CupertinoColors.destructiveRed,
                                            size: 24,
                                          ),
                                        ),
                                      ],
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
        if (!_isEditing)
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: const Color(0xFF05001E),
                onPressed: _toggleAddNewPayment,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.add, size: 20),
                    SizedBox(width: 8),
                    Text('Add Payment Method'),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.creditcard,
            size: 64,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No Payment Methods',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a payment method to continue',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 24),
          CupertinoButton(
            color: const Color(0xFF05001E),
            onPressed: _toggleAddNewPayment,
            child: const Text('Add Payment Method'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _toggleAddNewPayment,
                child: const Icon(
                  CupertinoIcons.back,
                  color: Color(0xFF05001E),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Add Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Card Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: _cardNumberController,
                  placeholder: 'Card Number',
                  keyboardType: TextInputType.number,
                  prefix: const Icon(CupertinoIcons.creditcard),
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: _cardholderNameController,
                  placeholder: 'Cardholder Name',
                  keyboardType: TextInputType.name,
                  prefix: const Icon(CupertinoIcons.person),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildFormField(
                        controller: _expiryDateController,
                        placeholder: 'MM/YY',
                        keyboardType: TextInputType.number,
                        prefix: const Icon(CupertinoIcons.calendar),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFormField(
                        controller: _cvvController,
                        placeholder: 'CVV',
                        keyboardType: TextInputType.number,
                        prefix: const Icon(CupertinoIcons.lock),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: const Color(0xFF05001E),
                    onPressed: _saveNewPaymentMethod,
                    child: const Text('Add Card'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String placeholder,
    required TextInputType keyboardType,
    Widget? prefix,
    bool obscureText = false,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      keyboardType: keyboardType,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CupertinoColors.systemGrey5),
      ),
      prefix: prefix != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: prefix,
            )
          : null,
      obscureText: obscureText,
    );
  }
}