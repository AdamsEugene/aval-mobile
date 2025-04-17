import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class PrivacyPolicyDrawer extends StatelessWidget {
  const PrivacyPolicyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      // title: 'Privacy Policy',
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'This is our privacy policy.\n\n'
          '1. We respect your privacy...\n'
          '2. Your data is protected...\n'
          '3. ...\n\n'
          'For more details, contact support.',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}