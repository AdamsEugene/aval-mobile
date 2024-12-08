import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/auth/social_login_buttons.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart'; // Add this import

class SocialLoginDrawer extends StatelessWidget {
  final bool? insideDrawer;

  const SocialLoginDrawer({super.key, this.insideDrawer});

  static void show(BuildContext context) {
    BaseDrawer.show(
      context: context,
      height: 340,
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Save',
        // textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: () => (),
      ),
      child: const SocialLoginButtons(insideDrawer: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const BaseDrawer(
      height: 340,
      child: SocialLoginButtons(insideDrawer: true),
    );
  }
}
