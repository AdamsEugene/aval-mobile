// lib/screens/auth/login_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:e_commerce_app/widgets/auth/custom_text_field.dart';
import 'package:e_commerce_app/screen/auth/login_button.dart';
import 'package:e_commerce_app/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (Platform.isIOS) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    }
  }

  Widget _buildBottomSection() {
    final textButton = Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Text(
              'Create one.',
              style: TextStyle(
                color: Color(0xFFFDC202),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            child: const Text(
              'Create one.',
              style: TextStyle(
                color: Color(0xFFFDC202),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No account? ',
          style: TextStyle(
            color: Color(0xFF05001E),
            fontSize: 14,
          ),
        ),
        textButton,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Platform.isIOS
        ? CupertinoPageScaffold(
            backgroundColor: Colors.white,
            child: _buildContent(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: _buildContent(),
          );

    return scaffold;
  }

  Widget _buildContent() {
    return CustomScrollView(
      physics: Platform.isIOS
          ? const BouncingScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HeaderDelegate(
            showProfile: false,
            fontSize: 64,
            extent: 300,
            title: 'Aval',
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                CustomTextField(
                  label: 'Email:',
                  controller: _emailController,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'PASSWORD:',
                  controller: _passwordController,
                  isPassword: true,
                  obscurePassword: _obscurePassword,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Platform.isIOS
                    ? CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text(
                          'Forgotten your password?',
                          style: TextStyle(
                            color: Color(0xFF05001E),
                            fontSize: 14,
                          ),
                        ),
                      )
                    : TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Forgotten your password?',
                          style: TextStyle(
                            color: Color(0xFF05001E),
                            fontSize: 14,
                          ),
                        ),
                      ),
                LoginButton(onPressed: _handleLogin),
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
