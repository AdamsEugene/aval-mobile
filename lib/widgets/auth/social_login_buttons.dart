// lib/widgets/auth/social_login_buttons.dart
import 'package:flutter/cupertino.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final bool? insideDrawer;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.insideDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: insideDrawer == true ? 24 : 0,
        vertical: 8,
      ),
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
  final bool? insideDrawer;

  const SocialLoginButtons({
    super.key,
    this.insideDrawer,
  });

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
          insideDrawer: insideDrawer,
          onPressed: () {
            // Handle Google login
            if (insideDrawer == true) {
              Navigator.pop(context);
            }
          },
        ),
        SocialLoginButton(
          text: 'Facebook',
          icon: Image.asset('assets/icons/facebook.png'),
          insideDrawer: insideDrawer,
          onPressed: () {
            // Handle Facebook login
            if (insideDrawer == true) {
              Navigator.pop(context);
            }
          },
        ),
        SocialLoginButton(
          text: 'X',
          icon: Image.asset('assets/icons/x.png'),
          insideDrawer: insideDrawer,
          onPressed: () {
            // Handle X login
            if (insideDrawer == true) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
