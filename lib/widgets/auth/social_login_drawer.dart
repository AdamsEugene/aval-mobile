// lib/widgets/auth/social_login_drawer.dart
import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/auth/social_login_buttons.dart';

class SocialLoginDrawer extends StatelessWidget {
  final bool? insideDrawer;

  const SocialLoginDrawer({super.key, this.insideDrawer});

  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const SocialLoginDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF050311),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const SocialLoginButtons(insideDrawer: true),
        ],
      ),
    );
  }
}
