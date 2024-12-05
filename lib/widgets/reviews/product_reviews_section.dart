// lib/widgets/reviews/product_reviews_section.dart

import 'package:e_commerce_app/screen/product/product_reviews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/reviews/review_details_drawer.dart';

class ProductReviewsSection extends StatefulWidget {
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

  @override
  State<ProductReviewsSection> createState() => _ProductReviewsSectionState();
}

class _ProductReviewsSectionState extends State<ProductReviewsSection> {
  String _selectedCategory = 'All Reviews';

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
            onPressed: () => _navigateToReviewScreen(context),
            child: Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Icon(
                    CupertinoIcons.star_fill,
                    color: index < widget.averageRating.floor()
                        ? const Color(0xFFFFA41C)
                        : CupertinoColors.systemGrey3,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.averageRating.toStringAsFixed(1),
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
          children: [
            _buildCategoryChip('All Reviews', widget.reviews.length),
            ...widget.reviewCategories.entries.map(
              (entry) => _buildCategoryChip(entry.key, entry.value),
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
            color:
                isSelected ? const Color(0xFFFFA41C) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category,
                style: TextStyle(
                  color: isSelected
                      ? CupertinoColors.white
                      : const Color(0xFF05001E),
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '($count)',
                style: TextStyle(
                  color: isSelected
                      ? CupertinoColors.white.withOpacity(0.8)
                      : const Color(0xFF05001E).withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, Review review) {
    return GestureDetector(
      onTap: () => _showReviewDetails(context, review),
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
                _buildReviewerAvatar(review),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReviewerInfo(review),
                      const Spacer(),
                      _buildReviewMetadata(review),
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
            _buildReviewActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewerAvatar(Review review) {
    return Container(
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
    );
  }

  Widget _buildReviewerInfo(Review review) {
    return Row(
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
    );
  }

  Widget _buildReviewMetadata(Review review) {
    return Row(
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
    );
  }

  Widget _buildReviewActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildActionButton(
          icon: CupertinoIcons.hand_thumbsup,
          label: 'Helpful',
          onPressed: () {},
        ),
        const SizedBox(width: 12),
        _buildActionButton(
          icon: CupertinoIcons.reply,
          label: 'Reply',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 12,
            color: CupertinoColors.activeBlue,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToReviewScreen(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ProductReviewsScreen(
          product: widget.product,
          averageRating: widget.averageRating,
          reviewCategories: widget.reviewCategories,
          reviews: widget.reviews,
          initialCategory: _selectedCategory,
        ),
      ),
    );
  }

  void _showReviewDetails(BuildContext context, Review review) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => ReviewDetailsDrawer(review: review),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showAllReviews = widget.reviews.length > 3;
    final reviewCount = widget.reviews.length > 999
        ? '${(widget.reviews.length / 1000).toStringAsFixed(1)}K'
        : widget.reviews.length.toString();

    final filteredReviews = _selectedCategory == 'All Reviews'
        ? widget.reviews
        : widget.reviews
            .where((review) => review.comment
                .toLowerCase()
                .contains(_selectedCategory.toLowerCase()))
            .toList();

    final displayedReviews =
        showAllReviews ? filteredReviews.take(3).toList() : filteredReviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingHeader(context),
        _buildReviewCategories(),
        const SizedBox(height: 16),
        if (displayedReviews.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'No reviews in this category',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 15,
                ),
              ),
            ),
          )
        else
          ...displayedReviews
              .map((review) => _buildReviewItem(context, review)),
        if (showAllReviews) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoButton(
              onPressed: () => _navigateToReviewScreen(context),
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
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
