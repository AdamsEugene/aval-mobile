// lib/screens/reseller_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/widgets/reseller/analytics_card.dart';
import 'package:e_commerce_app/widgets/reseller/inventory_card.dart';
import 'package:e_commerce_app/widgets/reseller/sales_report_card.dart';

class ResellerScreen extends StatelessWidget {
  const ResellerScreen({super.key});

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            'Dashboard',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.bell,
          onPressed: () {},
          badgeCount: 2,
        ),
        HeaderAction(
          icon: CupertinoIcons.person_circle,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, David!',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Here's what's happening with your store today.",
                      style: TextStyle(
                        color: CupertinoColors.systemGrey.darkColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const AnalyticsCard(),
                    const SizedBox(height: 16),
                    const InventoryCard(),
                    const SizedBox(height: 16),
                    const SalesReportCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
