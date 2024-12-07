import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class SuperDealsPage extends StatefulWidget {
  const SuperDealsPage({super.key});

  @override
  State<SuperDealsPage> createState() => _SuperDealsPageState();
}

class _SuperDealsPageState extends State<SuperDealsPage> {
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: HeaderDelegate(
              showProfile: false,
              showBackButton: true,
              title: 'SuperDeals',
              extent: 220,
              fontSize: 24,
            ),
          ),
          const SliverToBoxAdapter(
            child: _DealsHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: CupertinoColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Daily deals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 16,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Text('Ends: '),
                        Text(
                          '${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _DealCard(deal: _deals[index]),
                childCount: _deals.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DealsHeader extends StatelessWidget {
  const _DealsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFE31837),
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
              color: CupertinoColors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Limited-time offers',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DealCard extends StatelessWidget {
  final Deal deal;

  const _DealCard({required this.deal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: Image.asset(
                'assets/images/a.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GHS${deal.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE31837),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${deal.discount}%',
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Low stock',
                      style: TextStyle(
                        color: Color(0xFFE31837),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (deal.extraInfo != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    deal.extraInfo!,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
                if (deal.rating != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${deal.soldCount} sold',
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        CupertinoIcons.star_fill,
                        size: 12,
                        color: Color(0xFFffd700),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        deal.rating!,
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
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
    image: 'shoe1.jpg',
    price: '252.91',
    discount: 54,
  ),
  const Deal(
    image: 'pants.jpg',
    price: '186.29',
    discount: 54,
  ),
  const Deal(
    image: 'shoe2.jpg',
    price: '7.64',
    discount: 57,
    extraInfo: 'Only 3 left',
    rating: '4.4',
    soldCount: 223,
  ),
  const Deal(
    image: 'shoe3.jpg',
    price: '276.71',
    discount: 49,
    extraInfo: 'Free shipping',
    rating: '4.7',
    soldCount: 416,
  ),
];
