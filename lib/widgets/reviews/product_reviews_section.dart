import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screen/product/product_eviews_screen.dart';
import 'package:e_commerce_app/widgets/reviews/review_details_drawer.dart';
import 'package:flutter/cupertino.dart';

class ProductReviewsSection extends StatelessWidget {
  final Product product;
  final List<Review> reviews;
  final double averageRating;
  final Map<String, int> reviewCategories;

  const ProductReviewsSection({
    super.key,
    required this.product,
    required this.reviews,
    required this.averageRating,
    required this.reviewCategories,
  });

  Widget _buildRatingHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            'Reviews',
            style: TextStyle(
              color: Color(0xFF05001E),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => ProductReviewsScreen(
                    product: product,
                    averageRating: averageRating,
                    reviewCategories: reviewCategories,
                    reviews: reviews,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Icon(
                    CupertinoIcons.star_fill,
                    color: index < averageRating.floor()
                        ? const Color(0xFFFFA41C)
                        : CupertinoColors.systemGrey3,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFA41C),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.chevron_right,
                  color: CupertinoColors.black,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: reviewCategories.entries.map((entry) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: CupertinoButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(20),
                onPressed: () {},
                child: Text(
                  '${entry.key}(${entry.value})',
                  style: const TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, Review review) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => ReviewDetailsDrawer(review: review),
        );
      },
      child: Container(
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
                            child: Image.network(
                              'https://flagcdn.com/w20/gh.png',
                              width: 15,
                              height: 15,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                color: CupertinoColors.black,
                height: 1.4,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.hand_thumbsup,
                        size: 12,
                        color: CupertinoColors.activeBlue,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Helpful',
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.reply,
                        size: 12,
                        color: CupertinoColors.activeBlue,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: 12,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showAllReviews = reviews.length > 2;
    final reviewCount = reviews.length > 999
        ? '${(reviews.length / 1000).toStringAsFixed(1)}K'
        : reviews.length.toString();
    final displayedReviews =
        showAllReviews ? reviews.take(3).toList() : reviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingHeader(context),
        _buildReviewCategories(),
        const SizedBox(height: 16),
        ...displayedReviews.map((review) => _buildReviewItem(context, review)),
        if (showAllReviews) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => ProductReviewsScreen(
                      product: product,
                      averageRating: averageRating,
                      reviewCategories: reviewCategories,
                      reviews: reviews,
                    ),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: CupertinoColors.systemGrey4,
                  //   width: 1,
                  // ),
                  borderRadius: BorderRadius.circular(12),
                  color: CupertinoColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'All Reviews ($reviewCount)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      CupertinoIcons.chevron_right,
                      color: Color(0xFF05001E),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
