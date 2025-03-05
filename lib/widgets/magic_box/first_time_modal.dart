import 'package:e_commerce_app/widgets/common/magic_pattern_painter.dart';
import 'package:e_commerce_app/widgets/common/particle_background_painter.dart';
import 'package:e_commerce_app/widgets/common/shine_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeMagicBoxModal extends StatefulWidget {
  final VoidCallback onDismiss;

  const FirstTimeMagicBoxModal({
    super.key,
    required this.onDismiss,
  });

  /// Shows the first-time modal and handles the shared preferences
  static Future<void> showFirstTime(BuildContext context) async {
    try {
      // Check if the user has seen the intro before
      final prefs = await SharedPreferences.getInstance();
      final hasSeenIntro = prefs.getBool('magic_box_intro_seen') ?? false;

      if (!hasSeenIntro && context.mounted) {
        // Show the modal
        await showModal(context);

        // Mark as seen
        await prefs.setBool('magic_box_intro_seen', true);
      }
    } catch (e) {
      // If there's an error with SharedPreferences, still show the modal
      // but don't try to save the preference
      if (context.mounted) {
        await showModal(context);
      }
      debugPrint('Error with magic box preferences: $e');
    }
  }

  /// Shows the modal without checking preferences
  static Future<void> showModal(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (dialogContext, _, __) {
        // Use dialogContext for proper dismissal
        return FirstTimeMagicBoxModal(
          onDismiss: () {
            Navigator.of(dialogContext, rootNavigator: true).pop();
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  /// Just reset the seen status for testing
  static Future<void> resetSeenStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('magic_box_intro_seen');
    } catch (e) {
      debugPrint('Error resetting magic box seen status: $e');
    }
  }

  @override
  State<FirstTimeMagicBoxModal> createState() => _FirstTimeMagicBoxModalState();
}

class _FirstTimeMagicBoxModalState extends State<FirstTimeMagicBoxModal>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _boxController;
  late Animation<double> _boxRotationAnimation;

  @override
  void initState() {
    super.initState();

    // Setup particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Setup box animation
    _boxController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _boxRotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(
      CurvedAnimation(
        parent: _boxController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _particleController.dispose();
    _boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      // Prevent back button from dismissing the modal
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Particle background
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _particleController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ParticleBackgroundPainter(
                        animation: _particleController.value,
                      ),
                    );
                  },
                ),
              ),

              // Content
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title with glow
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xFFFFC837),
                            Color(0xFFFF8008),
                            Color(0xFFDA4453),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'INTRODUCING',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Magic Box Title with glow
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF8A2387).withOpacity(0.8),
                            const Color(0xFFE94057).withOpacity(0.8),
                            const Color(0xFFF27121).withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE94057).withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Text(
                        'MAGIC BOXES',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Animated Box
                    AnimatedBuilder(
                        animation: _boxController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _boxRotationAnimation.value,
                            child: _buildMagicBox(),
                          );
                        }),

                    const SizedBox(height: 40),

                    // Description
                    Container(
                      width: screenSize.width * 0.8,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Purchase a Magic Box and discover premium products at amazing discounts!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _FeatureItem(
                                icon: CupertinoIcons.star,
                                text: 'Premium Items',
                              ),
                              SizedBox(width: 30),
                              _FeatureItem(
                                icon: CupertinoIcons.money_dollar,
                                text: 'Huge Savings',
                              ),
                              SizedBox(width: 30),
                              _FeatureItem(
                                icon: CupertinoIcons.gift,
                                text: 'Surprises',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Get Started Button
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      color: const Color(0xFFDA4453),
                      borderRadius: BorderRadius.circular(50),
                      onPressed: widget.onDismiss,
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Close button
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.xmark_circle_fill),
                  color: Colors.white.withOpacity(0.7),
                  iconSize: 36,
                  onPressed: widget.onDismiss,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMagicBox() {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        children: [
          // Box
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Color(0xFFF27121),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE94057).withOpacity(0.7),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.gift_fill,
                size: 80,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),

          // Shine effect
          const Positioned.fill(
            child: ShineEffect(
              startColor: Color(0xFF8A2387),
              endColor: Color(0xFFF27121),
            ),
          ),

          // Question mark pattern
          Positioned.fill(
            child: CustomPaint(
              painter: MagicPatternPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

// Feature item for the description
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.amber,
          size: 28,
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
