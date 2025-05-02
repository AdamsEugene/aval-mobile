import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class BeaconLocationScreen extends StatefulWidget {
  const BeaconLocationScreen({super.key});

  @override
  State<BeaconLocationScreen> createState() => _BeaconLocationScreenState();
}

class _BeaconLocationScreenState extends State<BeaconLocationScreen> with TickerProviderStateMixin {
  final TextEditingController _locationNameController = TextEditingController();
  bool _isDetectingLocation = false;
  bool _foundLocation = false;
  bool _isConfirming = false;
  bool _locationConfirmed = false;
  bool _isSubmitting = false;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  late AnimationController _confirmationController;
  Timer? _detectTimer;
  Timer? _confirmTimer;
  
  String _detectedLocationName = '';
  final List<String> _nearbyPeople = [
    'John D. (500m away)',
    'Sarah M. (320m away)', 
    'David K. (650m away)',
    'Emma T. (470m away)',
    'Michael P. (710m away)',
  ];
  
  int _confirmations = 0;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize pulse animation for beacon effect
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Initialize confirmation animation
    _confirmationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _locationNameController.dispose();
    _pulseController.dispose();
    _confirmationController.dispose();
    _detectTimer?.cancel();
    _confirmTimer?.cancel();
    super.dispose();
  }
  
  void _startLocationDetection() {
    setState(() {
      _isDetectingLocation = true;
      _foundLocation = false;
      _isConfirming = false;
      _locationConfirmed = false;
    });
    
    // Simulate location detection
    _detectTimer = Timer(const Duration(seconds: 3), () {
      // Generate a list of possible location names
      final locations = [
        'Nima Market',
        'Teshie Beach Road',
        'Kasoa New Town',
        'Madina Zongo Junction',
        'Achimota Forest Edge',
        'Abeka Lapaz',
        'Spintex Industrial Area'
      ];
      
      // Randomly select a location
      final random = math.Random();
      final selectedLocation = locations[random.nextInt(locations.length)];
      
      setState(() {
        _isDetectingLocation = false;
        _foundLocation = true;
        _detectedLocationName = selectedLocation;
        _locationNameController.text = selectedLocation;
      });
    });
  }
  
  void _confirmLocation() {
    setState(() {
      _isConfirming = true;
    });
    
    // Simulate confirmation process from nearby users
    _confirmTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_confirmations < 3) {
        setState(() {
          _confirmations++;
        });
      } else {
        timer.cancel();
        setState(() {
          _isConfirming = false;
          _locationConfirmed = true;
        });
      }
    });
  }
  
  void _submitLocationToSystem() {
    setState(() {
      _isSubmitting = true;
    });
    
    // Simulate API call to add location to system
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
      });
      
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Location Added'),
          content: Text(
            'The location "${_locationNameController.text}" has been added to our system and can now be used for deliveries.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(_locationNameController.text);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
  
  Widget _buildDetectingUI() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(3, (index) {
              return AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 150 * _pulseAnimation.value * (1 + index * 0.3),
                    height: 150 * _pulseAnimation.value * (1 + index * 0.3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CupertinoColors.activeBlue.withOpacity(0.3 / (index + 1)),
                    ),
                  );
                },
              );
            }),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.activeBlue,
              ),
              child: const Icon(
                CupertinoIcons.location_fill,
                color: CupertinoColors.white,
                size: 40,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const CupertinoActivityIndicator(radius: 16),
        const SizedBox(height: 20),
        const Text(
          'Detecting Location',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Using Beacon technology to identify your current location',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
  
  Widget _buildFoundLocationUI() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.activeGreen,
          ),
          child: const Icon(
            CupertinoIcons.location_fill,
            color: CupertinoColors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Location Detected',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We detected your location as: $_detectedLocationName',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Confirm or Edit the Location Name',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CupertinoTextField(
            controller: _locationNameController,
            placeholder: 'Location name',
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CupertinoColors.systemGrey4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        CupertinoButton(
          color: CupertinoColors.activeBlue,
          onPressed: _confirmLocation,
          child: const Text('Confirm This Location'),
        ),
      ],
    );
  }
  
  Widget _buildConfirmingUI() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemGrey,
              ),
              child: const Icon(
                CupertinoIcons.person_2_fill,
                color: CupertinoColors.white,
                size: 40,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.activeOrange,
                ),
                child: const Icon(
                  CupertinoIcons.location_fill,
                  color: CupertinoColors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Confirming with Nearby Users',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Verifying "$_detectedLocationName" with people nearby',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Nearby Users:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_nearbyPeople.length, (index) {
          final hasConfirmed = index < _confirmations;
          return Container(
            margin: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CupertinoColors.systemGrey4,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hasConfirmed 
                        ? CupertinoColors.activeGreen 
                        : CupertinoColors.systemGrey,
                  ),
                  child: Icon(
                    hasConfirmed 
                        ? CupertinoIcons.checkmark 
                        : CupertinoIcons.person_fill,
                    color: CupertinoColors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _nearbyPeople[index],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                if (hasConfirmed)
                  const Text(
                    'Confirmed',
                    style: TextStyle(
                      color: CupertinoColors.activeGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
        Text(
          '$_confirmations/3 confirmations received',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  Widget _buildConfirmedUI() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.activeGreen,
          ),
          child: const Icon(
            CupertinoIcons.checkmark_circle_fill,
            color: CupertinoColors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Location Confirmed',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '"${_locationNameController.text}" has been verified by nearby users',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'This location can now be added to our system for future deliveries.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(height: 30),
        CupertinoButton(
          color: CupertinoColors.activeGreen,
          onPressed: _submitLocationToSystem,
          child: _isSubmitting
              ? const CupertinoActivityIndicator(color: CupertinoColors.white)
              : const Text('Add Location to System'),
        ),
      ],
    );
  }
  
  Widget _buildInitialUI() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.systemGrey.withOpacity(0.3),
          ),
          child: const Icon(
            CupertinoIcons.location_fill,
            color: CupertinoColors.systemGrey,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Unknown Location?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Use our Beacon technology to detect and register your current location if it\'s not in our system.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        const SizedBox(height: 40),
        const Icon(
          CupertinoIcons.arrow_down,
          size: 30,
          color: CupertinoColors.systemGrey,
        ),
        const SizedBox(height: 40),
        CupertinoButton(
          color: CupertinoColors.activeBlue,
          onPressed: _startLocationDetection,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.antenna_radiowaves_left_right),
              SizedBox(width: 8),
              Text('Detect My Location'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Beacon Technology'),
                content: const Text(
                  'Our innovative Beacon Technology allows the system to detect your location even in unmapped areas. '
                  'It works by triangulating your position using nearby mobile signals and GPS. '
                  'The name of your location is then verified by nearby users to ensure accuracy.'
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text(
            'How does this work?',
            style: TextStyle(
              color: CupertinoColors.activeBlue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildContentArea() {
    if (_isDetectingLocation) {
      return _buildDetectingUI();
    } else if (_foundLocation && !_isConfirming && !_locationConfirmed) {
      return _buildFoundLocationUI();
    } else if (_isConfirming) {
      return _buildConfirmingUI();
    } else if (_locationConfirmed) {
      return _buildConfirmedUI();
    } else {
      return _buildInitialUI();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Beacon Location'),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: _buildContentArea(),
        ),
      ),
    );
  }
} 