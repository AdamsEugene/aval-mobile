import 'package:e_commerce_app/widgets/reviews/review_gallery_viewer.dart';
import 'package:flutter/cupertino.dart';

class ReviewGallerySection extends StatelessWidget {
  final List<String> images;
  final VoidCallback onViewAll;

  const ReviewGallerySection({
    super.key,
    required this.images,
    required this.onViewAll,
  });

  Widget _buildGalleryHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Review gallery',
            style: TextStyle(
              color: Color(0xFF05001E),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onViewAll,
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.chevron_right,
                  color: Color(0xFF05001E),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryGrid(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          const SizedBox(width: 16),
          ...images.map((image) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => ReviewGalleryViewer(
                          images: [image],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: CupertinoColors.systemGrey6,
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.photo,
                                size: 32,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGalleryHeader(),
          const SizedBox(height: 16),
          _buildGalleryGrid(context),
        ],
      ),
    );
  }
}
