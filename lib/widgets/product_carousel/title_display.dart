import 'package:flutter/cupertino.dart';

class TitleDisplay extends StatelessWidget {
  final String title;

  const TitleDisplay({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1939),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
