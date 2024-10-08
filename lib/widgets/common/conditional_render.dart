import 'package:flutter/material.dart';

class ConditionalRender extends StatelessWidget {
  final bool condition;
  final Widget child;

  const ConditionalRender({
    super.key,
    required this.condition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return child;
    } else {
      // Return an empty sized box which takes no space
      return const SizedBox.shrink();
    }
  }
}
