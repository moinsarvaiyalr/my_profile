import 'package:flutter/material.dart';

abstract final class ShowMessage {
  ShowMessage._();

  /// Displays an error message as a SnackBar.
  static void errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(
          seconds: 3,
        ), // Optional, specify the duration to show the SnackBar
      ),
    );
  }
}
