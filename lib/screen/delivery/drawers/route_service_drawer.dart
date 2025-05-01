import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/delivery/drawers/schedule_pickup_drawer.dart';

class RouteServiceDrawer extends StatefulWidget {
  const RouteServiceDrawer({super.key});

  @override
  State<RouteServiceDrawer> createState() => _RouteServiceDrawerState();
}

class _RouteServiceDrawerState extends State<RouteServiceDrawer> {
  // Selected route
  String _selectedRoute = 'Downtown - Suburbs';
  
  // Available pickup days
  final List<String> _availableDays = [
    'Monday',
    'Wednesday', 
    'Friday'
  ];

  // Selected pickup day
  String _selectedDay = 'Monday';
  
  // Selected time window
  String _selectedTimeWindow = 'Morning (8 AM - 12 PM)';

  // Available time windows
  final List<String> _timeWindows = [
    'Morning (8 AM - 12 PM)',
    'Afternoon (1 PM - 5 PM)',
  ];
  
  void _showRoutePicker() {
    final List<String> routes = [
      'Downtown - Suburbs',
      'North - South Route',
      'East - West Express',
      'Central Business District',
      'Airport - Downtown'
    ];
    
    final int initialItem = routes.indexOf(_selectedRoute);
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: initialItem >= 0 ? initialItem : 0),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedRoute = routes[index];
                  });
                },
                children: routes.map((route) => Center(child: Text(route))).toList(),
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showDayPicker() {
    final int initialItem = _availableDays.indexOf(_selectedDay);
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: initialItem >= 0 ? initialItem : 0),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedDay = _availableDays[index];
                  });
                },
                children: _availableDays.map((day) => Center(child: Text(day))).toList(),
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showTimeWindowPicker() {
    final int initialItem = _timeWindows.indexOf(_selectedTimeWindow);
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: initialItem >= 0 ? initialItem : 0),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedTimeWindow = _timeWindows[index];
                  });
                },
                children: _timeWindows.map((time) => Center(child: Text(time))).toList(),
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      child: SafeArea(
        child: Column(
          children: [
            // Custom header with gradient
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2196F3),  // Blue color for route service theme
                    Color(0xFF0D47A1),  // Darker blue
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2196F3).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            CupertinoIcons.back,
                            color: CupertinoColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.map_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Route Service',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Affordable delivery along predefined routes',
                    style: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          
            // Description section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF2196F3).withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How Route Service Works',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Our couriers travel along fixed routes on scheduled days. Your package will be picked up and delivered along these routes for a significantly lower price than direct delivery. Perfect for non-urgent shipments where you can save up to 60% on shipping costs.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service features
                    const Text(
                      'Service Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem(
                      icon: CupertinoIcons.money_dollar_circle_fill,
                      title: 'Cost Effective',
                      description: 'Save up to 60% compared to standard delivery options',
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      color: CupertinoColors.systemGrey5,
                    ),
                    _buildFeatureItem(
                      icon: CupertinoIcons.map_pin_ellipse,
                      title: 'Fixed Routes',
                      description: 'Established paths throughout the city with multiple pickup/dropoff points',
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      color: CupertinoColors.systemGrey5,
                    ),
                    _buildFeatureItem(
                      icon: CupertinoIcons.calendar,
                      title: 'Scheduled Days',
                      description: 'Service runs on specific days of the week (Monday, Wednesday, Friday)',
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      color: CupertinoColors.systemGrey5,
                    ),
                    _buildFeatureItem(
                      icon: CupertinoIcons.clock_fill,
                      title: 'Longer Delivery Times',
                      description: '1-3 day delivery window depending on route and pickup time',
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Route selection
                    const Text(
                      'Select Your Route',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    GestureDetector(
                      onTap: _showRoutePicker,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2196F3).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.map_pin_ellipse,
                                    color: Color(0xFF2196F3),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Delivery Route',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _selectedRoute,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              color: CupertinoColors.systemGrey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Schedule selection
                    Row(
                      children: [
                        // Day selection
                        Expanded(
                          child: GestureDetector(
                            onTap: _showDayPicker,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Pickup Day',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedDay,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.calendar,
                                        color: Color(0xFF2196F3),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                        
                        // Time window selection
                        Expanded(
                          child: GestureDetector(
                            onTap: _showTimeWindowPicker,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Time Window',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _selectedTimeWindow,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.clock,
                                        color: Color(0xFF2196F3),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Pricing
                    const Text(
                      'Pricing',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F8FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF2196F3).withOpacity(0.3),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Base Fee',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              Text(
                                '\$5.99',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Per Stop Fee',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              Text(
                                '\$0.50',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Average Total',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$7.49 - \$9.99',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Action button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.systemGrey5,
                    width: 1,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF0D47A1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2196F3).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                    // Show schedule pickup drawer
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const SchedulePickupDrawer(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cube_box,
                        color: CupertinoColors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Continue with Route Service',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2196F3),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 