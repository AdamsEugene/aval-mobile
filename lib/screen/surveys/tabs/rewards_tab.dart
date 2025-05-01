// lib/screens/surveys/tabs/rewards_tab.dart
import 'package:flutter/cupertino.dart';

class SurveyRewardsTab extends StatefulWidget {
  const SurveyRewardsTab({super.key});

  @override
  State<SurveyRewardsTab> createState() => _SurveyRewardsTabState();
}

class _SurveyRewardsTabState extends State<SurveyRewardsTab> {
  // Sample reward items
  final List<Map<String, dynamic>> _rewardsTiers = [
    {
      'name': 'Bronze Tier',
      'points': 500,
      'benefits': [
        '10% Discount on Store Items',
        'Access to Basic Surveys',
      ],
      'isUnlocked': true,
    },
    {
      'name': 'Silver Tier',
      'points': 1000,
      'benefits': [
        '15% Discount on Store Items',
        'Priority Access to New Surveys',
        'Bonus Points on Completion',
      ],
      'isUnlocked': true,
    },
    {
      'name': 'Gold Tier',
      'points': 2000,
      'benefits': [
        '25% Discount on Store Items',
        'Early Access to Products',
        'Double Points on Weekend Surveys',
        'Personalized Survey Recommendations',
      ],
      'isUnlocked': false,
    },
    {
      'name': 'Platinum Tier',
      'points': 5000,
      'benefits': [
        '40% Discount on Store Items',
        'VIP Support',
        'Exclusive Product Testing Opportunities',
        'Monthly Bonus Rewards',
        'Custom Survey Creation',
      ],
      'isUnlocked': false,
    },
  ];

  // Updated rewards catalog to match documentation requirements
  final List<Map<String, dynamic>> _rewardsCatalog = [
    {
      'name': '10% Store Discount',
      'points': 200,
      'type': 'Store Discount',
      'expiry': '30 days',
      'imageName': 'discount'
    },
    {
      'name': '25% Store Discount',
      'points': 500,
      'type': 'Store Discount',
      'expiry': '30 days',
      'imageName': 'discount'
    },
    {
      'name': 'Early Product Access',
      'points': 350,
      'type': 'Early Access',
      'expiry': '14 days',
      'imageName': 'early_access'
    },
    {
      'name': '\$10 Gift Card',
      'points': 400,
      'type': 'Gift Card',
      'expiry': 'No expiry',
      'imageName': 'gift_card'
    },
    {
      'name': '\$25 Gift Card',
      'points': 900,
      'type': 'Gift Card',
      'expiry': 'No expiry',
      'imageName': 'gift_card'
    },
    {
      'name': 'Premium Service Upgrade',
      'points': 750,
      'type': 'Premium Service',
      'expiry': '6 months',
      'imageName': 'premium'
    },
  ];

  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Store Discount', 'Gift Card', 'Early Access', 'Premium Service'];

  @override
  Widget build(BuildContext context) {
    // Filter rewards catalog based on selected category
    final filteredRewards = _selectedCategory == 'All'
        ? _rewardsCatalog
        : _rewardsCatalog.where((reward) => reward['type'] == _selectedCategory).toList();

    return CustomScrollView(
      slivers: [
        // Header with title and points summary
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8E2DE2),
                  Color(0xFF4A00E0),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8E2DE2).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Points',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.bitcoin,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '2,500',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildStat('Surveys\nCompleted', '25'),
                    Container(
                      width: 1,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: CupertinoColors.white.withOpacity(0.3),
                    ),
                    _buildStat('Rewards\nRedeemed', '5'),
                    Container(
                      width: 1,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: CupertinoColors.white.withOpacity(0.3),
                    ),
                    _buildStat('Current\nTier', 'Silver'),
                  ],
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  color: CupertinoColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    _showHistoryDialog();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.clock,
                        color: CupertinoColors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'View Points History',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Reward tiers section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Reward Tiers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        // Reward tiers list
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            padding: const EdgeInsets.only(left: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _rewardsTiers.length,
              itemBuilder: (context, index) {
                final tier = _rewardsTiers[index];
                return _buildRewardTierCard(
                  name: tier['name'],
                  points: tier['points'],
                  benefits: List<String>.from(tier['benefits']),
                  isUnlocked: tier['isUnlocked'],
                );
              },
            ),
          ),
        ),
        
        // Rewards catalog section header with filters
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rewards Catalog',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Redeem Points',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8E2DE2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Redeem your survey points for a variety of rewards including store discounts, gift cards, early product access, and premium service upgrades.',
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 12),
                // Category indicators
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildCategoryTag('Store Discounts', const Color(0xFF4CAF50), CupertinoIcons.tag_fill),
                    _buildCategoryTag('Gift Cards', const Color(0xFF2196F3), CupertinoIcons.gift_fill),
                    _buildCategoryTag('Early Access', const Color(0xFFFF9800), CupertinoIcons.clock_fill),
                    _buildCategoryTag('Premium Services', const Color(0xFF9C27B0), CupertinoIcons.bolt_fill),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF8E2DE2)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected
                                  ? CupertinoColors.white
                                  : CupertinoColors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Rewards catalog grid
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final reward = filteredRewards[index];
                return _buildRewardItem(
                  name: reward['name'],
                  points: reward['points'],
                  type: reward['type'],
                  expiry: reward['expiry'],
                  imageName: reward['imageName'],
                );
              },
              childCount: filteredRewards.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CupertinoColors.white.withOpacity(0.8),
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardTierCard({
    required String name,
    required int points,
    required List<String> benefits,
    required bool isUnlocked,
  }) {
    final Color accentColor = isUnlocked ? const Color(0xFF8E2DE2) : CupertinoColors.systemGrey;
    
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tier header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isUnlocked
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.lock_fill,
                        size: 12,
                        color: isUnlocked
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isUnlocked ? 'Unlocked' : 'Locked',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isUnlocked
                              ? CupertinoColors.activeGreen
                              : CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Benefits list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$points Points',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: benefits.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.checkmark_alt,
                                size: 12,
                                color: accentColor,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  benefits[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isUnlocked
                                        ? CupertinoColors.black
                                        : CupertinoColors.systemGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardItem({
    required String name,
    required int points,
    required String type,
    required String expiry,
    required String imageName,
  }) {
    // Map icon based on type
    IconData getIconForType() {
      switch (type) {
        case 'Store Discount':
          return CupertinoIcons.tag_fill;
        case 'Gift Card':
          return CupertinoIcons.gift_fill;
        case 'Early Access':
          return CupertinoIcons.clock_fill;
        case 'Premium Service':
          return CupertinoIcons.bolt_fill;
        default:
          return CupertinoIcons.gift_fill;
      }
    }
    
    // Map color based on type
    Color getColorForType() {
      switch (type) {
        case 'Store Discount':
          return const Color(0xFF4CAF50);
        case 'Gift Card':
          return const Color(0xFF2196F3);
        case 'Early Access':
          return const Color(0xFFFF9800);
        case 'Premium Service':
          return const Color(0xFF9C27B0);
        default:
          return const Color(0xFF2196F3);
      }
    }

    return GestureDetector(
      onTap: () {
        _showRewardDetailsDialog(name, points, type, expiry, getIconForType(), getColorForType());
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reward image/icon
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: getColorForType().withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    getIconForType(),
                    size: 48,
                    color: getColorForType(),
                  ),
                ),
              ),
            ),
            
            // Reward info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: getColorForType().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: getColorForType(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$points pts',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8E2DE2),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        onPressed: () {
                          _showRedeemConfirmation(name, points);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8E2DE2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Redeem',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistoryDialog() {
    // Sample transaction history
    final transactions = [
      {'date': 'Apr 15, 2024', 'type': 'Earned', 'description': 'UX Survey', 'points': '+250'},
      {'date': 'Apr 10, 2024', 'type': 'Redeemed', 'description': '10% Off Coupon', 'points': '-200'},
      {'date': 'Apr 8, 2024', 'type': 'Earned', 'description': 'Product Feedback', 'points': '+300'},
      {'date': 'Apr 5, 2024', 'type': 'Earned', 'description': 'Market Research', 'points': '+175'},
      {'date': 'Apr 1, 2024', 'type': 'Tier Bonus', 'description': 'Silver Tier Reached', 'points': '+500'},
      {'date': 'Mar 28, 2024', 'type': 'Earned', 'description': 'User Testing', 'points': '+350'},
      {'date': 'Mar 25, 2024', 'type': 'Redeemed', 'description': 'Early Access Pass', 'points': '-350'},
      {'date': 'Mar 20, 2024', 'type': 'Earned', 'description': 'App Feedback', 'points': '+275'},
    ];

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Points History',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      CupertinoIcons.xmark,
                      size: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Summary stats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF8E2DE2).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Total Earned',
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '2,850',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8E2DE2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: CupertinoColors.systemGrey4,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Total Redeemed',
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '550',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8E2DE2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Transactions list header
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            // Transactions list
            Expanded(
              child: CupertinoScrollbar(
                child: ListView.separated(
                  itemCount: transactions.length,
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: CupertinoColors.systemGrey5,
                  ),
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final isPositive = transaction['points']!.startsWith('+');
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isPositive
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFBE9E7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              isPositive
                                  ? CupertinoIcons.arrow_down_circle_fill
                                  : CupertinoIcons.arrow_up_circle_fill,
                              color: isPositive
                                  ? CupertinoColors.activeGreen
                                  : CupertinoColors.systemRed,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction['description']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${transaction['type']} · ${transaction['date']}',
                                  style: const TextStyle(
                                    color: CupertinoColors.systemGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            transaction['points']!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: isPositive
                                  ? CupertinoColors.activeGreen
                                  : CupertinoColors.systemRed,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRewardDetailsDialog(
    String name,
    int points,
    String type,
    String expiry,
    IconData icon,
    Color color,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reward Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      CupertinoIcons.xmark,
                      size: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Reward image/icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Reward details
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Reward information
            _buildInfoRow('Points Cost', '$points points', const Color(0xFF8E2DE2)),
            const SizedBox(height: 12),
            _buildInfoRow('Expiry', expiry, CupertinoColors.systemGrey),
            const SizedBox(height: 12),
            _buildInfoRow('Availability', 'In Stock', CupertinoColors.activeGreen),
            const SizedBox(height: 12),
            _buildInfoRow('Terms', 'Standard terms apply', CupertinoColors.systemGrey),
            
            const Spacer(),
            
            // Redeem button
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: const Color(0xFF8E2DE2),
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                Navigator.pop(context);
                _showRedeemConfirmation(name, points);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_right_circle_fill, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Redeem Reward',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: CupertinoColors.systemGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  void _showRedeemConfirmation(String rewardName, int pointsCost) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirm Redemption'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.black,
                height: 1.4,
              ),
              children: [
                const TextSpan(
                  text: 'Are you sure you want to redeem ',
                ),
                TextSpan(
                  text: rewardName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' for ',
                ),
                TextSpan(
                  text: '$pointsCost points',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E2DE2),
                  ),
                ),
                const TextSpan(
                  text: '?',
                ),
              ],
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              // Handle redemption
              Navigator.pop(context);
              _showRedemptionSuccess(rewardName);
            },
            isDefaultAction: true,
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showRedemptionSuccess(String rewardName) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Redemption Successful!'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: CupertinoColors.activeGreen,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                'You have successfully redeemed $rewardName.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your reward details have been sent to your email and are also available in your Wallet section.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: const Text('Done'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to wallet section (not implemented)
            },
            child: const Text('View in Wallet'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTag(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
