// lib/main.dart
import 'package:e_commerce_app/screen/auth/login_screen.dart';
import 'package:e_commerce_app/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoApp() : _buildMaterialApp();
  }

  Widget _buildCupertinoApp() {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFEEEFF1),
        barBackgroundColor: Color(0xFFEEEFF1),
      ),
      home: _buildSplashHandler(),
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFEEEFF1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEEEFF1),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF05001E),
          primary: const Color(0xFF05001E),
          secondary: const Color(0xFFFDC202),
        ),
        useMaterial3: true,
      ),
      home: _buildSplashHandler(),
    );
  }

  Widget _buildSplashHandler() {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

