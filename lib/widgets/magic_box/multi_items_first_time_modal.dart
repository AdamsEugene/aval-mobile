import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiItemsFirstTimeMagicBoxModal {
  static const String _seenKey = 'has_seen_magic_box_intro2';

  // Reset seen status for testing purposes
  static Future<void> resetSeenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, false);
  }

  // Show the modal only on first time
  static Future<void> showFirstTime(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenIntro = prefs.getBool(_seenKey) ?? false;

    if (!hasSeenIntro) {
      showModal(context);
      await prefs.setBool(_seenKey, true);
    }
  }

  // Show the modal regardless of seen status
  static void showModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: GestureDetector(
              // This ensures taps inside the modal don't close it
              onTap: () {},
              child: const _FirstTimeModalContent(),
            ),
          ),
        );
      },
    );
  }
}

class _FirstTimeModalContent extends StatefulWidget {
  const _FirstTimeModalContent();

  @override
  State<_FirstTimeModalContent> createState() => _FirstTimeModalContentState();
}

class _FirstTimeModalContentState extends State<_FirstTimeModalContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _sparkleController;
  final List<_SparkleData> _sparkles = [];

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    // Generate random sparkle positions
    final random = Random();
    for (int i = 0; i < 20; i++) {
      _sparkles.add(
        _SparkleData(
          position: Offset(
            random.nextDouble() * 300,
            random.nextDouble() * 500,
          ),
          size: 2 + random.nextDouble() * 6,
          delay: random.nextDouble(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main content container
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 16,
                  spreadRadius: 4,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top gradient area with magic box icon
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6A11CB),
                          Color(0xFF2575FC),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildBoxIcon(),
                        const SizedBox(height: 20),
                        const Text(
                          'Introducing Multi-Item Magic Boxes!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content area
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Feature highlights
                        _buildFeatureRow(
                          icon: CupertinoIcons.cube_box_fill,
                          title: 'Multiple Items',
                          description:
                              'Now each box can contain up to 7 surprise items!',
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureRow(
                          icon: CupertinoIcons.money_dollar_circle_fill,
                          title: 'Greater Value',
                          description:
                              'Get more value for your money with our bundled boxes',
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureRow(
                          icon: CupertinoIcons.star_fill,
                          title: 'Exclusive Items',
                          description:
                              'Special items only available in our Magic boxes',
                        ),
                        const SizedBox(height: 24),

                        // Call to action
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amber[200]!),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Opening Offer: 20% OFF',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Use code MagicBOX at checkout',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.amber[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                color: const Color(0xFF6A11CB),
                                borderRadius: BorderRadius.circular(12),
                                child: const Text(
                                  'Explore Boxes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text(
                            'Not now',
                            style: TextStyle(
                              color: Color(0xFF2575FC),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Animated sparkles
          ..._buildSparkles(),

          // Close button
          Positioned(
            top: -16,
            right: -16,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.xmark,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              CupertinoIcons.gift_fill,
              size: 50,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '4+',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF6A11CB).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF6A11CB),
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
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSparkles() {
    return _sparkles.map((sparkle) {
      return AnimatedBuilder(
        animation: _sparkleController,
        builder: (context, child) {
          final value =
              (((_sparkleController.value + sparkle.delay) % 1.0) * 2.0)
                  .clamp(0.0, 1.0);
          return Positioned(
            top: sparkle.position.dy,
            left: sparkle.position.dx,
            child: Opacity(
              opacity: value < 0.5 ? value * 2 : (1.0 - value) * 2,
              child: Container(
                width: sparkle.size,
                height: sparkle.size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      blurRadius: sparkle.size,
                      spreadRadius: sparkle.size / 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }
}

class _SparkleData {
  final Offset position;
  final double size;
  final double delay;

  _SparkleData({
    required this.position,
    required this.size,
    required this.delay,
  });
}
