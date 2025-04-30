// lib/widgets/shared/custom_segmented_control.dart
import 'package:flutter/cupertino.dart';

class SegmentItem {
  final String text;
  final IconData? icon;

  const SegmentItem({
    required this.text,
    this.icon,
  });
}

class CustomSegmentedControl<T extends Object> extends StatelessWidget {
  final T groupValue;
  final Map<T, SegmentItem> children;
  final ValueChanged<T?> onValueChanged;
  final Color backgroundColor;
  final Color? thumbColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final double? spacing;

  const CustomSegmentedControl({
    super.key,
    required this.groupValue,
    required this.children,
    required this.onValueChanged,
    this.backgroundColor = const Color(0xFFFFFFFF), // Changed to white
    this.thumbColor = const Color(0xFF05001E),
    this.selectedTextColor = CupertinoColors.white,
    this.unselectedTextColor = const Color(0xFF666666), // Added default color
    this.padding = const EdgeInsets.symmetric(
        horizontal: 16, vertical: 8), // Adjusted padding
    this.iconSize = 16, // Smaller icons
    this.spacing = 6, // Increased spacing
  });

  Map<T, Widget> _wrapChildrenInPadding() {
    return children.map((key, item) {
      final isSelected = groupValue == key;
      final color = isSelected ? selectedTextColor : unselectedTextColor;

      return MapEntry(
        key,
        Padding(
          padding: padding!,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: iconSize,
                  color: color,
                ),
                SizedBox(width: spacing),
              ],
              Text(
                item.text,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
      backgroundColor: backgroundColor,
      thumbColor: thumbColor!,
      groupValue: groupValue,
      onValueChanged: onValueChanged,
      children: _wrapChildrenInPadding(),
    );
  }
}

// Example usage:
/*
enum TimeFilter { today, week, month, year }

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TimeFilter _selectedFilter = TimeFilter.today;

  @override
  Widget build(BuildContext context) {
    return CustomSegmentedControl<TimeFilter>(
      groupValue: _selectedFilter,
      onValueChanged: (TimeFilter? value) {
        if (value != null) {
          setState(() => _selectedFilter = value);
        }
      },
      children: {
        TimeFilter.today: SegmentItem(
          text: 'Today',
          icon: CupertinoIcons.calendar_today,
        ),
        TimeFilter.week: SegmentItem(
          text: 'Week',
          icon: CupertinoIcons.calendar,
        ),
        TimeFilter.month: SegmentItem(
          text: 'Month',
          icon: CupertinoIcons.calendar_badge_plus,
        ),
        TimeFilter.year: SegmentItem(
          text: 'Year',
          icon: CupertinoIcons.calendar_circle,
        ),
      },
    );
  }
}
*/