import 'package:flutter/cupertino.dart';

import 'package:e_commerce_app/widgets/shared/header_delegate.dart';
import 'package:e_commerce_app/screen/auth/login_screen.dart';
import 'package:e_commerce_app/widgets/auth/social_login_buttons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSigningUp = false;
  bool _agreedToTerms = false;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Start animations after a short delay to allow screen transition
    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    String? placeholder,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF05001E).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  color: CupertinoColors.systemGrey,
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: CupertinoTextField.borderless(
                  controller: controller,
                  obscureText: isPassword && (label == 'PASSWORD' ? _obscurePassword : _obscureConfirmPassword),
                  placeholder: placeholder,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  placeholderStyle: const TextStyle(
                    color: CupertinoColors.systemGrey3,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (isPassword)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      if (label == 'PASSWORD') {
                        _obscurePassword = !_obscurePassword;
                      } else {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      }
                    });
                  },
                  child: Icon(
                    (label == 'PASSWORD' ? _obscurePassword : _obscureConfirmPassword)
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    color: CupertinoColors.activeOrange,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    return GestureDetector(
      onTap: _isSigningUp || !_agreedToTerms
          ? null 
          : () async {
              setState(() {
                _isSigningUp = true;
              });

              // Simulate signup delay for animation
              await Future.delayed(const Duration(milliseconds: 1500));

              if (mounted) {
                Navigator.of(context).pop();
              }
            },
      child: Opacity(
        opacity: _agreedToTerms ? 1.0 : 0.6,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF05001E),
                CupertinoColors.activeOrange,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.activeOrange.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: _isSigningUp
                ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                : const Text(
                    'Create Account',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeInAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: child,
              ),
            ),
          );
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: HeaderDelegate(
                showProfile: false,
                showBackButton: true,
                fontSize: 64,
                extent: 250,
                title: 'Aval',
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Sign up to start shopping',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(
                      label: 'NAME',
                      controller: _nameController,
                      placeholder: 'Enter your full name',
                      prefixIcon: CupertinoIcons.person,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'EMAIL',
                      controller: _emailController,
                      placeholder: 'Enter your email',
                      prefixIcon: CupertinoIcons.mail,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'PASSWORD',
                      controller: _passwordController,
                      isPassword: true,
                      placeholder: 'Create a password',
                      prefixIcon: CupertinoIcons.lock,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'CONFIRM PASSWORD',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      placeholder: 'Confirm your password',
                      prefixIcon: CupertinoIcons.lock_fill,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              _agreedToTerms = !_agreedToTerms;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _agreedToTerms 
                                    ? CupertinoColors.activeOrange
                                    : CupertinoColors.systemGrey,
                                width: 2,
                              ),
                              color: _agreedToTerms 
                                  ? CupertinoColors.activeOrange
                                  : CupertinoColors.white,
                            ),
                            child: _agreedToTerms
                                ? const Icon(
                                    CupertinoIcons.check_mark,
                                    size: 16,
                                    color: CupertinoColors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: CupertinoColors.activeOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: CupertinoColors.activeOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildSignupButton(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 14,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: CupertinoColors.activeOrange,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SocialLoginButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 