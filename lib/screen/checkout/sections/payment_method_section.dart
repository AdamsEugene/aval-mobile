import 'package:flutter/cupertino.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  PaymentMethod _selectedMethod = PaymentMethod.creditCards.first;

  void _showPaymentSelection(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => _PaymentMethodSheet(
        selectedMethod: _selectedMethod,
        onMethodSelected: (method) {
          setState(() {
            _selectedMethod = method;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPaymentSelection(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(CupertinoIcons.chevron_right, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            _buildSelectedPaymentMethod(_selectedMethod),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPaymentMethod(PaymentMethod method) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(method.icon, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (method.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    method.subtitle!,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodSheet extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final Function(PaymentMethod) onMethodSelected;

  const _PaymentMethodSheet({
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSavedCards(),
                  const SizedBox(height: 24),
                  _buildOtherMethods(),
                ],
              ),
            ),
          ),
          _buildAddButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Payment Methods',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Saved Cards',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...PaymentMethod.creditCards.map((method) => _PaymentMethodTile(
              method: method,
              isSelected: method == selectedMethod,
              onTap: () => onMethodSelected(method),
            )),
      ],
    );
  }

  Widget _buildOtherMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Other Payment Methods',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...PaymentMethod.otherMethods.map((method) => _PaymentMethodTile(
              method: method,
              isSelected: method == selectedMethod,
              onTap: () => onMethodSelected(method),
            )),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
        top: 16,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Handle adding new payment method
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFDC202),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: Text(
              'Add New Card',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFDC202)
                : CupertinoColors.systemGrey4,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(method.icon, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  if (method.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      method.subtitle!,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: Color(0xFFFDC202),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String title;
  final String? subtitle;
  final IconData icon;

  const PaymentMethod({
    required this.title,
    this.subtitle,
    required this.icon,
  });

  static List<PaymentMethod> creditCards = [
    const PaymentMethod(
      title: 'Visa',
      subtitle: '**** **** **** 1234',
      icon: CupertinoIcons.creditcard,
    ),
    const PaymentMethod(
      title: 'Mastercard',
      subtitle: '**** **** **** 5678',
      icon: CupertinoIcons.creditcard_fill,
    ),
  ];

  static List<PaymentMethod> otherMethods = [
    const PaymentMethod(
      title: 'Apple Pay',
      icon: CupertinoIcons.device_phone_portrait,
    ),
    const PaymentMethod(
      title: 'PayPal',
      icon: CupertinoIcons.money_dollar_circle,
    ),
    const PaymentMethod(
      title: 'Bank Transfer',
      icon: CupertinoIcons.building_2_fill,
    ),
    const PaymentMethod(
      title: 'Cash on Delivery',
      icon: CupertinoIcons.money_dollar,
    ),
  ];
}
