import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdsService {
  static const String _lastShownKey = 'last_shown_promo_ad';
  static const String _viewCountKey = 'app_view_count';
  static const String _dismissedAdsKey = 'dismissed_ads';

  // Singleton pattern
  static final AdsService _instance = AdsService._internal();
  factory AdsService() => _instance;
  AdsService._internal();

  final List<PromoAdData> _availableAds = [
    PromoAdData(
      id: 'spring_sale_2025',
      title: 'Spring Collection Sale!',
      description: 'Enjoy exclusive discounts on our new spring collection. '
          'Use the promo code below to get 30% off on your next purchase. '
          'Limited time offer!',
      imageUrl: 'https://images.unsplash.com/photo-1593642634402-b0eb5e2eebc9?q=80&w=1000',
      buttonText: 'Shop the Collection',
      promoCode: 'SPRING30',
      discount: 30.0,
      expiryDate: DateTime.now().add(const Duration(days: 7)),
      isNewCustomerOnly: false,
      priority: 10,
    ),
    PromoAdData(
      id: 'new_user_welcome',
      title: 'Welcome Gift! 🎁',
      description:
          'As a new customer, you\'re eligible for a special 20% discount '
          'on your first order. Explore our collection and find something you\'ll love!',
      imageUrl: 'https://images.unsplash.com/photo-1513201099705-a9746e1e201f?q=80&w=1000',
      buttonText: 'Start Shopping',
      promoCode: 'WELCOME20',
      discount: 20.0,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      isNewCustomerOnly: true,
      priority: 20,
    ),
    PromoAdData(
      id: 'premium_magic_box',
      title: 'Premium Magic Box',
      description: 'Experience the thrill of our Premium Magic Box! '
          'Packed with 5 exclusive items worth over \$100, available for just \$39.99. '
          'Limited stock available!',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000',
      buttonText: 'Get Your Box',
      discount: 60.0,
      expiryDate: DateTime.now().add(const Duration(days: 3)),
      priority: 15,
    ),
    PromoAdData(
      id: 'free_shipping',
      title: 'Free Shipping Weekend!',
      description:
          'This weekend only: Free shipping on all orders, no minimum purchase required. '
          'Shop now and save on delivery costs!',
      imageUrl: 'https://images.unsplash.com/photo-1607962837359-5e7e89f86776?q=80&w=1000',
      buttonText: 'Shop Now',
      promoCode: 'FREESHIP',
      expiryDate: DateTime.now().add(const Duration(days: 2)),
      priority: 5,
    ),
  ];

  /// Check if it's appropriate to show an ad and return the ad data if yes
  Future<PromoAdData?> shouldShowAd(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Increment view count
    final int viewCount = (prefs.getInt(_viewCountKey) ?? 0) + 1;
    await prefs.setInt(_viewCountKey, viewCount);

    // Get last shown timestamp
    final int lastShown = prefs.getInt(_lastShownKey) ?? 0;
    final lastShownTime = DateTime.fromMillisecondsSinceEpoch(lastShown);
    final now = DateTime.now();

    // Get dismissed ads
    final List<String> dismissedAds =
        prefs.getStringList(_dismissedAdsKey) ?? [];

    // Conditions to show an ad:
    // 1. Last ad was shown at least 24 hours ago or this is view #1, #5, #10, etc.
    // 2. There are available ads not dismissed by the user
    if (now.difference(lastShownTime).inHours >= 24 ||
        viewCount == 1 ||
        viewCount % 5 == 0) {
      // Filter out dismissed ads and sort by priority
      final availableAds = _availableAds
          .where((ad) => !dismissedAds.contains(ad.id))
          .toList()
        ..sort((a, b) => b.priority.compareTo(a.priority));

      if (availableAds.isNotEmpty) {
        // Get the highest priority ad
        final adToShow = availableAds.first;

        // Update last shown timestamp
        await prefs.setInt(_lastShownKey, now.millisecondsSinceEpoch);

        return adToShow;
      }
    }

    return null;
  }

  /// Mark an ad as dismissed so it won't show again
  Future<void> markAdDismissed(String adId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dismissedAds =
        prefs.getStringList(_dismissedAdsKey) ?? [];

    if (!dismissedAds.contains(adId)) {
      dismissedAds.add(adId);
      await prefs.setStringList(_dismissedAdsKey, dismissedAds);
    }
  }

  /// Reset ad display data (for testing)
  Future<void> resetAdDisplayData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastShownKey);
    await prefs.remove(_viewCountKey);
  }

  /// Get all available ads for direct access (primarily for debug/testing)
  List<PromoAdData> get availableAds => _availableAds;
}

/// Data model for promotional ads
class PromoAdData {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String buttonText;
  final String promoCode;
  final VoidCallback? onButtonPressed;
  final DateTime? expiryDate;
  final double discount;
  final bool isNewCustomerOnly;
  final int priority; // Higher number = higher priority

  PromoAdData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.buttonText = 'Shop Now',
    this.promoCode = '',
    this.onButtonPressed,
    this.expiryDate,
    this.discount = 0.0,
    this.isNewCustomerOnly = false,
    this.priority = 0,
  });
}
