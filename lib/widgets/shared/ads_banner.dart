import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:math' as math;

class AdsBanner extends StatefulWidget {
  final Function(int index)? onAdTap;
  
  const AdsBanner({
    super.key,
    this.onAdTap,
  });

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  late AnimationController _indicatorController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _userInteracting = false;

  final List<Map<String, dynamic>> ads = [
    {
      'image': 'assets/images/a.jpg',
      'title': 'Summer Sale',
      'description': 'Up to 50% off on all summer items',
      'color': const Color(0xFFF9A826),
    },
    {
      'image': 'assets/images/b.jpg',
      'title': 'New Collection',
      'description': 'Check out our latest fashion arrivals',
      'color': const Color(0xFF2A93D5),
    },
    {
      'image': 'assets/images/c.jpg',
      'title': 'Limited Offer',
      'description': 'Special discounts for premium members',
      'color': const Color(0xFF37B24D),
    },
    {
      'image': 'assets/images/d.jpg',
      'title': 'Flash Sale',
      'description': '24 hours only - Don\'t miss out!',
      'color': const Color(0xFFE03131),
    },
  ];

  @override
  void initState() {
    super.initState();
    
    // Animation controller for the progress indicator
    _indicatorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Longer duration for better viewing
    )..addListener(() {
      if (_indicatorController.status == AnimationStatus.completed) {
        _indicatorController.reset();
        _goToNextPage();
      }
    });
    
    // Animation controller for scale effects
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    ));
    
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _indicatorController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _indicatorController.forward(from: 0.0);
  }
  
  void _stopAutoScroll() {
    _indicatorController.stop();
    _timer?.cancel();
  }
  
  void _goToNextPage() {
    if (_currentPage < ads.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _handleDragStart() {
    setState(() {
      _userInteracting = true;
    });
    _stopAutoScroll();
    _scaleController.forward();
  }
  
  void _handleDragEnd() {
    setState(() {
      _userInteracting = false;
    });
    _scaleController.reverse();
    _startAutoScroll();
  }
  
  void _handleAdTap(int index) {
    if (widget.onAdTap != null) {
      widget.onAdTap!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          height: 180,
          child: GestureDetector(
            onTapDown: (_) => _handleDragStart(),
            onTapUp: (_) => _handleDragEnd(),
            onTap: () => _handleAdTap(_currentPage),
            onHorizontalDragStart: (_) => _handleDragStart(),
            onHorizontalDragEnd: (_) => _handleDragEnd(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Page view with parallax effect
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                          if (!_userInteracting) {
                            _indicatorController.forward(from: 0.0);
                          }
                        });
                      },
                      itemCount: ads.length,
                      itemBuilder: (context, index) {
                        return ParallaxBannerItem(
                          imageUrl: ads[index]['image'],
                          title: ads[index]['title'],
                          description: ads[index]['description'],
                          color: ads[index]['color'],
                          pageController: _pageController,
                          index: index,
                          onTap: () => _handleAdTap(index),
                        );
                      },
                    ),
                  ),
                  
                  // Custom animated progress indicator
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      children: List.generate(
                        ads.length,
                        (index) => Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5),
                              color: CupertinoColors.white.withOpacity(0.3),
                            ),
                            child: index == _currentPage
                              ? AnimatedBuilder(
                                  animation: _indicatorController,
                                  builder: (context, child) {
                                    return FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: _indicatorController.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(1.5),
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  width: index < _currentPage ? double.infinity : 0,
                                  color: index < _currentPage 
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemBackground.withOpacity(0),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Dots indicator
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        ads.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _currentPage == index ? 18 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentPage == index
                                ? CupertinoColors.white
                                : CupertinoColors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ParallaxBannerItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Color color;
  final PageController pageController;
  final int index;
  final VoidCallback? onTap;

  const ParallaxBannerItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.color,
    required this.pageController,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Parallax image effect
        AnimatedBuilder(
          animation: pageController,
          builder: (context, child) {
            double page = 0.0;
            if (pageController.position.haveDimensions) {
              page = pageController.page ?? 0;
            }
            
            // Calculate parallax effect - make it subtle but noticeable
            final double parallax = (page - index).abs();
            final double parallaxOffset = parallax * 30; // Increased parallax effect
            
            return Transform.translate(
              offset: Offset(parallaxOffset, 0),
              child: child,
            );
          },
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              // Fallback image in case of error
              return Container(
                color: color.withOpacity(0.3),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.photo,
                    color: CupertinoColors.white,
                    size: 50,
                  ),
                ),
              );
            },
          ),
        ),
        
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color.withOpacity(0.8),
                color.withOpacity(0.2),
              ],
            ),
          ),
        ),
        
        // Text content
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: CupertinoColors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: CupertinoColors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Shop Now',
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
