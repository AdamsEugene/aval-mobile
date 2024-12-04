// lib/widgets/protection/protection_plan_section.dart
import 'package:flutter/cupertino.dart';
import 'protection_plan_drawer.dart';

class ProtectionPlanSection extends StatelessWidget {
  const ProtectionPlanSection({super.key});

  void _showProtectionPlan(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const ProtectionPlanDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _showProtectionPlan(context),
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
                CupertinoIcons.shield_lefthalf_fill,
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
                    'Protection Plan',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Get Protection Plan To Safeguard Your Product Against Damages.',
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
