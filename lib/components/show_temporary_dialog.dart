import 'package:flutter/material.dart';

Future<void> showTemporaryDialog(BuildContext context, String message,
    {int durationSeconds = 3}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
    },
  );

  await Future.delayed(Duration(seconds: durationSeconds));

  if (context.mounted) {
    Navigator.of(context).pop();
  }
}
