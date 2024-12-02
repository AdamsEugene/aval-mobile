// lib/widgets/shared/header_delegate.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool showProfile;
  final bool showBackButton;
  final String? title;
  final VoidCallback? onBackPressed;
  final double? fontSize;
  final double? extent;

  HeaderDelegate({
    this.showProfile = true,
    this.showBackButton = false,
    this.title,
    this.onBackPressed,
    this.fontSize = 32,
    this.extent = 200,
  });

  @override
  double get minExtent => extent ?? 200;
  @override
  double get maxExtent => extent ?? 200;

  Widget _buildProfileContent() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Platform.isIOS ? CupertinoIcons.person : Icons.person_outline,
              color: const Color(0xFF05001E),
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'David',
          style: TextStyle(
            color: Colors.white,
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
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        child: const Icon(
          CupertinoIcons.back,
          color: Colors.white,
          size: 28,
        ),
      );
    } else {
      return IconButton(
        padding: EdgeInsets.zero,
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        ),
      );
    }
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
        // Back button if needed
        if (showBackButton)
          Positioned(
            top: 24,
            left: 24,
            child: _buildBackButton(context),
          ),
        // Content
        Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: showBackButton ? 64 : 24,
          ),
          child: showProfile ? _buildProfileContent() : _buildTitleContent(),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class SimpleCurvedPainter extends CustomPainter {
  final Color backgroundColor = const Color(0xFF05001E);
  final Color accentColor = const Color(0xFFFDC202);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
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
      ..color = accentColor
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

    // Draw in correct order
    canvas.drawPath(accentPath, accentPaint);
    canvas.drawPath(path, paint);

    // Add Material Design elevation effect if on Android
    if (!Platform.isIOS) {
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawPath(path, shadowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
