import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
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

  Widget _buildVerificationBadge() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 145, right: 16, top: 12, bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF05001E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Aval Choice',
                style: TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'This store has been verified by aval for quality and reliability',
                style: TextStyle(
                  color: CupertinoColors.white.withOpacity(0.9),
                  fontSize: 13,
                  height: 1.4,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        // Badge icon positioned on top
        Positioned(
          left: 10,
          top: -16,
          child: Container(
            width: 114,
            height: 114,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF05001E),
              image: const DecorationImage(
                image: AssetImage('assets/images/certs/aval-choice.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF05001E).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.only(top: 16),
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Save',
        fontWeight: FontWeight.w600,
        onTap: () => (),
      ),
      child: Column(
        children: [
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
                  _buildVerificationBadge(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
