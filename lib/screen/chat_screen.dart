import 'package:flutter/cupertino.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Chat'),
      ),
      child: Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}
