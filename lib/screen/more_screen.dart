import 'package:flutter/cupertino.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('More'),
      ),
      child: Center(
        child: Text('More Screen'),
      ),
    );
  }
}
