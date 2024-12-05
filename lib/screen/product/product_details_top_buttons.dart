// lib/screens/product/product_details_top_buttons.dart
import 'package:flutter/cupertino.dart';

class ProductDetailsTopButtons extends StatefulWidget {
  final ScrollController scrollController;

  const ProductDetailsTopButtons({
    super.key,
    required this.scrollController,
  });

  @override
  State<ProductDetailsTopButtons> createState() =>
      _ProductDetailsTopButtonsState();
}

class _ProductDetailsTopButtonsState extends State<ProductDetailsTopButtons> {
  double _opacity = 1.0;

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
    final double offset = widget.scrollController.offset;
    final double opacity = 1.0 - (offset / 200).clamp(0.0, 1.0);

    if (opacity != _opacity) {
      setState(() => _opacity = opacity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 150),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    CupertinoIcons.back,
                    color: Color(0xFF05001E),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
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
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle favorite
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        CupertinoIcons.heart,
                        color: Color(0xFF05001E),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
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
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle share
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        CupertinoIcons.share,
                        color: Color(0xFF05001E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
