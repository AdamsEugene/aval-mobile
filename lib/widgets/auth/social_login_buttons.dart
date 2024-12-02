// lib/widgets/auth/social_login_buttons.dart
import 'package:flutter/cupertino.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Stack(
            children: [
              // Icon on the left
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(child: icon),
                ),
              ),
              // Centered text
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              'Continue With',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 14,
              ),
            ),
          ),
        ),
        SocialLoginButton(
          text: 'Google',
          icon: Image.asset('assets/icons/google.png'),
          onPressed: () {
            // Handle Google login
          },
        ),
        SocialLoginButton(
          text: 'Facebook',
          icon: Image.asset('assets/icons/facebook.png'),
          onPressed: () {
            // Handle Facebook login
          },
        ),
        SocialLoginButton(
          text: 'X',
          icon: Image.asset('assets/icons/x.png'),
          onPressed: () {
            // Handle X login
          },
        ),
      ],
    );
  }
}
