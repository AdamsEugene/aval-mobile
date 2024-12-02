// lib/widgets/shared/main_search_bar.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io' show Platform;

class MainSearchBar extends StatelessWidget {
  const MainSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SearchBarDelegate(),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight = 0.0;
  final double maxHeight = 55.0;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - minExtent);
    final currentHeight = math.max(minHeight, maxHeight - shrinkOffset);

    return SizedBox(
      height: currentHeight,
      child: Container(
        color: const Color(0xFFEEEFF1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: math.max(4.0, 8.0 - (progress * 4.0)),
          ),
          child: CustomizedSearchTextField(shrinkProgress: progress),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

class CustomizedSearchTextField extends StatelessWidget {
  final double shrinkProgress;

  const CustomizedSearchTextField({super.key, required this.shrinkProgress});

  Widget _buildPlatformTextField() {
    if (Platform.isIOS) {
      return CupertinoTextField(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        placeholder: 'Search...',
        prefix: _buildPrefix(),
        suffix: _buildSuffix(),
        suffixMode: OverlayVisibilityMode.always,
        clipBehavior: Clip.hardEdge,
      );
    }

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: _buildPrefix(),
        suffixIcon: _buildSuffix(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget? _buildPrefix() {
    if (shrinkProgress >= 0.48) return null;

    return Padding(
      padding: EdgeInsets.only(
        left: math.max(6.0, 12.0 - (shrinkProgress * 6.0)),
      ),
      child: Icon(
        Platform.isIOS
            ? CupertinoIcons.camera_viewfinder
            : Icons.qr_code_scanner,
        color: Platform.isIOS ? CupertinoColors.black : Colors.black54,
        size: math.max(15.0, 20.0 - (shrinkProgress * 10.0)),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (shrinkProgress >= 0.48) return null;

    final iconSize = math.max(10.0, 20.0 - (shrinkProgress * 10.0));

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD5D6D7),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconButton(
              Platform.isIOS ? CupertinoIcons.camera : Icons.camera_alt,
              iconSize,
            ),
            _buildIconButton(
              Platform.isIOS ? CupertinoIcons.mic : Icons.mic,
              iconSize,
            ),
            _buildIconButton(
              Platform.isIOS ? CupertinoIcons.search : Icons.search,
              iconSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, double size) {
    final buttonSize = math.max(20.0, 40.0 - (shrinkProgress * 20.0));

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Center(
        child: IconButton(
          icon: Icon(
            icon,
            color: Platform.isIOS ? CupertinoColors.white : Colors.white,
            size: size,
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: Platform.isIOS ? null : buttonSize / 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPlatformTextField();
  }
}
