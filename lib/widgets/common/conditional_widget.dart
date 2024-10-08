import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  final bool? condition;
  final Widget whenTrue;
  final Widget whenFalse;

  const ConditionalWidget({
    super.key,
    this.condition,
    required this.whenTrue,
    required this.whenFalse,
  });

  @override
  Widget build(BuildContext context) {
    return condition ?? false ? whenTrue : whenFalse;
  }
}
