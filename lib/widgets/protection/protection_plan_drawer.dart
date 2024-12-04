// lib/widgets/protection/protection_plan_drawer.dart
import 'package:flutter/cupertino.dart';

class ProtectionPlanDrawer extends StatelessWidget {
  const ProtectionPlanDrawer({super.key});

  Widget _buildPlanOption({
    required String duration,
    required String price,
    required String coverage,
    bool isRecommended = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  color: Color(0xFF05001E),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEAD1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Recommended',
                    style: TextStyle(
                      color: Color(0xFFFDC202),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              color: Color(0xFF05001E),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            coverage,
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFFEEAD1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              CupertinoIcons.checkmark_alt,
              color: Color(0xFFFDC202),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF05001E),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey4,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Protection Plan',
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
                  _buildPlanOption(
                    duration: '1 Year Protection',
                    price: 'USD 29.99',
                    coverage:
                        'Comprehensive coverage against damages and defects',
                    isRecommended: true,
                  ),
                  _buildPlanOption(
                    duration: '2 Year Protection',
                    price: 'USD 49.99',
                    coverage: 'Extended coverage with additional benefits',
                  ),
                  _buildPlanOption(
                    duration: '3 Year Protection',
                    price: 'USD 69.99',
                    coverage: 'Maximum protection with premium support',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'What\'s Covered',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCoverageFeature('Accidental damage protection'),
                  _buildCoverageFeature('Manufacturing defects'),
                  _buildCoverageFeature('Wear and tear coverage'),
                  _buildCoverageFeature('24/7 support assistance'),
                  _buildCoverageFeature('Free repairs or replacement'),
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
                              CupertinoIcons.info_circle_fill,
                              color: Color(0xFFFDC202),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Important Information',
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
                          '• Protection starts from the date of purchase\n'
                          '• No deductibles or hidden fees\n'
                          '• Easy claims process\n'
                          '• Transferable coverage\n'
                          '• Cancel anytime',
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
