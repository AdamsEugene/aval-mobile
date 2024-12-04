// lib/widgets/subscription/subscription_info_section.dart
import 'package:flutter/cupertino.dart';
import 'subscription_info_drawer.dart';

class SubscriptionInfoSection extends StatelessWidget {
  const SubscriptionInfoSection({super.key});

  void _showSubscriptionInfo(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const SubscriptionInfoDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _showSubscriptionInfo(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEEAD1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                CupertinoIcons.repeat,
                color: Color(0xFFFDC202),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Subscribe To Receive Regular Product Deliveries On Weekly Or Monthly Basis.',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color(0xFF05001E),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
