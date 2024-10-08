import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  @override
  Widget build(BuildContext context) {
    final iconSize = math.max(10.0, 20.0 - (shrinkProgress * 10.0));

    return CupertinoTextField(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      placeholder: 'Search...',
      prefix: shrinkProgress < 0.48
          ? Padding(
              padding: EdgeInsets.only(
                left: math.max(6.0, 12.0 - (shrinkProgress * 6.0)),
              ),
              child: Icon(
                CupertinoIcons.camera_viewfinder,
                color: CupertinoColors.black,
                size: math.max(15.0, 20.0 - (shrinkProgress * 10.0)),
              ),
            )
          : null,
      suffix: shrinkProgress < 0.48
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                // width: containerWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFFD5D6D7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIconButton(CupertinoIcons.camera, iconSize),
                    _buildIconButton(CupertinoIcons.mic, iconSize),
                    _buildIconButton(CupertinoIcons.search, iconSize),
                  ],
                ),
              ),
            )
          : null,
      suffixMode: OverlayVisibilityMode.always,
      clipBehavior: Clip.hardEdge,
    );
  }

  Widget _buildIconButton(IconData icon, double size) {
    return SizedBox(
      width: math.max(20.0, 40.0 - (shrinkProgress * 20.0)),
      height: math.max(20.0, 40.0 - (shrinkProgress * 20.0)),
      child: Center(
        child: IconButton(
          icon: Icon(icon, color: CupertinoColors.white, size: size),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
