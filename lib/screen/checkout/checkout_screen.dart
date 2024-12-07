// lib/screens/checkout/checkout_screen.dart
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screen/checkout/sections/delivery_address_section.dart';
import 'package:e_commerce_app/screen/checkout/sections/payment_method_section.dart';
import 'package:e_commerce_app/screen/checkout/sections/product_summary_card.dart';
import 'package:e_commerce_app/widgets/checkout/checkout_bottom_bar.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:flutter/cupertino.dart';

class CheckoutScreen extends StatelessWidget {
  final Product product;

  const CheckoutScreen({
    super.key,
    required this.product,
  });

  void _handlePlaceOrder() {
    // Add your order placement logic here
    debugPrint('Placing order...');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Stack(
        children: [
          CustomScrollView(
            // Add padding at the bottom to account for the CheckoutBottomBar
            slivers: [
              SliverPersistentHeader(
                delegate: HeaderDelegate(
                  showProfile: false,
                  showBackButton: true,
                  title: 'Checkout',
                  extent: 220,
                  fontSize: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    // Add bottom padding to ensure content isn't hidden behind the bottom bar
                    bottom: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DeliveryAddressSection(),
                      const SizedBox(height: 16),
                      ProductSummaryCard(product: product),
                      const SizedBox(height: 16),
                      const PaymentMethodSection(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Position the CheckoutBottomBar at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CheckoutBottomBar(
              onPlaceOrder: _handlePlaceOrder,
            ),
          ),
        ],
      ),
    );
  }
}
