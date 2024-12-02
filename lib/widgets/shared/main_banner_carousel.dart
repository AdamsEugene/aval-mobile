// lib/widgets/shared/main_banner_carousel.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class MainBannerCarousel extends StatefulWidget {
  const MainBannerCarousel({super.key});

  @override
  MainBannerCarouselState createState() => MainBannerCarouselState();
}

class MainBannerCarouselState extends State<MainBannerCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<String> bannerImages = [
    'assets/images/b1.png',
    'assets/images/i.jpg',
    'assets/images/g.jpg',
  ];

  final List<String> promoImages = [
    'assets/images/i.jpg',
    'assets/images/g.jpg',
    'assets/images/p1.png',
    'assets/images/p2.png',
    'assets/images/p3.png',
    'assets/images/p4.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final nextPage = (_currentPage + 1) % bannerImages.length;
        _pageController
            .animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            )
            .then((_) => _startAutoScroll());
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildNavigationButton({
    required bool isNext,
    required VoidCallback onPressed,
  }) {
    final icon = isNext
        ? (Platform.isIOS
            ? CupertinoIcons.chevron_right_2
            : Icons.chevron_right)
        : (Platform.isIOS ? CupertinoIcons.chevron_left_2 : Icons.chevron_left);

    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            child: Icon(icon, color: Colors.white),
          )
        : IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: onPressed,
          );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Colors.white
            : Colors.white.withOpacity(0.5),
      ),
    );
  }

  Widget _buildImageWithLoading(String imagePath,
      {double? width, double? height}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color:
              Platform.isIOS ? CupertinoColors.systemGrey6 : Colors.grey[200],
        ),
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Platform.isIOS
                  ? CupertinoColors.systemGrey6
                  : Colors.grey[200],
              child: Icon(
                Platform.isIOS
                    ? CupertinoIcons.photo
                    : Icons.image_not_supported_outlined,
                color:
                    Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 5,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: bannerImages.length,
                physics: Platform.isIOS
                    ? const AlwaysScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: _buildImageWithLoading(bannerImages[index]),
                  );
                },
              ),
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildNavigationButton(
                    isNext: false,
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildNavigationButton(
                    isNext: true,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    bannerImages.length,
                    (index) => _buildPageIndicator(index),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: Platform.isIOS
                ? const AlwaysScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: promoImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: ClipRRect(
                  child: _buildImageWithLoading(
                    promoImages[index],
                    width: 120,
                    height: 70,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
