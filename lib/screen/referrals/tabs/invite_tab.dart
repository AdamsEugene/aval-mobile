// lib/screens/referrals/tabs/invite_tab.dart
import 'package:flutter/cupertino.dart';
import '../components/referral_code_card.dart';

class InviteTab extends StatelessWidget {
  const InviteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              ReferralCodeCard(
                code: 'FRIEND50',
                onShare: () {
                  // Handle share
                },
                onCopy: () {
                  // Handle copy
                },
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How it works',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildStep(
                      1,
                      'Share your code',
                      'Send your unique code to friends',
                      CupertinoIcons.share,
                    ),
                    _buildStep(
                      2,
                      'Friends join',
                      'Your friends sign up using your code',
                      CupertinoIcons.person_add,
                    ),
                    _buildStep(
                      3,
                      'Earn rewards',
                      'Get bonus when friends complete actions',
                      CupertinoIcons.gift,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildStep(int number, String title, String description, IconData icon,
      {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFFEEAD1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: CupertinoColors.activeOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: CupertinoColors.activeOrange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 14,
                ),
              ),
              if (!isLast) const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
