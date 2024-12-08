// lib/widgets/return_policy/return_policy_drawer.dart
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/cupertino.dart';

class ReturnPolicyDrawer extends StatelessWidget {
  const ReturnPolicyDrawer({super.key});

  Widget _buildPolicySection({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: CupertinoColors.activeOrange,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFFEEAD1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Return Policy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 24),

          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPolicySection(
                    title: 'Return Window',
                    description:
                        '30 days from delivery date for most items. Some categories may have different return windows.',
                    icon: CupertinoIcons.time,
                  ),
                  _buildPolicySection(
                    title: 'Return Condition',
                    description:
                        'Items must be unused, unworn, undamaged, and in original packaging with all tags attached.',
                    icon: CupertinoIcons.cube_box,
                  ),
                  _buildPolicySection(
                    title: 'Refund Method',
                    description:
                        'Refunds will be processed to the original payment method within 5-7 business days after receiving the return.',
                    icon: CupertinoIcons.money_dollar,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Return Process',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStep(
                    number: '1',
                    title: 'Initiate Return',
                    description:
                        'Start your return request through your account or contact customer service.',
                  ),
                  _buildStep(
                    number: '2',
                    title: 'Package Item',
                    description:
                        'Pack the item securely in its original packaging with all accessories.',
                  ),
                  _buildStep(
                    number: '3',
                    title: 'Ship Return',
                    description:
                        'Use the provided return label or ship to the address provided.',
                  ),
                  _buildStep(
                    number: '4',
                    title: 'Refund Process',
                    description:
                        'Once received and inspected, your refund will be processed.',
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: CupertinoColors.activeOrange,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Non-Returnable Items',
                              style: TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Customized or personalized items\n'
                          '• Intimate or sanitary goods\n'
                          '• Downloadable software products\n'
                          '• Gift cards\n'
                          '• Clearance items marked as final sale',
                          style: TextStyle(
                            color: const Color(0xFF05001E).withOpacity(0.6),
                            fontSize: 14,
                            height: 1.5,
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
  }
}
