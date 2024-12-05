import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

class ProductReviewsScreen extends StatefulWidget {
  final Product product;
  final double averageRating;
  final Map<String, int> reviewCategories;
  final List<Review> reviews;
  final String initialCategory;

  const ProductReviewsScreen(
      {super.key,
      required this.product,
      required this.averageRating,
      required this.reviewCategories,
      required this.reviews,
      required this.initialCategory});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  String _selectedCategory = 'All Reviews';

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(
                    CupertinoIcons.back,
                    color: Color(0xFF05001E),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Reviews',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF05001E),
                  ),
                ),
                const Spacer(),
                Text(
                  widget.averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFA41C),
                  ),
                ),
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (index) => Icon(
                    CupertinoIcons.star_fill,
                    color: index < widget.averageRating.floor()
                        ? const Color(0xFFFFA41C)
                        : CupertinoColors.systemGrey3,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildCategoryChip('All Reviews', widget.reviews.length),
                  ...widget.reviewCategories.entries.map(
                    (e) => _buildCategoryChip(e.key, e.value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category, int count) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => setState(() => _selectedCategory = category),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFA41C)
                : CupertinoColors.systemGrey6,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$category ($count)',
            style: TextStyle(
              color: isSelected ? CupertinoColors.white : CupertinoColors.black,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSummary() {
    final totalReviews = widget.reviews.length;
    final ratingCounts = List.generate(5, (index) => 0);

    for (final review in widget.reviews) {
      ratingCounts[review.rating - 1]++;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(5, (index) {
          final reverseIndex = 4 - index;
          final count = ratingCounts[reverseIndex];
          final percentage =
              totalReviews > 0 ? (count / totalReviews) * 100 : 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  '${reverseIndex + 1}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  CupertinoIcons.star_fill,
                  size: 14,
                  color: Color(0xFFFFA41C),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percentage / 100,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA41C),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemGrey5,
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    review.reviewerName[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.reviewerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CupertinoColors.white,
                            border: Border.all(
                              color: CupertinoColors.systemGrey4,
                              width: 1,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://flagcdn.com/w20/gh.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            CupertinoIcons.star_fill,
                            size: 16,
                            color: index < review.rating
                                ? const Color(0xFFFFA41C)
                                : CupertinoColors.systemGrey3,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          review.date.toString().substring(0, 10),
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 15,
              color: CupertinoColors.black,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.hand_thumbsup,
                      size: 16,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Helpful',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.reply,
                      size: 16,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Reply',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _buildRatingSummary(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildReviewItem(widget.reviews[index]),
                    childCount: widget.reviews.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
