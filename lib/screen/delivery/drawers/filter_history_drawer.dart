// lib/screen/delivery/drawers/filter_history_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterHistoryDrawer extends StatefulWidget {
  const FilterHistoryDrawer({super.key});

  @override
  State<FilterHistoryDrawer> createState() => _FilterHistoryDrawerState();
}

class _FilterHistoryDrawerState extends State<FilterHistoryDrawer> {
  String _selectedStatus = 'All';
  String _selectedDateRange = 'All Time';
  String _selectedSortBy = 'Most Recent';

  final List<String> _statusOptions = [
    'All',
    'Delivered',
    'In Transit',
    'Processing',
    'Cancelled',
  ];

  final List<String> _dateRangeOptions = [
    'All Time',
    'Last 7 Days',
    'Last 30 Days',
    'Last 3 Months',
    'Last 6 Months',
    'Last Year',
  ];

  final List<String> _sortByOptions = [
    'Most Recent',
    'Oldest First',
    'Price: High to Low',
    'Price: Low to High',
  ];

  void _applyFilters() {
    // In a real app, would apply these filters to the list
    Navigator.pop(context);

    // Show confirmation
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Filters Applied'),
        content: Text(
          'Status: $_selectedStatus\n'
          'Date Range: $_selectedDateRange\n'
          'Sort By: $_selectedSortBy',
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

  void _resetFilters() {
    setState(() {
      _selectedStatus = 'All';
      _selectedDateRange = 'All Time';
      _selectedSortBy = 'Most Recent';
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      child: SafeArea(
        child: Column(
          children: [
            // Enhanced gradient header - using green theme for History
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4CAF50),  // Green for history theme
                    Color(0xFF2E7D32),  // Darker green
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button and Reset controls
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
                            size: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _resetFilters,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Header title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.slider_horizontal_3,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Filter History',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Description
                  const Text(
                    'Customize how your delivery history is displayed',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            
            // Filter options
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Status'),
                      const SizedBox(height: 12),
                      _buildOptionsList(
                        options: _statusOptions,
                        selectedOption: _selectedStatus,
                        onSelect: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Date Range'),
                      const SizedBox(height: 12),
                      _buildOptionsList(
                        options: _dateRangeOptions,
                        selectedOption: _selectedDateRange,
                        onSelect: (value) {
                          setState(() {
                            _selectedDateRange = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Sort By'),
                      const SizedBox(height: 12),
                      _buildOptionsList(
                        options: _sortByOptions,
                        selectedOption: _selectedSortBy,
                        onSelect: (value) {
                          setState(() {
                            _selectedSortBy = value;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      // Apply Filters Button
                      GestureDetector(
                        onTap: _applyFilters,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF4CAF50),  // Green
                                Color(0xFF2E7D32),  // Darker green
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4CAF50).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.checkmark_circle,
                                color: CupertinoColors.white,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Apply Filters',
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF05001E),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsList({
    required List<String> options,
    required String selectedOption,
    required Function(String) onSelect,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CupertinoColors.systemGrey5,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: options.map((option) {
          final isSelected = option == selectedOption;
          return GestureDetector(
            onTap: () => onSelect(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: option == options.last
                        ? Colors.transparent
                        : CupertinoColors.systemGrey5,
                    width: 1,
                  ),
                ),
                color: isSelected ? const Color(0xFFF1F8E9) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF05001E),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        CupertinoIcons.checkmark,
                        color: CupertinoColors.white,
                        size: 16,
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
