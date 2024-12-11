import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class CouponDrawer extends StatefulWidget {
  const CouponDrawer({super.key});

  @override
  State<CouponDrawer> createState() => _CouponDrawerState();
}

class _CouponDrawerState extends State<CouponDrawer> {
  String _selectedTab = 'Available';
  final List<String> _tabs = ['Available', 'Used', 'Expired'];

  final List<CouponItem> _coupons = [
    CouponItem(
      code: 'WELCOME20',
      title: 'First Order',
      discount: '20% OFF',
      minSpend: 50.00,
      expiry: DateTime.now().add(const Duration(days: 7)),
      type: CouponType.percentage,
      terms: ['Valid for first order only', 'Maximum discount: \$20'],
    ),
    CouponItem(
      code: 'FREESHIP',
      title: 'Free Shipping',
      discount: 'FREE',
      minSpend: 30.00,
      expiry: DateTime.now().add(const Duration(days: 14)),
      type: CouponType.shipping,
      terms: [
        'Valid for standard shipping only',
        'Cannot be combined with other offers'
      ],
    ),
    CouponItem(
      code: 'COINS10',
      title: 'Coins Discount',
      discount: '2% OFF',
      minSpend: 0.00,
      expiry: DateTime.now().add(const Duration(days: 30)),
      type: CouponType.coins,
      terms: ['Must use coins for payment', 'No minimum spend required'],
    ),
  ];

  Widget _buildCouponCard(CouponItem coupon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getCouponColor(coupon.type).withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getCouponColor(coupon.type).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCouponIcon(coupon.type),
                    color: _getCouponColor(coupon.type),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Min. spend \$${coupon.minSpend.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey.darkColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      coupon.discount,
                      style: TextStyle(
                        color: _getCouponColor(coupon.type),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_getDaysLeft(coupon.expiry)} days left',
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.doc_text,
                            size: 14,
                            color: Color(0xFF05001E),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            coupon.code,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Copy code
                      },
                      child: const Text(
                        'Copy',
                        style: TextStyle(
                          color: Color(0xFF05001E),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Terms & Conditions:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                ...coupon.terms.map((term) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 12)),
                          Expanded(
                            child: Text(
                              term,
                              style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.systemGrey.darkColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCouponColor(CouponType type) {
    switch (type) {
      case CouponType.percentage:
        return const Color(0xFF05001E);
      case CouponType.shipping:
        return CupertinoColors.activeGreen;
      case CouponType.coins:
        return CupertinoColors.activeOrange;
    }
  }

  IconData _getCouponIcon(CouponType type) {
    switch (type) {
      case CouponType.percentage:
        return CupertinoIcons.percent;
      case CouponType.shipping:
        return CupertinoIcons.bus;
      case CouponType.coins:
        return CupertinoIcons.money_dollar_circle_fill;
    }
  }

  int _getDaysLeft(DateTime expiry) {
    return expiry.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: _tabs.map((tab) {
                final isSelected = tab == _selectedTab;
                return CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () => setState(() => _selectedTab = tab),
                  color: isSelected
                      ? const Color(0xFF05001E)
                      : CupertinoColors.white,
                  borderRadius: BorderRadius.circular(18),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected
                          ? CupertinoColors.white
                          : const Color(0xFF05001E),
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children:
                    _coupons.map((coupon) => _buildCouponCard(coupon)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CouponType {
  percentage,
  shipping,
  coins,
}

class CouponItem {
  final String code;
  final String title;
  final String discount;
  final double minSpend;
  final DateTime expiry;
  final CouponType type;
  final List<String> terms;

  const CouponItem({
    required this.code,
    required this.title,
    required this.discount,
    required this.minSpend,
    required this.expiry,
    required this.type,
    required this.terms,
  });
}
