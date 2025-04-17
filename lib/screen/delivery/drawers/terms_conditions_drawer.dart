import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class TermsConditionsDrawer extends StatelessWidget {
  const TermsConditionsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      // title: 'Terms & Conditions',
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'Here are the terms and conditions for using this app.\n\n'
          '1. You agree to our terms...\n'
          '2. You agree to our policies...\n'
          '3. ...\n\n'
          'For more details, contact support.',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
