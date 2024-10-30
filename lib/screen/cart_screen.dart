import 'package:flutter/cupertino.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cart'),
      ),
      child: Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}
