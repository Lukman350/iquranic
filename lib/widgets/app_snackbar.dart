import 'package:flutter/material.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      content:
          Text(message, style: TextStyle(color: textColor ?? Colors.white)),
      backgroundColor: backgroundColor ?? Colors.red[700]!,
      duration: duration ?? const Duration(seconds: 3),

    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
