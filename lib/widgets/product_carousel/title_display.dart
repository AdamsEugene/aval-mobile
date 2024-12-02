// lib/widgets/product_carousel/title_display.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class TitleDisplay extends StatelessWidget {
  final String title;

  const TitleDisplay({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1939),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(8),
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
        title,
        style: TextStyle(
          color: Platform.isIOS ? CupertinoColors.white : Colors.white,
          fontSize: Platform.isIOS ? 14 : 16,
        ),
      ),
    );
  }
}
