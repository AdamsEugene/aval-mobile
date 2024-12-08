// lib/screens/payment/payment_plans_sheet.dart
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/cupertino.dart';

class PaymentPlansSheet extends StatelessWidget {
  final double productPrice;

  const PaymentPlansSheet({
    super.key,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: PaymentPlan.plans
                    .map((plan) => _PlanCard(
                          plan: plan,
                          productPrice: productPrice,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BaseDrawer(
      padding: const EdgeInsets.all(16),
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Save',
        // textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: () => (),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.money_dollar_circle,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Payment Plans',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PaymentPlan plan;
  final double productPrice;

  const _PlanCard({
    required this.plan,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPlanDetails(context),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CupertinoColors.systemGrey5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF05001E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      plan.icon,
                      color: const Color(0xFF05001E),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          plan.shortDescription,
                          style: TextStyle(
                            color: CupertinoColors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(
                    'Monthly Payment',
                    '\$${(productPrice * plan.monthlyPaymentMultiplier).toStringAsFixed(2)}',
                    highlight: true,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow('Duration', plan.duration),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Interest Rate',
                    '${(plan.interestRate * 100).toStringAsFixed(1)}%',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Initial Payment',
                    '\$${(productPrice * plan.initialPaymentPercentage).toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: highlight ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: highlight
                ? CupertinoColors.activeOrange
                : const Color(0xFF05001E),
            fontSize: highlight ? 18 : 14,
            fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showPlanDetails(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => _PlanDetailsSheet(plan: plan),
    );
  }
}

class _PlanDetailsSheet extends StatelessWidget {
  final PaymentPlan plan;

  const _PlanDetailsSheet({required this.plan});

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.75,
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Save',
        // textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: () => (),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...plan.details.map((detail) => _buildDetailItem(detail)),
                  const SizedBox(height: 24),
                  _buildRequirements(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Text(
            'Plan Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            CupertinoIcons.checkmark_circle_fill,
            color: CupertinoColors.activeOrange,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Requirements',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...plan.requirements.map((req) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.doc_text,
                    size: 20,
                    color: CupertinoColors.systemGrey,
                  ),
                  const SizedBox(width: 12),
                  Text(req),
                ],
              ),
            )),
      ],
    );
  }
}

class PaymentPlan {
  final String name;
  final String shortDescription;
  final IconData icon;
  final String duration;
  final double interestRate;
  final double initialPaymentPercentage;
  final double monthlyPaymentMultiplier;
  final List<String> details;
  final List<String> requirements;

  const PaymentPlan({
    required this.name,
    required this.shortDescription,
    required this.icon,
    required this.duration,
    required this.interestRate,
    required this.initialPaymentPercentage,
    required this.monthlyPaymentMultiplier,
    required this.details,
    required this.requirements,
  });

  static List<PaymentPlan> plans = [
    const PaymentPlan(
      name: 'Hire Purchase',
      shortDescription: 'Own the product after completing payments',
      icon: CupertinoIcons.cart,
      duration: '12-36 months',
      interestRate: 0.089,
      initialPaymentPercentage: 0.20,
      monthlyPaymentMultiplier: 0.083,
      details: [
        'Pay an initial deposit and own the product after completing all payments',
        'Fixed monthly payments with competitive interest rates',
        'Flexible payment terms from 12 to 36 months',
        'Option to pay off early with reduced interest',
      ],
      requirements: [
        'Valid ID or Passport',
        'Proof of income',
        'Bank statements (3 months)',
        'Utility bill for address verification',
      ],
    ),
    const PaymentPlan(
      name: 'Leasing',
      shortDescription: 'Use now, option to buy later',
      icon: CupertinoIcons.time,
      duration: '24-48 months',
      interestRate: 0.069,
      initialPaymentPercentage: 0.15,
      monthlyPaymentMultiplier: 0.072,
      details: [
        'Lower monthly payments compared to hire purchase',
        'Option to upgrade to newer models',
        'Maintenance and support included',
        'Flexibility to buy or return at end of term',
      ],
      requirements: [
        'Valid ID or Passport',
        'Proof of income',
        'Credit check required',
        'Security deposit',
      ],
    ),
    const PaymentPlan(
      name: 'Rental',
      shortDescription: 'Short-term flexible solution',
      icon: CupertinoIcons.calendar,
      duration: '1-12 months',
      interestRate: 0.0,
      initialPaymentPercentage: 0.10,
      monthlyPaymentMultiplier: 0.15,
      details: [
        'No long-term commitment required',
        'All-inclusive monthly payment',
        'Free maintenance and support',
        'Swap or return anytime (min. 1 month)',
      ],
      requirements: [
        'Valid ID or Passport',
        'Security deposit',
        'Active credit/debit card',
      ],
    ),
    const PaymentPlan(
      name: 'Pay Later',
      shortDescription: 'Buy now, pay in installments',
      icon: CupertinoIcons.money_dollar,
      duration: '3-12 months',
      interestRate: 0.0,
      initialPaymentPercentage: 0.0,
      monthlyPaymentMultiplier: 0.089,
      details: [
        'Zero interest if paid within terms',
        'No initial deposit required',
        'Split payments into equal installments',
        'Early payment options available',
      ],
      requirements: [
        'Valid ID or Passport',
        'Active bank account',
        'Quick credit check',
      ],
    ),
  ];
}
