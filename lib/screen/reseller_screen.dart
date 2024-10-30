import 'package:flutter/cupertino.dart';

class ResellerScreen extends StatelessWidget {
  const ResellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Reseller'),
      ),
      child: Center(
        child: Text('Reseller Screen'),
      ),
    );
  }
}
