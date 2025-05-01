import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/delivery/drawers/schedule_pickup_drawer.dart';

class FullVehicleLogisticsDrawer extends StatefulWidget {
  const FullVehicleLogisticsDrawer({super.key});

  @override
  State<FullVehicleLogisticsDrawer> createState() => _FullVehicleLogisticsDrawerState();
}

class _FullVehicleLogisticsDrawerState extends State<FullVehicleLogisticsDrawer> {
  // Selected vehicle type
  String _selectedVehicle = 'Standard Van';
  
  // Selected date
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  
  // Selected time slot
  String _selectedTimeSlot = '9:00 AM - 12:00 PM';
  
  // Hours needed
  double _hoursNeeded = 3;
  
  // Need loading help
  bool _needsLoadingHelp = true;
  
  // Need insurance
  bool _needsInsurance = true;
  
  // Form controllers
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pickupAddressController = TextEditingController();
  
  // Time slots
  final List<String> _timeSlots = [
    '9:00 AM - 12:00 PM',
    '12:00 PM - 3:00 PM',
    '3:00 PM - 6:00 PM',
    '6:00 PM - 9:00 PM',
  ];
  
  @override
  void dispose() {
    _descriptionController.dispose();
    _pickupAddressController.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime.now(),
                maximumDate: DateTime.now().add(const Duration(days: 30)),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
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

  void _showTimePicker() {
    final int initialItem = _timeSlots.indexOf(_selectedTimeSlot);
    
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
                    _selectedTimeSlot = _timeSlots[index];
                  });
                },
                children: _timeSlots.map((timeSlot) => Center(child: Text(timeSlot))).toList(),
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
  
  void _showVehiclePicker() {
    final List<String> vehicles = [
      'Standard Van',
      'Large Van',
      'Box Truck',
      'Moving Truck',
      'Refrigerated Van',
    ];
    
    final int initialItem = vehicles.indexOf(_selectedVehicle);
    
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
                    _selectedVehicle = vehicles[index];
                  });
                },
                children: vehicles.map((vehicle) => Center(child: Text(vehicle))).toList(),
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
                    Color(0xFF9C27B0),  // Purple color for full vehicle theme
                    Color(0xFF6A1B9A),  // Darker purple
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9C27B0).withOpacity(0.3),
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
                          CupertinoIcons.car_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Full Vehicle Logistics',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Request an entire vehicle for your transportation needs',
                    style: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.9),
                      fontSize: 16,
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
                    // Description section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8EFF9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF9C27B0).withOpacity(0.3),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dedicated Vehicle Service',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9C27B0),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Our Full Vehicle Logistics service provides you with a dedicated vehicle and driver for your specific transportation needs. Perfect for moving large items, multiple packages, or when you need complete control over your delivery logistics.',
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Vehicle selection section
                    const Text(
                      'Select Vehicle Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Available vehicles
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildVehicleOption(
                            name: 'Standard Van', 
                            capacity: 'Up to 800kg',
                            icon: CupertinoIcons.cube_box_fill,
                            isSelected: _selectedVehicle == 'Standard Van',
                          ),
                          _buildVehicleOption(
                            name: 'Large Van', 
                            capacity: 'Up to 1,200kg',
                            icon: CupertinoIcons.cube_box_fill,
                            isSelected: _selectedVehicle == 'Large Van',
                          ),
                          _buildVehicleOption(
                            name: 'Box Truck', 
                            capacity: 'Up to 3,500kg',
                            icon: CupertinoIcons.cube_box_fill,
                            isSelected: _selectedVehicle == 'Box Truck',
                          ),
                          _buildVehicleOption(
                            name: 'Moving Truck', 
                            capacity: 'Up to 7,500kg',
                            icon: CupertinoIcons.cube_box_fill,
                            isSelected: _selectedVehicle == 'Moving Truck',
                          ),
                          _buildVehicleOption(
                            name: 'Refrigerated Van', 
                            capacity: 'Temperature controlled',
                            icon: CupertinoIcons.thermometer,
                            isSelected: _selectedVehicle == 'Refrigerated Van',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Pickup details
                    const Text(
                      'Pickup Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Pickup address
                    const Text(
                      'Pickup Address',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _pickupAddressController,
                      padding: const EdgeInsets.all(12),
                      placeholder: 'Enter full address',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          CupertinoIcons.location,
                          color: CupertinoColors.systemGrey,
                          size: 18,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      maxLines: 2,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Cargo description
                    const Text(
                      'Cargo Description',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _descriptionController,
                      padding: const EdgeInsets.all(12),
                      placeholder: 'Describe what you\'re transporting',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          CupertinoIcons.doc_text,
                          color: CupertinoColors.systemGrey,
                          size: 18,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      maxLines: 3,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Date and time
                    Row(
                      children: [
                        // Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pickup Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: _showDatePicker,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.white,
                                    borderRadius: BorderRadius.circular(8),
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
                                      Text(
                                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.calendar,
                                        color: Color(0xFF9C27B0),
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Time
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pickup Time',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: _showTimePicker,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.white,
                                    borderRadius: BorderRadius.circular(8),
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
                                      Text(
                                        _selectedTimeSlot.split(' - ')[0],
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.time,
                                        color: Color(0xFF9C27B0),
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Hours slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hours Needed: ${_hoursNeeded.toInt()} hours',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            value: _hoursNeeded,
                            min: 1,
                            max: 8,
                            divisions: 7,
                            activeColor: const Color(0xFF9C27B0),
                            thumbColor: const Color(0xFF9C27B0),
                            onChanged: (value) {
                              setState(() {
                                _hoursNeeded = value;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '1 hour',
                              style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            const Text(
                              '8 hours',
                              style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Options
                    const Text(
                      'Additional Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Loading help
                    Container(
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
                          const Row(
                            children: [
                              Icon(
                                CupertinoIcons.person_2_fill,
                                color: Color(0xFF9C27B0),
                                size: 22,
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Loading & Unloading Help',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Additional \$25 per hour',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CupertinoSwitch(
                            value: _needsLoadingHelp,
                            activeColor: const Color(0xFF9C27B0),
                            onChanged: (value) {
                              setState(() {
                                _needsLoadingHelp = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Insurance
                    Container(
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
                          const Row(
                            children: [
                              Icon(
                                CupertinoIcons.shield_lefthalf_fill,
                                color: Color(0xFF9C27B0),
                                size: 22,
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cargo Insurance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Up to \$10,000 coverage',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CupertinoSwitch(
                            value: _needsInsurance,
                            activeColor: const Color(0xFF9C27B0),
                            onChanged: (value) {
                              setState(() {
                                _needsInsurance = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Pricing
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8EFF9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF9C27B0).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Estimated Cost',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$199.99',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9C27B0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Final price may vary based on actual hours, distance, and additional services.',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                            ),
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
                      Color(0xFF9C27B0),
                      Color(0xFF6A1B9A),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9C27B0).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.transparent,
                  onPressed: () {
                    // Show confirmation and navigate to pickup
                    _showBookingConfirmation();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.car_detailed,
                        color: CupertinoColors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Book Vehicle',
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
  
  Widget _buildVehicleOption({
    required String name,
    required String capacity,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicle = name;
        });
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9C27B0).withOpacity(0.1) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF9C27B0) : CupertinoColors.systemGrey4,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF9C27B0),
              size: 36,
            ),
            const SizedBox(height: 12),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              capacity,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showBookingConfirmation() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Vehicle Booked'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Color(0xFF9C27B0),
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your vehicle has been scheduled!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Vehicle: $_selectedVehicle',
              textAlign: TextAlign.center,
            ),
            Text(
              'Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Time: ${_selectedTimeSlot.split(' - ')[0]}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Booking #: VH78492',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF9C27B0),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You will receive driver information and tracking details via SMS and email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Done'),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close drawer
            },
          ),
        ],
      ),
    );
  }
} 