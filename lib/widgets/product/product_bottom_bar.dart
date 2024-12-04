// lib/widgets/product/product_bottom_bar.dart
import 'package:flutter/cupertino.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key});

  void _showPaymentPlan(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
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
            const Text(
              'Payment Plans',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF05001E),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Payment Plan Button
          SizedBox(
            width: 110, // Fixed width for all buttons
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showPaymentPlan(context),
              child: Container(
                height: 44, // Fixed height for all buttons
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFEEEEEE),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.money_dollar,
                      color: Color(0xFF05001E),
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Plan',
                      style: TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Add to Cart Button
          SizedBox(
            width: 110,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Handle add to cart
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF05001E),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF05001E).withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Cart',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Buy Now Button
          SizedBox(
            width: 110,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Handle buy now
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDC202),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFDC202).withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
