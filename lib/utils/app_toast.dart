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
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.only(
        top: 20,
        right: 16,
        left: isDesktop ? width - 380 : 16,
      ),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      backgroundColor: isSuccess
          ? const Color.fromARGB(255, 119, 211, 127)
          : const Color.fromARGB(255, 221, 22, 22),
      borderColor: borderColor,
      borderWidth: 1.5,
      messageText: Row(
        children: [
          Icon(icon, color: borderColor, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isSuccess ? Colors.green.shade900 : Colors.red.shade900,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ).show(context);
  }
}
