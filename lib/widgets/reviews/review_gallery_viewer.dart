import 'package:flutter/cupertino.dart';

class ReviewGalleryViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ReviewGalleryViewer({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<ReviewGalleryViewer> createState() => _ReviewGalleryViewerState();
}

class _ReviewGalleryViewerState extends State<ReviewGalleryViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF05001E),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFF05001E),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.xmark,
            color: CupertinoColors.white,
          ),
        ),
        middle: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(
            color: CupertinoColors.white,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Center(
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: CupertinoColors.systemGrey6,
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.photo,
                              size: 48,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentIndex
                            ? CupertinoColors.white
                            : CupertinoColors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
