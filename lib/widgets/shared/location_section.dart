// lib/widgets/shared/location_section.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Aval',
          style: Platform.isIOS
              ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
              : Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
        ),
        const SizedBox(width: 2),
        Icon(
          Platform.isIOS ? CupertinoIcons.location_solid : Icons.location_on,
          color: const Color(0xFFF08D00),
          size: 24,
        ),
        const SizedBox(width: 2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 80),
          child: Text(
            'Deliver to Kumasi',
            style: Platform.isIOS
                ? CupertinoTheme.of(context)
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(fontSize: 12)
                : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
