// lib/screens/super_deals_screen.dart
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'dart:async';

class SuperDealsScreen extends StatefulWidget {
  const SuperDealsScreen({super.key});

  @override
  State<SuperDealsScreen> createState() => _SuperDealsScreenState();
}

class _SuperDealsScreenState extends State<SuperDealsScreen> {
  Timer? _timer;
  int _seconds = 28;
  int _minutes = 4;
  int _hours = 8;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            if (_hours > 0) {
              _hours--;
              _minutes = 59;
              _seconds = 59;
            } else {
              timer.cancel();
            }
          }
        }
      });
    });
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Super Deals',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.slider_horizontal_3,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDealsBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      color: const Color(0xFF05001E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UP TO 70% OFF',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.time,
                  color: CupertinoColors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(Deal deal) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Image.asset(
                'assets/images/a.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${deal.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF05001E),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF05001E),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${deal.discount}%',
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (deal.extraInfo != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        deal.extraInfo!,
                        style: TextStyle(
                          color: CupertinoColors.systemGrey.darkColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
                if (deal.rating != null && deal.soldCount != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.star_fill,
                        size: 14,
                        color: Color(0xFFF08D00),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        deal.rating!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${deal.soldCount} sold',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey.darkColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
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
            const MainSearchBar(),
            SliverToBoxAdapter(
              child: _buildDealsBanner(),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildDealCard(_deals[index]),
                  childCount: _deals.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Deal {
  final String image;
  final String price;
  final int discount;
  final String? extraInfo;
  final String? rating;
  final int? soldCount;

  const Deal({
    required this.image,
    required this.price,
    required this.discount,
    this.extraInfo,
    this.rating,
    this.soldCount,
  });
}

final List<Deal> _deals = [
  const Deal(
    image: 'assets/images/a.jpg',
    price: '252.91',
    discount: 54,
  ),
  const Deal(
    image: 'assets/images/a.jpg',
    price: '186.29',
    discount: 54,
  ),
  const Deal(
    image: 'assets/images/a.jpg',
    price: '7.64',
    discount: 57,
    extraInfo: 'Only 3 left',
    rating: '4.4',
    soldCount: 223,
  ),
  const Deal(
    image: 'assets/images/a.jpg',
    price: '276.71',
    discount: 49,
    extraInfo: 'Free shipping',
    rating: '4.7',
    soldCount: 416,
  ),
];
