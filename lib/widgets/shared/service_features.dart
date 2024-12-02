// lib/widgets/shared/service_features.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ServiceFeatures extends StatelessWidget {
  const ServiceFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: Platform.isIOS
              ? const AlwaysScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          children: const [
            FeatureItem(
              icon: Icons.attach_money,
              iosIcon: CupertinoIcons.money_dollar_circle,
              label: 'Cash Back',
            ),
            FeatureItem(
              icon: Icons.local_shipping_outlined,
              iosIcon: CupertinoIcons.cube_box,
              label: 'Free Shipping',
            ),
            FeatureItem(
              icon: Icons.security,
              iosIcon: CupertinoIcons.shield,
              label: 'Buyer Protection',
            ),
            FeatureItem(
              icon: Icons.verified,
              iosIcon: CupertinoIcons.checkmark_seal,
              label: 'Quality Assurance',
            ),
            FeatureItem(
              icon: Icons.credit_card,
              iosIcon: CupertinoIcons.creditcard,
              label: 'Payflex',
            ),
            FeatureItem(
              icon: Icons.local_shipping,
              iosIcon: CupertinoIcons.arrowshape_turn_up_left_circle,
              label: 'Quick Delivery',
            ),
            FeatureItem(
              icon: Icons.verified_user,
              iosIcon: CupertinoIcons.doc_checkmark,
              label: 'Pro-Tect Cert.',
            ),
            FeatureItem(
              icon: Icons.replay,
              iosIcon: CupertinoIcons.arrow_2_circlepath,
              label: 'Easy Return',
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final IconData iosIcon;
  final String label;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.iosIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final platformIcon = Platform.isIOS ? iosIcon : icon;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          // Handle feature tap
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 80,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1939),
            borderRadius: BorderRadius.circular(12),
            boxShadow: Platform.isIOS
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                platformIcon,
                color: Platform.isIOS
                    ? CupertinoColors.activeOrange
                    : Colors.orange,
                size: 16,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Platform.isIOS ? CupertinoColors.white : Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
