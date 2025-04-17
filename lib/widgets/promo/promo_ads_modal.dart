import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PromoAdsModal extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String buttonText;
  final String promoCode;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onDismiss;
  final DateTime? expiryDate;
  final double discount;
  final bool isNewCustomerOnly;

  const PromoAdsModal({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.buttonText = 'Shop Now',
    this.promoCode = '',
    this.onButtonPressed,
    this.onDismiss,
    this.expiryDate,
    this.discount = 0.0,
    this.isNewCustomerOnly = false,
  });

  /// Shows the promotional ads modal
  static void show(
    BuildContext context, {
    required String title,
    required String description,
    required String imageUrl,
    String buttonText = 'Shop Now',
    String promoCode = '',
    VoidCallback? onButtonPressed,
    VoidCallback? onDismiss,
    DateTime? expiryDate,
    double discount = 0.0,
    bool isNewCustomerOnly = false,
  }) {
    showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      barrierDismissible: true,
      builder: (context) => PromoAdsModal(
        title: title,
        description: description,
        imageUrl: imageUrl,
        buttonText: buttonText,
        promoCode: promoCode,
        onButtonPressed: onButtonPressed,
        onDismiss: onDismiss,
        expiryDate: expiryDate,
        discount: discount,
        isNewCustomerOnly: isNewCustomerOnly,
      ),
    );
  }

  @override
  State<PromoAdsModal> createState() => _PromoAdsModalState();
}

class _PromoAdsModalState extends State<PromoAdsModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isCodeCopied = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getRemainingDays() {
    if (widget.expiryDate == null) return '';

    final now = DateTime.now();
    final difference = widget.expiryDate!.difference(now);
    final days = difference.inDays;

    if (days <= 0) return 'Expires today!';
    if (days == 1) return 'Expires tomorrow!';
    return 'Expires in $days days';
  }

  void _copyPromoCode() {
    // In a real app, you would use Clipboard.setData() here
    setState(() {
      _isCodeCopied = true;
    });

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCodeCopied = false;
        });
      }
    });
  }

  void _handleDismiss() {
    Navigator.of(context).pop();
    if (widget.onDismiss != null) {
      widget.onDismiss!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPromoCode = widget.promoCode.isNotEmpty;
    final String formattedDiscount =
        widget.discount > 0 ? '${widget.discount.toStringAsFixed(0)}% OFF' : '';

    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Close button at the top right
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, top: 8),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        onPressed: _handleDismiss,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: CupertinoColors.systemGrey5,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.clear,
                              size: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Image
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient overlay for better text readability if needed
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.5),
                              ],
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),

                        // Discount badge if applicable
                        if (formattedDiscount.isNotEmpty)
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                formattedDiscount,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                        // New customer badge if applicable
                        if (widget.isNewCustomerOnly)
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'New Customers',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.label,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.secondaryLabel,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Promo code section if available
                        if (hasPromoCode) ...[
                          Row(
                            children: [
                              const Text(
                                'Promo Code:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: CupertinoColors.secondaryLabel,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey6,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: CupertinoColors.systemGrey4,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.promoCode,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        minSize: 0,
                                        onPressed: _copyPromoCode,
                                        child: Icon(
                                          _isCodeCopied
                                              ? CupertinoIcons
                                                  .checkmark_circle_fill
                                              : CupertinoIcons.doc_on_doc,
                                          color: _isCodeCopied
                                              ? CupertinoColors.activeGreen
                                              : CupertinoColors.activeBlue,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Expiry date if available
                        if (widget.expiryDate != null) ...[
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.time,
                                size: 14,
                                color: CupertinoColors.systemRed,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _getRemainingDays(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: CupertinoColors.systemRed,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Call to action button
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            color: const Color(0xFF007AFF),
                            borderRadius: BorderRadius.circular(12),
                            child: Text(
                              widget.buttonText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (widget.onButtonPressed != null) {
                                widget.onButtonPressed!();
                              }
                            },
                          ),
                        ),

                        // Maybe later / No thanks button
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: _handleDismiss,
                            child: const Text(
                              'No thanks',
                              style: TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.secondaryLabel,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
