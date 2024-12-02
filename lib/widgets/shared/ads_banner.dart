// lib/widgets/shared/ads_banner.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class AdsBanner extends StatefulWidget {
  const AdsBanner({super.key});

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/images/a.jpg',
    'assets/images/b.jpg',
    'assets/images/c.jpg',
    'assets/images/d.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll functionality
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _autoScroll();
      }
    });
  }

  void _autoScroll() {
    if (!mounted) return;

    final nextPage = (_currentPage + 1) % images.length;
    _pageController
        .animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    )
        .then((_) {
      if (mounted) {
        Future.delayed(const Duration(seconds: 3), _autoScroll);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? (Platform.isIOS ? CupertinoColors.white : Colors.white)
            : (Platform.isIOS
                ? CupertinoColors.white.withOpacity(0.5)
                : Colors.white.withOpacity(0.5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: Platform.isIOS
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: images.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Shimmer loading placeholder
                      Container(
                        color: Platform.isIOS
                            ? CupertinoColors.systemGrey6
                            : Colors.grey[200],
                      ),
                      Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Platform.isIOS
                                ? CupertinoColors.systemGrey6
                                : Colors.grey[200],
                            child: Icon(
                              Platform.isIOS
                                  ? CupertinoIcons.photo
                                  : Icons.image_not_supported_outlined,
                              size: 32,
                              color: Platform.isIOS
                                  ? CupertinoColors.systemGrey
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => _buildPageIndicator(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
