// lib/widgets/checkout/checkout_bottom_bar.dart
import 'package:flutter/cupertino.dart';

class CheckoutBottomBar extends StatelessWidget {
  final VoidCallback onPlaceOrder;

  const CheckoutBottomBar({
    super.key,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
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
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPlaceOrder,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: CupertinoColors.activeOrange,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: Text(
              'Place Order',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
