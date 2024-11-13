// lib/screens/auth/login_screen.dart
import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: const TextStyle(
        //     fontSize: 16,
        //     color: Color(0xFF05001E),
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF05001E),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: CupertinoTextField.borderless(
                  controller: controller,
                  obscureText: isPassword && _obscurePassword,
                  placeholder: label,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                  ),
                ),
              ),
              if (isPassword)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    color: const Color(0xFFFDC202),
                  ),
                )
              else
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Icon(
                    CupertinoIcons.mail,
                    color: Color(0xFFFDC202),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF05001E),
          borderRadius: BorderRadius.circular(25),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false, // This removes all previous routes
            );
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                  _buildTextField(
                    label: 'Email:',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    label: 'PASSWORD:',
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: const Text(
                      'Forgotten your password?',
                      style: TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  _buildLoginButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'No account? ',
                        style: TextStyle(
                          color: Color(0xFF05001E),
                          fontSize: 14,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // Handle create account
                        },
                        child: const Text(
                          'Create one.',
                          style: TextStyle(
                            color: Color(0xFFFDC202),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
