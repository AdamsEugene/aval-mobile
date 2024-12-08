// lib/widgets/product/product_bottom_bar.dart
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screen/checkout/checkout_screen.dart';
import 'package:e_commerce_app/screen/payment/payment_plans_sheet.dart';
import 'package:flutter/cupertino.dart';

class ProductBottomBar extends StatelessWidget {
  final Product product;
  const ProductBottomBar({super.key, required this.product});

  void _showPaymentPlan(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => PaymentPlansSheet(
        productPrice: product.price,
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
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => CheckoutScreen(product: product),
                  ),
                );
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeOrange,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.activeOrange.withOpacity(0.2),
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
