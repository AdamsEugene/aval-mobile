import 'package:flutter/cupertino.dart';

class StoreInfoDrawer extends StatelessWidget {
  const StoreInfoDrawer({super.key});

  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const StoreInfoDrawer(),
    );
  }

  Widget _buildInfoRow({
    required String title,
    required String value,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF05001E).withOpacity(0.6),
            ),
            const SizedBox(width: 12),
          ],
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF05001E),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreMetrics() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricColumn('Products', '2.5K+'),
          _buildDivider(),
          _buildMetricColumn('Followers', '20K+'),
          _buildDivider(),
          _buildMetricColumn('Rating', '4.9'),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF05001E),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF05001E).withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: const Color(0xFFEEEEEE),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF050311),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Store',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStoreMetrics(),
                  const SizedBox(height: 24),
                  const Text(
                    'Store Description',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: TextStyle(
                      color: const Color(0xFF05001E).withOpacity(0.6),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Store Information',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    icon: CupertinoIcons.location,
                    title: 'Location',
                    value: 'Accra, Ghana',
                  ),
                  _buildInfoRow(
                    icon: CupertinoIcons.calendar,
                    title: 'Member Since',
                    value: 'January 2020',
                  ),
                  _buildInfoRow(
                    icon: CupertinoIcons.clock,
                    title: 'Response Time',
                    value: 'Within 24 hours',
                  ),
                  _buildInfoRow(
                    icon: CupertinoIcons.shopping_cart,
                    title: 'Orders Completed',
                    value: '15,000+',
                  ),
                  _buildInfoRow(
                    icon: CupertinoIcons.percent,
                    title: 'Completion Rate',
                    value: '98.5%',
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.checkmark_seal_fill,
                          color: Color(0xFFFDC202),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'AVAL Verified Store',
                                style: TextStyle(
                                  color: Color(0xFF05001E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'This store has been verified by AVAL for quality and reliability',
                                style: TextStyle(
                                  color:
                                      const Color(0xFF05001E).withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
