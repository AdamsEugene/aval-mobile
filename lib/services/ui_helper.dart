import 'package:flutter/cupertino.dart';

class UIHelper {
  // Show a simple alert dialog
  static void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onAction ?? () => Navigator.of(context).pop(),
            child: Text(actionText ?? 'OK'),
          ),
        ],
      ),
    );
  }

  // Show a loading indicator
  static void showLoading(BuildContext context, {String? message}) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: CupertinoColors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CupertinoActivityIndicator(radius: 16),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Hide the loading indicator
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Show an error notification
  static void showError(BuildContext context, String errorMessage) {
    showAlert(
      context: context,
      title: 'Error',
      message: errorMessage,
    );
  }

  // Show a success notification
  static void showSuccess({
    required BuildContext context,
    required String message,
    VoidCallback? onDismiss,
  }) {
    showAlert(
      context: context,
      title: 'Success',
      message: message,
      onAction: onDismiss,
    );
  }
} 