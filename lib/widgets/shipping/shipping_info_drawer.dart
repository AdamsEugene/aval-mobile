// lib/widgets/shipping/shipping_info_drawer.dart
import 'package:flutter/cupertino.dart';

class ShippingInfoDrawer extends StatelessWidget {
  const ShippingInfoDrawer({super.key});

  Widget _buildShippingMethod({
    required String title,
    required String duration,
    required String price,
    bool isRecommended = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isRecommended) ...[
                      const SizedBox(width: 8),
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
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: Color(0xFF05001E),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF05001E),
              fontSize: 14,
              fontWeight: FontWeight.w500,
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
            'Shipping Information',
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
                  const Text(
                    'Available Shipping Methods',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Shipping Methods
                  _buildShippingMethod(
                    title: 'Standard Shipping',
                    duration: '20-40 days',
                    price: 'Free',
                    isRecommended: true,
                  ),
                  _buildShippingMethod(
                    title: 'Express Shipping',
                    duration: '7-14 days',
                    price: 'USD 15.00',
                  ),
                  _buildShippingMethod(
                    title: 'Premium Shipping',
                    duration: '3-7 days',
                    price: 'USD 25.00',
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Shipping Info
                  _buildInfoRow('Ships From', 'China (Mainland)'),
                  _buildInfoRow('Tracking Available', 'Yes'),
                  _buildInfoRow('Estimated Weight', '0.5 kg'),
                  _buildInfoRow('Package Size', '30 × 20 × 10 cm'),

                  const SizedBox(height: 24),

                  // Important Notes
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
                              'Important Notes',
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
                          '• Delivery times are estimates and may vary based on location\n'
                          '• Customs clearance may affect delivery time\n'
                          '• Tracking information will be provided after shipping\n'
                          '• Local taxes and duties are not included',
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
