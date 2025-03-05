import 'dart:ui';
import 'dart:math' show sin, pi;
import 'package:e_commerce_app/widgets/common/Magic_pattern_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/magic_box/magic_box_purchase_handler.dart';
import 'package:e_commerce_app/widgets/common/shine_effect.dart';

class NewBoxPreviewModal extends StatefulWidget {
  final String boxTitle;
  final double boxPrice;
  final Color startColor;
  final Color endColor;
  final int itemCount;

  const NewBoxPreviewModal({
    super.key,
    required this.boxTitle,
    required this.boxPrice,
    required this.startColor,
    required this.endColor,
    this.itemCount = 1,
  });

  @override
  State<NewBoxPreviewModal> createState() => _NewBoxPreviewModalState();
}

class _NewBoxPreviewModalState extends State<NewBoxPreviewModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _floatAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Title Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.xmark_circle),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        'New Magic Box Available!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.startColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance for close button
                  ],
                ),
              ),

              // Magic Box Preview
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Animated Box
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value),
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.startColor.withOpacity(
                                        0.3 + _glowAnimation.value * 0.2),
                                    blurRadius: 20 + _glowAnimation.value * 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    widget.startColor,
                                    widget.endColor,
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Magic pattern
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: MagicPatternPainter(
                                          // opacity: 0.15,
                                          ),
                                    ),
                                  ),

                                  // Shine effect
                                  Positioned.fill(
                                    child: ShineEffect(
                                      startColor: widget.startColor,
                                      endColor: widget.endColor,
                                    ),
                                  ),

                                  // Box content
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            // Gift icon
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                CupertinoIcons.gift_fill,
                                                size: 56,
                                                color: Colors.white,
                                              ),
                                            ),

                                            // Item count badge
                                            if (widget.itemCount > 1)
                                              Positioned(
                                                right: -5,
                                                top: -5,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: CupertinoColors
                                                        .activeOrange,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    widget.itemCount.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          widget.boxTitle,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            '\$${widget.boxPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: widget.startColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // "?" symbols for Magic effect (animated)
                                  ..._buildMagicSymbols(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // Box Description
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Unlock Your Magic ${widget.itemCount > 1 ? 'Items' : 'Item'}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.itemCount > 1
                                  ? 'This exclusive box contains ${widget.itemCount} Magic items selected just for you. Each item is a surprise until you open the box!'
                                  : 'This exclusive box contains a Magic item selected just for you. You won\'t know what it is until you open the box!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Features
                            ..._buildFeatures(),

                            const SizedBox(height: 24),

                            // Box value indicator
                            _buildValueIndicator(),

                            const SizedBox(height: 30),

                            // Purchase button
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 14,
                              ),
                              color: widget.startColor,
                              borderRadius: BorderRadius.circular(16),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.shopping_cart, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'PURCHASE & REVEAL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                MagicBoxPurchaseHandler.handlePurchase(
                                  context,
                                  boxTitle: widget.boxTitle,
                                  boxPrice: widget.boxPrice,
                                  startColor: widget.startColor,
                                  endColor: widget.endColor,
                                  itemCount: widget.itemCount,
                                );
                              },
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMagicSymbols() {
    // Generate animated floating question marks
    final symbols = <Widget>[];

    for (int i = 0; i < 6; i++) {
      final posX = 30.0 + (i * 30) % 140;
      final posY = 40.0 + (i * 40) % 120;

      symbols.add(
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final offset = sin((_animationController.value * 2 * pi) + i) * 5;
            return Positioned(
              left: posX + offset,
              top: posY,
              child: Opacity(
                opacity: 0.5 + (_glowAnimation.value * 0.5),
                child: Text(
                  '?',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 20 + (i % 3) * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return symbols;
  }

  List<Widget> _buildFeatures() {
    return [
      _buildFeatureRow(
        icon: CupertinoIcons.gift,
        title: widget.itemCount > 1 ? 'Multiple Items Inside' : 'Surprise Item',
        description: widget.itemCount > 1
            ? 'Contains ${widget.itemCount} unique items'
            : 'One exclusive Magic item',
      ),
      const SizedBox(height: 16),
      _buildFeatureRow(
        icon: CupertinoIcons.sparkles,
        title: 'Limited Availability',
        description: 'Get it before it\'s gone!',
      ),
      const SizedBox(height: 16),
      _buildFeatureRow(
        icon: CupertinoIcons.money_dollar_circle,
        title: 'Guaranteed Value',
        description: 'Worth more than you pay',
      ),
    ];
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.startColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: widget.startColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueIndicator() {
    // Calculate potential value (for display purposes only)
    final minValue = widget.boxPrice;
    final maxValue = widget.boxPrice * (widget.itemCount > 1 ? 2.5 : 2.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CupertinoColors.systemYellow),
      ),
      child: Column(
        children: [
          const Text(
            'Potential Value Range',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.systemYellow,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${minValue.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemYellow,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        CupertinoColors.systemYellow,
                        CupertinoColors.systemOrange,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                '\$${maxValue.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
