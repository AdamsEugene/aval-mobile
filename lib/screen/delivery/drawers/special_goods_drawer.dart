import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialGoodsDrawer extends StatefulWidget {
  const SpecialGoodsDrawer({super.key});

  @override
  State<SpecialGoodsDrawer> createState() => _SpecialGoodsDrawerState();
}

class _SpecialGoodsDrawerState extends State<SpecialGoodsDrawer> {
  // Form values
  final TextEditingController _itemDescriptionController = TextEditingController();
  final TextEditingController _specialInstructionsController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTimeSlot = '9:00 AM - 11:00 AM';
  String _selectedItemCategory = 'Medical';
  bool _requiresTemperatureControl = false;
  String _selectedTemperatureRange = '2-8°C (Standard)';
  bool _requiresInsurance = true;
  String _insuranceValue = '\$1000';
  bool _requiresSignatureOnDelivery = true;
  bool _requiresTrackingUpdates = true;
  
  // Time slots for medical deliveries (shorter windows than regular delivery)
  final List<String> _timeSlots = [
    '9:00 AM - 11:00 AM',
    '11:00 AM - 1:00 PM',
    '1:00 PM - 3:00 PM',
    '3:00 PM - 5:00 PM',
    '5:00 PM - 7:00 PM',
  ];
  
  // Item categories
  final List<String> _itemCategories = [
    'Medical',
    'Fragile Valuables',
    'Sensitive Electronics',
    'Hazardous Materials',
    'Medication',
    'Laboratory Samples',
  ];
  
  // Temperature ranges
  final List<String> _temperatureRanges = [
    '2-8°C (Standard)',
    '15-25°C (Controlled Room)',
    '-20°C (Frozen)',
    '-80°C (Ultra-Low)',
    'Other (Specify in Notes)',
  ];
  
  // Insurance values
  final List<String> _insuranceValues = [
    '\$1000',
    '\$2500',
    '\$5000',
    '\$10000',
    '\$25000',
  ];
  
  @override
  void dispose() {
    _itemDescriptionController.dispose();
    _specialInstructionsController.dispose();
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
                maximumDate: DateTime.now().add(const Duration(days: 14)),
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
  
  void _showCategoryPicker() {
    final int initialItem = _itemCategories.indexOf(_selectedItemCategory);
    
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
                    _selectedItemCategory = _itemCategories[index];
                  });
                },
                children: _itemCategories.map((category) => Center(child: Text(category))).toList(),
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
  
  void _showTemperatureRangePicker() {
    final int initialItem = _temperatureRanges.indexOf(_selectedTemperatureRange);
    
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
                    _selectedTemperatureRange = _temperatureRanges[index];
                  });
                },
                children: _temperatureRanges.map((range) => Center(child: Text(range))).toList(),
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
  
  void _showInsuranceValuePicker() {
    final int initialItem = _insuranceValues.indexOf(_insuranceValue);
    
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
                    _insuranceValue = _insuranceValues[index];
                  });
                },
                children: _insuranceValues.map((value) => Center(child: Text(value))).toList(),
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
  
  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Special Delivery Scheduled'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5722).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Color(0xFFFF5722),
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your special goods delivery has been scheduled!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: $_selectedItemCategory',
              textAlign: TextAlign.center,
            ),
            Text(
              'Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Time: $_selectedTimeSlot',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tracking #: SG29873',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF5722),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You will receive tracking updates and handling instructions via SMS and email.',
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
                    Color(0xFFFF5722),  // Orange color for special goods theme
                    Color(0xFFE64A19),  // Darker orange
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5722).withOpacity(0.3),
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
                          CupertinoIcons.bandage_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Special Goods Delivery',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Safe handling for medical, valuable, and delicate items',
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
                        color: const Color(0xFFFEEDE8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFF5722).withOpacity(0.3),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Specialized Handling',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFF5722),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Our Special Goods service provides specialized handling for medical supplies, valuable items, and delicate packages that require extra care. Our trained personnel follow strict protocols to ensure safe delivery.',
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
                    
                    // Item Category
                    const Text(
                      'Item Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    GestureDetector(
                      onTap: _showCategoryPicker,
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
                                Icon(
                                  _getCategoryIcon(),
                                  color: const Color(0xFFFF5722),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _selectedItemCategory,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              color: CupertinoColors.systemGrey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Item Description
                    const Text(
                      'Item Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _itemDescriptionController,
                      padding: const EdgeInsets.all(12),
                      placeholder: 'Describe your item in detail',
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
                                        color: Color(0xFFFF5722),
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
                                        color: Color(0xFFFF5722),
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
                    
                    // Special handling options
                    const Text(
                      'Special Handling Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Temperature control
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.thermometer,
                                    color: Color(0xFFFF5722),
                                    size: 22,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Temperature Control',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoSwitch(
                                value: _requiresTemperatureControl,
                                activeColor: const Color(0xFFFF5722),
                                onChanged: (value) {
                                  setState(() {
                                    _requiresTemperatureControl = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (_requiresTemperatureControl) ...[
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: _showTemperatureRangePicker,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEEDE8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _selectedTemperatureRange,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
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
                          ],
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.shield_fill,
                                    color: Color(0xFFFF5722),
                                    size: 22,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Extra Insurance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoSwitch(
                                value: _requiresInsurance,
                                activeColor: const Color(0xFFFF5722),
                                onChanged: (value) {
                                  setState(() {
                                    _requiresInsurance = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (_requiresInsurance) ...[
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: _showInsuranceValuePicker,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEEDE8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Coverage: $_insuranceValue',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
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
                          ],
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Signature on delivery
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
                                CupertinoIcons.pencil,
                                color: Color(0xFFFF5722),
                                size: 22,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Signature Required',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          CupertinoSwitch(
                            value: _requiresSignatureOnDelivery,
                            activeColor: const Color(0xFFFF5722),
                            onChanged: (value) {
                              setState(() {
                                _requiresSignatureOnDelivery = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Tracking updates
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
                                CupertinoIcons.location_fill,
                                color: Color(0xFFFF5722),
                                size: 22,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Real-time Tracking',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          CupertinoSwitch(
                            value: _requiresTrackingUpdates,
                            activeColor: const Color(0xFFFF5722),
                            onChanged: (value) {
                              setState(() {
                                _requiresTrackingUpdates = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Special Instructions
                    const Text(
                      'Special Instructions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _specialInstructionsController,
                      padding: const EdgeInsets.all(12),
                      placeholder: 'Add any special handling instructions',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          CupertinoIcons.info,
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
                    
                    // Pricing
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEEDE8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFF5722).withOpacity(0.3),
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
                                '\$79.99',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF5722),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Final price may vary based on item category, weight, and additional services.',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          if (_requiresTemperatureControl || _requiresInsurance) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF5722).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Service Breakdown:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (_requiresTemperatureControl)
                                    const Text(
                                      '• Temperature-controlled transport: +\$30.00',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  if (_requiresInsurance)
                                    Text(
                                      '• Insurance (up to $_insuranceValue): +\$15.00',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                ],
                              ),
                            ),
                          ],
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
                      Color(0xFFFF5722),
                      Color(0xFFE64A19),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5722).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.transparent,
                  onPressed: () {
                    _showSuccessDialog();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.bandage_fill,
                        color: CupertinoColors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Schedule Special Delivery',
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
  
  // Helper method to return appropriate icon based on category
  IconData _getCategoryIcon() {
    switch (_selectedItemCategory) {
      case 'Medical':
        return CupertinoIcons.bandage_fill;
      case 'Fragile Valuables':
        return CupertinoIcons.star_fill;
      case 'Sensitive Electronics':
        return CupertinoIcons.device_laptop;
      case 'Hazardous Materials':
        return CupertinoIcons.exclamationmark_triangle_fill;
      case 'Medication':
        return CupertinoIcons.bandage;
      case 'Laboratory Samples':
        return CupertinoIcons.drop_fill;
      default:
        return CupertinoIcons.cube_box_fill;
    }
  }
} 