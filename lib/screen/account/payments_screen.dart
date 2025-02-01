// lib/screens/account/payments_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';

class PaymentMethod {
  final String type;
  final String lastDigits;
  final String expiryDate;
  final bool isDefault;

  PaymentMethod({
    required this.type,
    required this.lastDigits,
    required this.expiryDate,
    this.isDefault = false,
  });
}

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      type: 'Visa',
      lastDigits: '4567',
      expiryDate: '12/25',
      isDefault: true,
    ),
    PaymentMethod(
      type: 'Mastercard',
      lastDigits: '8901',
      expiryDate: '09/24',
    ),
  ];

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // TODO: Edit payment method
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Card icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    method.type.toLowerCase() == 'visa'
                        ? CupertinoIcons.creditcard
                        : CupertinoIcons.creditcard_fill,
                    color: CupertinoColors.activeOrange,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Card details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${method.type} •••• ${method.lastDigits}',
                          style: const TextStyle(
                            color: Color(0xFF05001E),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (method.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  CupertinoColors.activeGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Default',
                              style: TextStyle(
                                color: CupertinoColors.activeGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Expires ${method.expiryDate}',
                      style: TextStyle(
                        color: const Color(0xFF05001E).withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: const Color(0xFF05001E).withOpacity(0.3),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddPaymentButton() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // TODO: Implement add payment method
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: CupertinoColors.activeOrange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.add,
                color: CupertinoColors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Add Payment Method',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              title: 'Payment Methods',
              showBackButton: true,
              showProfile: false,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              ..._paymentMethods
                  .map((method) => _buildPaymentMethodCard(method)),
              _buildAddPaymentButton(),
            ]),
          ),
        ],
      ),
    );
  }
}
