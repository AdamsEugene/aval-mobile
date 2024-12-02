// lib/widgets/product_carousel/promo_section.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/common/conditional_widget.dart';
import 'package:e_commerce_app/widgets/product_carousel/timer_display.dart';
import 'package:e_commerce_app/widgets/product_carousel/title_display.dart';

class PromoSection extends StatelessWidget {
  final int secondsRemaining;
  final bool? ourChoice;

  const PromoSection({
    super.key,
    required this.secondsRemaining,
    this.ourChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          width: 151,
          decoration: BoxDecoration(
            color: Platform.isIOS ? CupertinoColors.systemRed : Colors.red,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
            ),
            boxShadow: Platform.isIOS
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Text(
            '-58%',
            style: TextStyle(
              color: Platform.isIOS ? CupertinoColors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Platform.isIOS ? 14 : 16,
            ),
          ),
        ),
        ConditionalWidget(
          condition: ourChoice,
          whenTrue: const TitleDisplay(title: "Aval Choice"),
          whenFalse: TimerDisplay(secondsRemaining: secondsRemaining),
        ),
      ],
    );
  }
}
