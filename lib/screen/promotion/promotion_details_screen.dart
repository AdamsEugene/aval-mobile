import 'package:flutter/cupertino.dart';

class PromotionDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String imageUrl;
  final String? promoCode;

  const PromotionDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.imageUrl,
    this.promoCode,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Hero image
            Stack(
              children: [
                Image.asset(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: color.withOpacity(0.3),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.photo,
                          color: CupertinoColors.white,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
                // Gradient overlay
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.withOpacity(0.0),
                        color.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Title on image
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: CupertinoColors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Promotion details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Promo code if available
                  if (promoCode != null && promoCode!.isNotEmpty) ...[
                    const Text(
                      'Use this promo code at checkout:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: color.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            promoCode!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: color,
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Row(
                              children: [
                                Text(
                                  'Copy',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  CupertinoIcons.doc_on_doc,
                                  size: 16,
                                ),
                              ],
                            ),
                            onPressed: () {
                              // Copy promo code to clipboard
                              // In a real app, implement clipboard functionality
                              _showCopiedMessage(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Shop now button
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: color,
                      borderRadius: BorderRadius.circular(28),
                      child: const Text(
                        'Shop Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        // In a real app, navigate to products related to this promotion
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  
                  // Related products section
                  const SizedBox(height: 32),
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Placeholder for featured products
                  // In a real app, fetch and display actual products
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.2),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.cube_box,
                                    size: 40,
                                    color: color,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product ${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${19.99 + (index * 10)}',
                                      style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Terms and conditions
                  const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Promotion valid until supplies last\n'
                    '• Cannot be combined with other offers\n'
                    '• Prices subject to change without notice\n'
                    '• Shipping restrictions may apply',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                      height: 1.5,
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
  
  void _showCopiedMessage(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.check_mark_circled, color: CupertinoColors.activeGreen),
            SizedBox(width: 8),
            Text('Promo code copied to clipboard!'),
          ],
        ),
      ),
    );
    
    // Auto-dismiss after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
  }
} 