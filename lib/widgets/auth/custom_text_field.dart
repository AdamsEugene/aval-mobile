// lib/widgets/auth/custom_text_field.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscurePassword;
  final VoidCallback? onTogglePassword;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.obscurePassword = true,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Platform.isIOS
                ? CupertinoTextField.borderless(
                    controller: controller,
                    obscureText: isPassword && obscurePassword,
                    placeholder: label,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    style: const TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                    ),
                  )
                : TextField(
                    controller: controller,
                    obscureText: isPassword && obscurePassword,
                    decoration: InputDecoration(
                      hintText: label,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF05001E),
                      fontSize: 16,
                    ),
                  ),
          ),
          if (isPassword)
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: onTogglePassword,
              icon: Icon(
                obscurePassword
                    ? (Platform.isIOS
                        ? CupertinoIcons.eye
                        : Icons.visibility_outlined)
                    : (Platform.isIOS
                        ? CupertinoIcons.eye_slash
                        : Icons.visibility_off_outlined),
                color: const Color(0xFFFDC202),
              ),
            )
          else
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(
                Platform.isIOS ? CupertinoIcons.mail : Icons.mail_outline,
                color: const Color(0xFFFDC202),
              ),
            ),
        ],
      ),
    );
  }
}
