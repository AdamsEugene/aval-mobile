// lib/screens/referrals/components/referral_code_card.dart
import 'package:flutter/cupertino.dart';

class ReferralCodeCard extends StatelessWidget {
  final String code;
  final VoidCallback? onShare;
  final VoidCallback? onCopy;

  const ReferralCodeCard({
    super.key,
    required this.code,
    this.onShare,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                CupertinoIcons.gift_fill,
                color: CupertinoColors.activeOrange,
              ),
              SizedBox(width: 8),
              Text(
                'Your Referral Code',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEEAD1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CupertinoColors.activeOrange,
                width: 2,
              ),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: CupertinoColors.activeOrange,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.activeOrange,
                  borderRadius: BorderRadius.circular(8),
                  onPressed: onCopy,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.doc_on_doc, size: 20),
                      SizedBox(width: 8),
                      Text('Copy'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.activeOrange,
                  borderRadius: BorderRadius.circular(8),
                  onPressed: onShare,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.share, size: 20),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
