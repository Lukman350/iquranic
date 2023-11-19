import 'package:flutter/material.dart';

class AlertError extends StatelessWidget {
  final String message;
  const AlertError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(message,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.red[400])),
      actions: <Widget>[
        TextButton(
          // close the dialog
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
