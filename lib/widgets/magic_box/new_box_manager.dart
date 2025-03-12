import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class that manages the availability and timing of new magic boxes
class NewBoxManager {
  // Singleton instance
  static final NewBoxManager _instance = NewBoxManager._internal();
  factory NewBoxManager() => _instance;
  NewBoxManager._internal();

  // Keys for storing data
  static const String _lastBoxTimeKey = 'last_new_box_time3';
  static const String _seenBoxIdKey = 'seen_box_id3';

  // Stream controller for box availability
  final StreamController<NewBoxData?> _boxStreamController =
      StreamController<NewBoxData?>.broadcast();

  // Current box data
  NewBoxData? _currentBox;
  Timer? _boxTimer;

  // Stream for listeners to subscribe to
  Stream<NewBoxData?> get boxStream => _boxStreamController.stream;

  // Get current box data
  NewBoxData? get currentBox => _currentBox;

  // Initialize and start checking for new boxes
  Future<void> initialize() async {
    await _checkForNewBox();

    // Set up periodic checker
    _boxTimer = Timer.periodic(
      const Duration(minutes: 1), // Check every minute
      (_) => _checkForNewBox(),
    );
  }

  // Dispose resources
  void dispose() {
    _boxTimer?.cancel();
    _boxStreamController.close();
  }

  // Mark current box as seen/dismissed
  Future<void> markCurrentBoxSeen() async {
    if (_currentBox == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_seenBoxIdKey, _currentBox!.id);

    _currentBox = null;
    _boxStreamController.add(null);
  }

  // Check if a new box should be available
  Future<void> _checkForNewBox() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastBoxTimeStr = prefs.getString(_lastBoxTimeKey);
      final lastSeenBoxId = prefs.getString(_seenBoxIdKey) ?? '';

      final now = DateTime.now();
      DateTime lastBoxTime;

      if (lastBoxTimeStr != null) {
        lastBoxTime = DateTime.parse(lastBoxTimeStr);
      } else {
        // First time using the app, set initial time
        lastBoxTime = now.subtract(const Duration(hours: 24));
        await prefs.setString(_lastBoxTimeKey, lastBoxTime.toIso8601String());
      }

      // Calculate hours since last box
      final hoursSinceLastBox = now.difference(lastBoxTime).inHours;

      // Debug to force new box for testing
      // const bool forceNewBox = true;
      const bool forceNewBox = false;

      // Check if enough time has passed (8-24 hours)
      if (forceNewBox || hoursSinceLastBox >= 8) {
        // Generate a new box
        final newBox = _generateNewBox();

        // Check if this is the same box the user has already seen
        if (newBox.id != lastSeenBoxId) {
          _currentBox = newBox;
          _boxStreamController.add(newBox);

          // Update last box time
          await prefs.setString(_lastBoxTimeKey, now.toIso8601String());
        }
      } else if (_currentBox != null) {
        // Make sure current box is still being broadcast
        _boxStreamController.add(_currentBox);
      }
    } catch (e) {
      debugPrint('Error checking for new box: $e');
    }
  }

  // Generate a new magic box with random properties
  NewBoxData _generateNewBox() {
    final random = Random();
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    // Random box theme from a predefined list
    final boxThemes = [
      const _BoxTheme(
        title: 'Seasonal Magic',
        startColor: Color(0xFF6A11CB),
        endColor: Color(0xFF2575FC),
      ),
      const _BoxTheme(
        title: 'Premium Surprise',
        startColor: Color(0xFFFF8008),
        endColor: Color(0xFFFFC837),
      ),
      const _BoxTheme(
        title: 'Luxury Collection',
        startColor: Color(0xFFBC4E9C),
        endColor: Color(0xFFF80759),
      ),
      const _BoxTheme(
        title: 'Limited Edition',
        startColor: Color(0xFF396AFC),
        endColor: Color(0xFF2948FF),
      ),
      const _BoxTheme(
        title: 'Ultra Magic',
        startColor: Color(0xFF8E2DE2),
        endColor: Color(0xFF4A00E0),
      ),
    ];

    final boxTheme = boxThemes[random.nextInt(boxThemes.length)];

    // Random item count (1-5)
    final itemCount = 1 + random.nextInt(5);

    // Price based on item count
    final price = (9.99 + (itemCount - 1) * 5.0).roundToDouble();

    return NewBoxData(
      id: id,
      title: boxTheme.title,
      price: price,
      startColor: boxTheme.startColor,
      endColor: boxTheme.endColor,
      itemCount: itemCount,
      availableUntil:
          DateTime.now().add(Duration(hours: 8 + random.nextInt(16))),
    );
  }

  // Force a new box to appear (for testing or admin purposes)
  Future<void> forceNewBox() async {
    final newBox = _generateNewBox();
    _currentBox = newBox;
    _boxStreamController.add(newBox);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastBoxTimeKey, DateTime.now().toIso8601String());
  }
}

// Class to hold new box data
class NewBoxData {
  final String id;
  final String title;
  final double price;
  final Color startColor;
  final Color endColor;
  final int itemCount;
  final DateTime availableUntil;

  const NewBoxData({
    required this.id,
    required this.title,
    required this.price,
    required this.startColor,
    required this.endColor,
    required this.itemCount,
    required this.availableUntil,
  });

  // Time remaining until box expires
  Duration get timeRemaining => availableUntil.difference(DateTime.now());

  // Formatted time remaining string
  String get formattedTimeRemaining {
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;

    if (hours > 0) {
      return '$hours hr ${minutes > 0 ? '$minutes min' : ''}';
    } else {
      return '$minutes min';
    }
  }
}

// Helper class for box themes
class _BoxTheme {
  final String title;
  final Color startColor;
  final Color endColor;

  const _BoxTheme({
    required this.title,
    required this.startColor,
    required this.endColor,
  });
}
