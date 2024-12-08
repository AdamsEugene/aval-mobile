import 'package:e_commerce_app/widgets/product/store_info_drawer.dart';
import 'package:flutter/cupertino.dart';

class StoreInfoSection extends StatelessWidget {
  const StoreInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Store Logo
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.network(
                    'https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text(
                        'Aval',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Store Name
              const Text(
                'Yewobi Store - Gh',
                style: TextStyle(
                  color: Color(0xFF05001E),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              // All badges in a row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Follow Counter
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF05001E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: 24, // Fixed width and height for circular shape
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF05001E),
                        shape: BoxShape.circle, // Makes it perfectly round
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center content vertically
                        children: [
                          const Text(
                            '20K',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'follow',
                            style: TextStyle(
                              color: CupertinoColors.white.withOpacity(0.8),
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Rating
                  const Row(
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: CupertinoColors.activeOrange,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '4.9',
                        style: TextStyle(
                          color: Color(0xFF05001E),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // Verified Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_seal_fill,
                          color: CupertinoColors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'AVAL Verified',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem.',
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => StoreInfoDrawer.show(context),
                child: const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: Color(0xFF05001E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
