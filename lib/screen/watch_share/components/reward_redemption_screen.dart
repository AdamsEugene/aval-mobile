import 'package:flutter/cupertino.dart';

class RewardRedemptionScreen extends StatefulWidget {
  final String title;
  final String coins;
  final String description;
  final double progress;
  final bool isLocked;

  const RewardRedemptionScreen({
    super.key,
    required this.title,
    required this.coins,
    required this.description,
    required this.progress,
    this.isLocked = false,
  });

  @override
  State<RewardRedemptionScreen> createState() => _RewardRedemptionScreenState();
}

class _RewardRedemptionScreenState extends State<RewardRedemptionScreen> {
  bool _redeemed = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Reward Details'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reward Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFB75E),
                        Color(0xFFED8F03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFED8F03).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.description,
                                style: TextStyle(
                                  color: CupertinoColors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.bitcoin,
                                  color: CupertinoColors.white,
                                  size: 24,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.coins,
                                  style: const TextStyle(
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (widget.isLocked) ...[
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.lock_fill,
                              color: CupertinoColors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Unlock progress:',
                              style: TextStyle(
                                color: CupertinoColors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 10,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: CupertinoColors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width *
                                  widget.progress *
                                  0.88, // Adjust for padding
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(widget.progress * 100).toInt()}% complete',
                          style: TextStyle(
                            color: CupertinoColors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Reward details
                const Text(
                  'Reward Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                _buildDetailItem(
                  'Type',
                  'Premium Content Access',
                  CupertinoIcons.star_fill,
                ),
                _buildDetailItem(
                  'Validity',
                  '30 days from redemption',
                  CupertinoIcons.calendar,
                ),
                _buildDetailItem(
                  'Availability',
                  'Limited time offer',
                  CupertinoIcons.time,
                ),
                _buildDetailItem(
                  'Share with family',
                  'Allowed',
                  CupertinoIcons.person_2_fill,
                ),
                
                const SizedBox(height: 24),
                
                // What you get
                const Text(
                  'What You Get',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                _buildBenefitItem(
                  'Exclusive premium content access',
                ),
                _buildBenefitItem(
                  'Ad-free viewing experience',
                ),
                _buildBenefitItem(
                  'Early access to new releases',
                ),
                _buildBenefitItem(
                  'Downloadable content for offline viewing',
                ),
                
                const SizedBox(height: 24),
                
                // Terms
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This reward can only be redeemed once per account. '
                        'Premium access will expire after 30 days unless renewed. '
                        'Sharing is limited to family members added to your account. '
                        'Content availability may vary by region.',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Redeem button
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: widget.isLocked
                        ? CupertinoColors.systemGrey
                        : _redeemed
                            ? CupertinoColors.systemGrey
                            : CupertinoColors.activeOrange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    borderRadius: BorderRadius.circular(12),
                    onPressed: widget.isLocked || _redeemed
                        ? null
                        : () {
                            setState(() {
                              _redeemed = true;
                            });
                            _showRedemptionSuccess(context);
                          },
                    child: Text(
                      widget.isLocked
                          ? 'Locked'
                          : _redeemed
                              ? 'Redeemed'
                              : 'Redeem Now',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: CupertinoColors.activeOrange,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            CupertinoIcons.checkmark_circle_fill,
            color: CupertinoColors.activeGreen,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRedemptionSuccess(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 340,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: CupertinoColors.activeGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.checkmark,
                color: CupertinoColors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Successfully Redeemed!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You have successfully redeemed ${widget.title}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your premium access is now active',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
              ),
            ),
            const SizedBox(height: 24),
            CupertinoButton(
              color: CupertinoColors.activeOrange,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 14,
              ),
              borderRadius: BorderRadius.circular(12),
              child: const Text(
                'Start Exploring',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
} 