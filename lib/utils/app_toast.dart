import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppToast {
  static void showError(BuildContext context, String message) {
    _show(context, message, borderColor: Colors.red, icon: Icons.close);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, borderColor: Colors.green, icon: Icons.check);
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color borderColor,
    required IconData icon,
  }) {
    final isSuccess = borderColor == Colors.green;

    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(
        top: 20,
        left: 1000,
        right: 16,
      ),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      backgroundColor: isSuccess
          ? const Color.fromARGB(255, 119, 211, 127)
          : const Color.fromARGB(255, 221, 22, 22),
      borderColor: borderColor,
      borderWidth: 1.5,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
        ),
      ],
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor),
            ),
            padding: const EdgeInsets.all(4),
            child: Icon(icon, color: borderColor, size: 16),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: isSuccess ? Colors.green.shade900 : Colors.red.shade900,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close,
              size: 18,
              color: isSuccess ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    ).show(context);
  }
}
