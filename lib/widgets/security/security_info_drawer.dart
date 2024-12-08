// lib/widgets/security/security_info_drawer.dart
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/cupertino.dart';

class SecurityInfoDrawer extends StatelessWidget {
  const SecurityInfoDrawer({super.key});

  Widget _buildSecurityFeature({
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
            'Security & Privacy',
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
                  _buildSecurityFeature(
                    title: 'Secure Payments',
                    description:
                        'All payments are processed securely using industry-standard encryption. We support multiple payment methods including credit cards, PayPal, and more.',
                    icon: CupertinoIcons.creditcard_fill,
                  ),
                  _buildSecurityFeature(
                    title: 'Data Protection',
                    description:
                        'Your personal information is protected using advanced encryption technologies. We never share your data with third parties without your consent.',
                    icon: CupertinoIcons.lock_fill,
                  ),
                  _buildSecurityFeature(
                    title: 'Fraud Protection',
                    description:
                        'Our advanced fraud detection system monitors all transactions to ensure your safety. Any suspicious activity is immediately flagged and investigated.',
                    icon: CupertinoIcons.shield_fill,
                  ),
                  _buildSecurityFeature(
                    title: 'Privacy Policy',
                    description:
                        'We are committed to protecting your privacy. Our detailed privacy policy outlines how we collect, use, and protect your personal information.',
                    icon: CupertinoIcons.doc_text_fill,
                  ),
                  _buildSecurityFeature(
                    title: 'Buyer Protection',
                    description:
                        'Shop with confidence knowing that all purchases are covered by our buyer protection program. Get full refund if item not received or not as described.',
                    icon: CupertinoIcons.hand_thumbsup_fill,
                  ),
                  const SizedBox(height: 16),
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
                              color: CupertinoColors.activeOrange,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Need Help?',
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
                          'If you have any questions about our security measures or privacy policy, please contact our support team. We\'re here to help 24/7.',
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
