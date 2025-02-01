// lib/widgets/shared/header_delegate.dart
import 'package:flutter/cupertino.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget? profileImage; // Changed from profileWidget to profileImage
  final bool showProfile;
  final bool showBackButton;
  final String? title;
  final VoidCallback? onBackPressed;
  final double? fontSize;
  final double? extent;
  final double? imageSize;

  HeaderDelegate(
      {this.profileImage, // For custom profile image
      this.showProfile = true,
      this.showBackButton = false,
      this.title,
      this.onBackPressed,
      this.fontSize = 32,
      this.extent = 200,
      this.imageSize = 48});

  @override
  double get minExtent => extent ?? 200;
  @override
  double get maxExtent => extent ?? 200;

  Widget _buildProfileContent() {
    return Row(
      children: [
        SizedBox(
          width: imageSize,
          height: imageSize,
          child: profileImage ??
              Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.person,
                    color: Color(0xFF05001E),
                    size: 24,
                  ),
                ),
              ),
        ),
        const SizedBox(width: 16),
        const Text(
          'David',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleContent() {
    return Center(
      child: Text(
        title ?? '',
        style: TextStyle(
          color: CupertinoColors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background with curve
        CustomPaint(
          painter: SimpleCurvedPainter(),
          child: Container(),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SafeArea(
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers the row content
              children: [
                if (showBackButton) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 8),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed:
                          onBackPressed ?? () => Navigator.of(context).pop(),
                      child: const Icon(
                        CupertinoIcons.back,
                        color: CupertinoColors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: Center(
                    child: showProfile
                        ? _buildProfileContent()
                        : _buildTitleContent(),
                  ),
                ),
                if (showBackButton) const SizedBox(width: 76),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class SimpleCurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF05001E)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from top left
    path.lineTo(0, 0);

    // Draw to top right
    path.lineTo(size.width, 0);

    // Draw to bottom right
    path.lineTo(size.width, size.height - 40);

    // Draw the curve
    path.quadraticBezierTo(
      size.width / 2, // control point x
      size.height + 38, // control point y
      0, // end point x
      size.height - 40, // end point y
    );

    // Close the path
    path.close();

    // Draw the golden accent line
    final accentPaint = Paint()
      ..color = CupertinoColors.activeOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    final accentPath = Path();
    accentPath.moveTo(0, size.height - 36);
    accentPath.quadraticBezierTo(
      size.width / 2, // control point x
      size.height + 12, // control point y
      size.width, // end point x
      size.height - 36, // end point y
    );

    canvas.drawPath(accentPath, accentPaint);
    // Draw the navy background
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
