import 'package:flutter/cupertino.dart';

class ServiceFeatures extends StatelessWidget {
  const ServiceFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            FeatureItem(
                icon: CupertinoIcons.money_dollar_circle, label: 'Cash\nBack'),
            FeatureItem(icon: CupertinoIcons.cube_box, label: 'Free\nShipping'),
            FeatureItem(
                icon: CupertinoIcons.shield, label: 'Buyer\nProtection'),
            FeatureItem(
                icon: CupertinoIcons.checkmark_seal,
                label: 'Quality\nAssurance'),
            FeatureItem(icon: CupertinoIcons.creditcard, label: 'Payflex'),
            FeatureItem(
                icon: CupertinoIcons.arrowshape_turn_up_left_circle,
                label: 'Quick\nDelivery'),
            FeatureItem(
                icon: CupertinoIcons.doc_checkmark, label: 'Pro-Tect\nCert.'),
            FeatureItem(
                icon: CupertinoIcons.arrow_2_circlepath, label: 'Easy\nReturn'),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1939),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: CupertinoColors.activeOrange, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
