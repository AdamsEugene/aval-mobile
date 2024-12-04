// lib/widgets/return_policy/return_policy_section.dart
import 'package:flutter/cupertino.dart';
import 'return_policy_drawer.dart';

class ReturnPolicySection extends StatelessWidget {
  const ReturnPolicySection({super.key});

  void _showReturnPolicy(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const ReturnPolicyDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _showReturnPolicy(context),
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
                CupertinoIcons.arrow_2_circlepath,
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
                    'Return Policy',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem.',
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
