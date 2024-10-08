import 'package:e_commerce_app/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/screen/home_screen.dart';

void main() => runApp(const PageScaffoldApp());

class PageScaffoldApp extends StatelessWidget {
  const PageScaffoldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFEEEFF1),
        barBackgroundColor: Color(0xFFEEEFF1),
      ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
