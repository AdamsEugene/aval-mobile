// lib/widgets/product/floating_cart_button.dart
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/cart/cart_drawer.dart';
import 'package:flutter/cupertino.dart';

class FloatingCartButton extends StatelessWidget {
  final Product product;

  const FloatingCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 80 + MediaQuery.of(context).padding.bottom,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          CartDrawer.show(context, product);
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: CupertinoColors.activeOrange,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.activeOrange.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Cart Icon
              const Center(
                child: Icon(
                  CupertinoIcons.cart_fill,
                  color: CupertinoColors.white,
                  size: 24,
                ),
              ),
              // Cart Badge
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF05001E),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: CupertinoColors.white,
                      width: 1.5,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: const Text(
                    '3',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
