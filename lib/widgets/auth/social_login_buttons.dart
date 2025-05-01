// lib/widgets/auth/social_login_buttons.dart
import 'package:e_commerce_app/screen/home_screen.dart';
// Firebase imports are commented out for now until proper configuration
// import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/services/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final bool? insideDrawer;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.insideDrawer,
    this.backgroundColor,
    this.textColor,
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
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor ?? CupertinoColors.white,
          border: Border.all(color: const Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF05001E).withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Stack(
            children: [
              Positioned(
                left: 20,
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
                  "Continue with $text",
                  style: TextStyle(
                    color: textColor ?? const Color(0xFF05001E),
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
  // Commented out until Firebase is properly configured
  // final AuthService _authService = AuthService();

  SocialLoginButtons({
    super.key,
    this.insideDrawer,
  });

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFEEEEEE),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: const Color(0xFF05001E).withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFEEEEEE),
          ),
        ),
      ],
    );
  }

  // Mock implementation for Google Sign In
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      UIHelper.showLoading(context, message: 'Signing in with Google...');
      
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      if (context.mounted) {
        UIHelper.hideLoading(context);
        
        // Show a message about Firebase configuration
        UIHelper.showAlert(
          context: context,
          title: 'Firebase Not Configured',
          message: 'Firebase has not been set up for this app yet. This is a placeholder for Google Sign In functionality.',
          actionText: 'Continue Anyway',
          onAction: () {
            if (insideDrawer == true && context.mounted) {
              Navigator.pop(context); // Close drawer if open
            }
            
            // Navigate to home screen
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            }
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Google sign in error: $e');
      }
      if (context.mounted) {
        UIHelper.hideLoading(context);
        UIHelper.showError(context, 'An unexpected error occurred.');
      }
    }
  }

  // Mock implementation for Facebook Sign In
  Future<void> _handleFacebookSignIn(BuildContext context) async {
    try {
      UIHelper.showLoading(context, message: 'Signing in with Facebook...');
      
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      if (context.mounted) {
        UIHelper.hideLoading(context);
        
        // Show a message about Firebase configuration
        UIHelper.showAlert(
          context: context,
          title: 'Firebase Not Configured',
          message: 'Firebase has not been set up for this app yet. This is a placeholder for Facebook Sign In functionality.',
          actionText: 'Continue Anyway',
          onAction: () {
            if (insideDrawer == true && context.mounted) {
              Navigator.pop(context); // Close drawer if open
            }
            
            // Navigate to home screen
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            }
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Facebook sign in error: $e');
      }
      if (context.mounted) {
        UIHelper.hideLoading(context);
        UIHelper.showError(context, 'An unexpected error occurred.');
      }
    }
  }

  // Mock implementation for Apple Sign In
  Future<void> _handleAppleSignIn(BuildContext context) async {
    try {
      UIHelper.showLoading(context, message: 'Signing in with Apple...');
      
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      if (context.mounted) {
        UIHelper.hideLoading(context);
        
        // Show a message about Firebase configuration
        UIHelper.showAlert(
          context: context,
          title: 'Firebase Not Configured',
          message: 'Firebase has not been set up for this app yet. This is a placeholder for Apple Sign In functionality.',
          actionText: 'Continue Anyway',
          onAction: () {
            if (insideDrawer == true && context.mounted) {
              Navigator.pop(context); // Close drawer if open
            }
            
            // Navigate to home screen
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            }
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Apple sign in error: $e');
      }
      if (context.mounted) {
        UIHelper.hideLoading(context);
        UIHelper.showError(context, 'An unexpected error occurred.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        _buildDivider(),
        const SizedBox(height: 24),
        SocialLoginButton(
          text: 'Google',
          icon: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.white,
            ),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(
                  color: Color(0xFF4285F4),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          insideDrawer: insideDrawer,
          onPressed: () => _handleGoogleSignIn(context),
        ),
        SocialLoginButton(
          text: 'Facebook',
          icon: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.white,
            ),
            child: const Center(
              child: Text(
                'f',
                style: TextStyle(
                  color: Color(0xFF1877F2),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          backgroundColor: const Color(0xFF1877F2),
          textColor: CupertinoColors.white,
          insideDrawer: insideDrawer,
          onPressed: () => _handleFacebookSignIn(context),
        ),
        SocialLoginButton(
          text: 'Apple',
          icon: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.white,
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          backgroundColor: CupertinoColors.black,
          textColor: CupertinoColors.white,
          insideDrawer: insideDrawer,
          onPressed: () => _handleAppleSignIn(context),
        ),
      ],
    );
  }
}
