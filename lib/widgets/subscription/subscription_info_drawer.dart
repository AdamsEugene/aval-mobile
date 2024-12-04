// lib/widgets/subscription/subscription_info_drawer.dart
import 'package:flutter/cupertino.dart';

class SubscriptionInfoDrawer extends StatelessWidget {
  const SubscriptionInfoDrawer({super.key});

  Widget _buildSubscriptionPlan({
    required String title,
    required String price,
    required String interval,
    required String savings,
    bool isPopular = false,
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
                title,
                style: const TextStyle(
                  color: Color(0xFF05001E),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isPopular)
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
                    'Most Popular',
                    style: TextStyle(
                      color: Color(0xFFFDC202),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFF05001E),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                interval,
                style: TextStyle(
                  color: const Color(0xFF05001E).withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                CupertinoIcons.tag_fill,
                color: Color(0xFFFDC202),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                savings,
                style: const TextStyle(
                  color: Color(0xFFFDC202),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.checkmark_alt,
            color: Color(0xFFFDC202),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF05001E).withOpacity(0.8),
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
            'Subscription Plans',
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
                  _buildSubscriptionPlan(
                    title: 'Weekly Plan',
                    price: 'USD 39.99',
                    interval: '/week',
                    savings: 'Save 15%',
                    isPopular: true,
                  ),
                  _buildSubscriptionPlan(
                    title: 'Monthly Plan',
                    price: 'USD 149.99',
                    interval: '/month',
                    savings: 'Save 25%',
                  ),
                  _buildSubscriptionPlan(
                    title: 'Quarterly Plan',
                    price: 'USD 399.99',
                    interval: '/quarter',
                    savings: 'Save 30%',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Subscription Benefits',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeature('Regular deliveries without reordering'),
                  _buildFeature('Priority shipping on all orders'),
                  _buildFeature('Exclusive subscriber discounts'),
                  _buildFeature('Flexible delivery schedule'),
                  _buildFeature('Cancel or pause anytime'),
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
                              'Subscription Terms',
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
                          '• Automatic billing on selected interval\n'
                          '• Cancel subscription anytime\n'
                          '• 30-day satisfaction guarantee\n'
                          '• Modify delivery schedule as needed',
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
