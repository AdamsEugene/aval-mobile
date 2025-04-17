import 'package:e_commerce_app/widgets/promo/pattern_painters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widgets/promo/promo_ads_modal.dart';
import 'package:e_commerce_app/services/ads_service.dart';

class PromoBanner extends StatelessWidget {
  final PromoAdData adData;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final Color startColor;
  final Color endColor;
  final Color textColor;
  final double height;
  final bool showViewButton;
  final bool useDiagonalPattern; // Option to switch between patterns

  const PromoBanner({
    super.key,
    required this.adData,
    this.onTap,
    this.onDismiss,
    this.startColor = const Color(0xFFFF8008),
    this.endColor = const Color(0xFFFFC837),
    this.textColor = Colors.white,
    this.height = 80,
    this.showViewButton = true,
    this.useDiagonalPattern = false, // Default to dot pattern
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the promo modal when banner is tapped
        PromoAdsModal.show(
          context,
          title: adData.title,
          description: adData.description,
          imageUrl: adData.imageUrl,
          buttonText: adData.buttonText,
          promoCode: adData.promoCode,
          expiryDate: adData.expiryDate,
          discount: adData.discount,
          isNewCustomerOnly: adData.isNewCustomerOnly,
          onButtonPressed: onTap,
          onDismiss: onDismiss,
        );
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: startColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Use either dot pattern or diagonal pattern based on useDiagonalPattern flag
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomPaint(
                  painter: useDiagonalPattern
                      ? DiagonalPatternPainter(
                          lineColor: textColor.withOpacity(0.2),
                          lineWidth: 1.5,
                          spacing: 25,
                          angle: 45,
                        )
                      : DotPatternPainter(
                          dotColor: textColor.withOpacity(0.2),
                          dotSize: 4,
                          spacing: 20,
                          isStaggered: true,
                        ),
                ),
              ),
            ),

            Row(
              children: [
                // Left side with icon
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Icon(
                    _getIconForPromo(adData.id),
                    color: textColor,
                    size: 40,
                  ),
                ),

                // Middle with text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adData.title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getSubtitle(),
                        style: TextStyle(
                          color: textColor.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right side with button hint
                if (showViewButton)
                  Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: textColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: startColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            // Dismiss button (X)
            if (onDismiss != null)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.clear,
                      color: textColor,
                      size: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Get a context-appropriate subtitle for the banner
  String _getSubtitle() {
    // If discount is available, use that
    if (adData.discount > 0) {
      return 'Up to ${adData.discount.toStringAsFixed(0)}% off';
    }

    // If promo code is available, mention it
    if (adData.promoCode.isNotEmpty) {
      return 'Use code: ${adData.promoCode}';
    }

    // If expiry date is available, show countdown
    if (adData.expiryDate != null) {
      final now = DateTime.now();
      final difference = adData.expiryDate!.difference(now);
      final days = difference.inDays;

      if (days <= 0) {
        return 'Last day! Expires today';
      } else if (days == 1) {
        return 'Expires tomorrow';
      } else {
        return 'Expires in $days days';
      }
    }

    // Default subtitle
    return 'Tap to see details';
  }

  /// Choose an icon based on the promo type
  IconData _getIconForPromo(String promoId) {
    switch (promoId) {
      case 'spring_sale_2025':
      case 'summer_sale':
      case 'winter_sale':
        return CupertinoIcons.tag_fill;
      case 'new_user_welcome':
        return CupertinoIcons.gift_fill;
      case 'premium_magic_box':
        return CupertinoIcons.sparkles;
      case 'free_shipping':
        return CupertinoIcons.cart_fill;
      default:
        return CupertinoIcons.star_fill;
    }
  }
}
