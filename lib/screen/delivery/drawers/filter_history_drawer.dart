// lib/screen/delivery/drawers/filter_history_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
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
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.75,
      // title: 'Filter History',
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Reset',
        textColor: CupertinoColors.systemGrey,
        onTap: _resetFilters,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _applyFilters,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF05001E),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF05001E),
      ),
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
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? CupertinoColors.activeOrange
                          : const Color(0xFF05001E),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      CupertinoIcons.checkmark,
                      color: CupertinoColors.activeOrange,
                      size: 20,
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
