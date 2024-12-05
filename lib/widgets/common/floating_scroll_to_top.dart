// lib/widgets/common/floating_scroll_to_top.dart

import 'package:flutter/cupertino.dart';

class FloatingScrollToTop extends StatefulWidget {
  final ScrollController scrollController;
  final double? bottom;
  final double? right;
  final double showAfter;

  const FloatingScrollToTop({
    super.key,
    required this.scrollController,
    this.bottom,
    this.right = 16,
    this.showAfter = 200,
  });

  @override
  State<FloatingScrollToTop> createState() => _FloatingScrollToTopState();
}

class _FloatingScrollToTopState extends State<FloatingScrollToTop> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final showButton = widget.scrollController.offset > widget.showAfter;
    if (showButton != _showButton) {
      setState(() => _showButton = showButton);
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showButton) return const SizedBox.shrink();

    return Positioned(
      right: widget.right,
      bottom: widget.bottom ?? (MediaQuery.of(context).padding.bottom + 90),
      child: AnimatedOpacity(
        opacity: _showButton ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _scrollToTop,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.arrow_up,
                color: Color(0xFF05001E),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
