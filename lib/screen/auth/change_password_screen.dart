// lib/screens/account/change_password_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  String? _errorMessage;

  Widget _buildPasswordField({
    required String placeholder,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField.borderless(
              controller: controller,
              placeholder: placeholder,
              obscureText: !isVisible,
              style: const TextStyle(
                color: Color(0xFF05001E),
                fontSize: 16,
              ),
              placeholderStyle: TextStyle(
                color: const Color(0xFF05001E).withOpacity(0.4),
                fontSize: 16,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onToggleVisibility,
            child: Icon(
              isVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
              color: const Color(0xFF05001E).withOpacity(0.4),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  bool _validatePasswords() {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() => _errorMessage = 'All fields are required');
      return false;
    }

    if (_newPasswordController.text.length < 8) {
      setState(() =>
          _errorMessage = 'New password must be at least 8 characters long');
      return false;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() => _errorMessage = 'New passwords do not match');
      return false;
    }

    setState(() => _errorMessage = null);
    return true;
  }

  void _changePassword() {
    if (_validatePasswords()) {
      // TODO: Implement password change logic
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Your password has been changed successfully.'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to account screen
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              title: 'Change Password',
              showBackButton: true,
              showProfile: false,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password Requirements:',
                    style: TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Minimum 8 characters\n• At least one uppercase letter\n• At least one number\n• At least one special character',
                    style: TextStyle(
                      color: const Color(0xFF05001E).withOpacity(0.6),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPasswordField(
                    placeholder: 'Current Password',
                    controller: _currentPasswordController,
                    isVisible: _currentPasswordVisible,
                    onToggleVisibility: () => setState(() =>
                        _currentPasswordVisible = !_currentPasswordVisible),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    placeholder: 'New Password',
                    controller: _newPasswordController,
                    isVisible: _newPasswordVisible,
                    onToggleVisibility: () => setState(
                        () => _newPasswordVisible = !_newPasswordVisible),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    placeholder: 'Confirm New Password',
                    controller: _confirmPasswordController,
                    isVisible: _confirmPasswordVisible,
                    onToggleVisibility: () => setState(() =>
                        _confirmPasswordVisible = !_confirmPasswordVisible),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: CupertinoColors.destructiveRed,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _changePassword,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
