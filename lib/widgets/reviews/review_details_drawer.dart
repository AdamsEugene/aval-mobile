// lib/widgets/reviews/review_details_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/product.dart';

class ReviewDetailsDrawer extends StatelessWidget {
  final Review review;

  const ReviewDetailsDrawer({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
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
                      fontSize: 20,
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
          const SizedBox(height: 16),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.black,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
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
                      size: 20,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Helpful',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.reply,
                      size: 20,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Reply',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
