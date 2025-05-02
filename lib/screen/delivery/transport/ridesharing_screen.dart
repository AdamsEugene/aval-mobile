import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RidesharingScreen extends StatefulWidget {
  const RidesharingScreen({super.key});

  @override
  State<RidesharingScreen> createState() => _RidesharingScreenState();
}

class _RidesharingScreenState extends State<RidesharingScreen> {
  final _tabController = CupertinoTabController(initialIndex: 0);
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  void switchToMyRidesTab() {
    setState(() {
      _tabController.index = 2;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Ridesharing'),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
      ),
      child: SafeArea(
        child: CupertinoTabScaffold(
          controller: _tabController,
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.car_fill),
                label: 'Offer Ride',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_2_fill),
                label: 'Find Ride',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book_fill),
                label: 'My Rides',
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return const OfferRideTab();
              case 1:
                return const FindRideTab();
              case 2:
                return const MyRidesTab();
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class OfferRideTab extends StatefulWidget {
  const OfferRideTab({super.key});

  @override
  State<OfferRideTab> createState() => _OfferRideTabState();
}

class _OfferRideTabState extends State<OfferRideTab> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _seatsController = TextEditingController(text: '1');
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isRideRecurring = false;
  bool _allowsPackages = false;
  
  final List<String> _recurringOptions = [
    'Daily', 'Weekdays', 'Weekly', 'Custom'
  ];
  String _selectedRecurringOption = 'Daily';
  
  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _seatsController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }
  
  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime.now(),
                maximumDate: DateTime.now().add(const Duration(days: 30)),
                onDateTimeChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                    _dateController.text = '${date.day}/${date.month}/${date.year}';
                  });
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Confirm'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime(
                  2022, 1, 1, _selectedTime.hour, _selectedTime.minute,
                ),
                onDateTimeChanged: (time) {
                  setState(() {
                    _selectedTime = TimeOfDay.fromDateTime(time);
                    _timeController.text = '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}';
                  });
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Confirm'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
  
  void _offerRide() {
    // Validate input fields
    if (_fromController.text.isEmpty ||
        _toController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _seatsController.text.isEmpty ||
        _priceController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Missing Information'),
          content: const Text('Please fill in all required fields.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }
    
    // Show success message
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Ride Offered'),
        content: const Text(
          'Your ride has been posted. You will be notified when someone books it.'
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              // Navigate directly to the my rides page using the parent widget
              final parent = context.findAncestorWidgetOfExactType<RidesharingScreen>();
              if (parent != null) {
                final state = context.findAncestorStateOfType<_RidesharingScreenState>();
                if (state != null) {
                  state.switchToMyRidesTab();
                }
              }
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? placeholder,
    VoidCallback? onTap,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CupertinoColors.systemGrey4),
            ),
            readOnly: readOnly,
            keyboardType: keyboardType,
            prefix: prefix,
          ),
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver verification status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.activeGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.checkmark_shield_fill,
                    color: CupertinoColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verified Driver',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.activeGreen,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'You can offer rides with your verified profile',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Route section
          const Text(
            'Route Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _fromController,
            label: 'From',
            placeholder: 'Starting location',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                CupertinoIcons.location_solid,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _toController,
            label: 'To',
            placeholder: 'Destination',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                CupertinoIcons.location,
                color: CupertinoColors.destructiveRed,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Schedule section
          const Text(
            'Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _dateController,
            label: 'Date',
            placeholder: 'Select date',
            readOnly: true,
            onTap: _showDatePicker,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                CupertinoIcons.calendar,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _timeController,
            label: 'Time',
            placeholder: 'Select time',
            readOnly: true,
            onTap: _showTimePicker,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                CupertinoIcons.clock,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CupertinoSwitch(
                value: _isRideRecurring,
                onChanged: (value) {
                  setState(() {
                    _isRideRecurring = value;
                  });
                },
              ),
              const SizedBox(width: 12),
              const Text(
                'Recurring Ride',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (_isRideRecurring) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedRecurringOption = _recurringOptions[index];
                  });
                },
                children: _recurringOptions.map((option) => Center(
                  child: Text(option),
                )).toList(),
              ),
            ),
          ],
          const SizedBox(height: 24),
          
          // Ride details section
          const Text(
            'Ride Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _seatsController,
            label: 'Available Seats',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _priceController,
            label: 'Price per Seat (GH₵)',
            placeholder: 'Enter price (0 for free)',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CupertinoSwitch(
                value: _allowsPackages,
                onChanged: (value) {
                  setState(() {
                    _allowsPackages = value;
                  });
                },
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Allow package delivery without passengers',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _notesController,
            label: 'Additional Notes',
            placeholder: 'Any extra information for passengers',
          ),
          const SizedBox(height: 32),
          
          // Submit button
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(vertical: 14),
              onPressed: _offerRide,
              child: const Text(
                'Offer Ride',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class FindRideTab extends StatelessWidget {
  const FindRideTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample ride offers
    final rides = [
      RideOffer(
        driver: 'David K.',
        from: 'Accra Mall',
        to: 'Tema Community 25',
        date: 'Today',
        time: '14:30',
        price: 25.0,
        availableSeats: 2,
        rating: 4.8,
        allowsPackages: true,
      ),
      RideOffer(
        driver: 'Sarah M.',
        from: 'University of Ghana',
        to: 'Madina Market',
        date: 'Today',
        time: '17:00',
        price: 15.0,
        availableSeats: 3,
        rating: 4.6,
        allowsPackages: false,
      ),
      RideOffer(
        driver: 'Michael P.',
        from: 'Osu',
        to: 'Airport City',
        date: 'Tomorrow',
        time: '08:00',
        price: 20.0,
        availableSeats: 1,
        rating: 4.7,
        allowsPackages: true,
      ),
      RideOffer(
        driver: 'Emma T.',
        from: 'East Legon',
        to: 'Achimota',
        date: 'Tomorrow',
        time: '10:15',
        price: 0.0, // Free ride
        availableSeats: 2,
        rating: 4.9,
        allowsPackages: true,
      ),
    ];

    return Column(
      children: [
        // Search field
        Padding(
          padding: const EdgeInsets.all(16),
          child: CupertinoTextField(
            prefix: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(CupertinoIcons.search),
            ),
            placeholder: 'Search for rides by location',
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        
        // Filters row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterChip(label: 'Today', isSelected: true),
              _buildFilterChip(label: 'Tomorrow'),
              _buildFilterChip(label: 'Next 7 days'),
              _buildFilterChip(label: 'Free rides'),
              _buildFilterChip(label: 'Package allowed'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Ride listings
        Expanded(
          child: ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              return _buildRideCard(context, rides[index]);
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildFilterChip({required String label, bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected 
            ? CupertinoColors.activeBlue 
            : CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected 
              ? CupertinoColors.white 
              : CupertinoColors.label,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
  
  Widget _buildRideCard(BuildContext context, RideOffer ride) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Driver info and price
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.activeBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.person_fill,
                    color: CupertinoColors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ride.driver,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.star_fill,
                            color: CupertinoColors.systemYellow,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${ride.rating} • ${ride.availableSeats} seat${ride.availableSeats > 1 ? 's' : ''} available',
                            style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ride.price > 0 
                        ? CupertinoColors.activeGreen.withOpacity(0.1)
                        : CupertinoColors.systemGrey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    ride.price > 0 
                        ? 'GH₵ ${ride.price.toStringAsFixed(0)}'
                        : 'Free',
                    style: TextStyle(
                      color: ride.price > 0 
                          ? CupertinoColors.activeGreen
                          : CupertinoColors.systemGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Route info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Column(
                  children: [
                    const Icon(
                      CupertinoIcons.location_solid,
                      color: CupertinoColors.activeBlue,
                      size: 16,
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: CupertinoColors.systemGrey,
                    ),
                    const Icon(
                      CupertinoIcons.location,
                      color: CupertinoColors.destructiveRed,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ride.from,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ride.to,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ride.date,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      ride.time,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (ride.allowsPackages)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemIndigo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          CupertinoIcons.cube_box,
                          color: CupertinoColors.systemIndigo,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Accepts packages',
                          style: TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemIndigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Contact'),
                  onPressed: () {},
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Book',
                      style: TextStyle(
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  onPressed: () => _showBookingDialog(context, ride),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showBookingDialog(BuildContext context, RideOffer ride) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Book Ride'),
        content: Column(
          children: [
            const SizedBox(height: 8),
            Text('From: ${ride.from}'),
            Text('To: ${ride.to}'),
            Text('Date: ${ride.date} at ${ride.time}'),
            const SizedBox(height: 8),
            Text('Price: ${ride.price > 0 ? "GH₵ ${ride.price.toStringAsFixed(0)}" : "Free"}'),
            const SizedBox(height: 16),
            const Text('How many seats would you like to book?'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                ride.availableSeats,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showBookingConfirmation(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
  
  void _showBookingConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Booking Confirmed'),
        content: const Text(
          'Your ride has been booked! You can contact the driver to coordinate the pickup.'
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class MyRidesTab extends StatelessWidget {
  const MyRidesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoSegmentedControl<int>(
                children: const {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Offered'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Booked'),
                  ),
                },
                onValueChanged: (value) {},
                groupValue: 0,
              ),
            ),
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.car_detailed,
                      size: 80,
                      color: CupertinoColors.systemGrey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Rides Yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your offered and booked rides will appear here',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      onPressed: () {},
                      child: const Text('Offer a Ride'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideOffer {
  final String driver;
  final String from;
  final String to;
  final String date;
  final String time;
  final double price;
  final int availableSeats;
  final double rating;
  final bool allowsPackages;
  
  RideOffer({
    required this.driver,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.availableSeats,
    required this.rating,
    required this.allowsPackages,
  });
} 