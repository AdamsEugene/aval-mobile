import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PlatformWidget {
  static bool get isIOS => Platform.isIOS;

  static Widget adaptiveProgress() {
    return isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }

  static void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) {
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            if (actionText != null)
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                  onAction?.call();
                },
                child: Text(actionText),
              ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            if (actionText != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onAction?.call();
                },
                child: Text(actionText),
              ),
          ],
        ),
      );
    }
  }

  static Widget adaptiveButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) {
    if (isIOS) {
      return CupertinoButton(
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
        ),
        onPressed: onPressed,
        child: Text(text),
      );
    }
  }

  static Widget adaptiveTextField({
    required String placeholder,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    if (isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
      );
    } else {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          border: const OutlineInputBorder(),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
      );
    }
  }
}
