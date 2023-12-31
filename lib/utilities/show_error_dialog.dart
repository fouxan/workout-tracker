import 'package:flutter/material.dart';

Future<void> showErrorDialog(context, text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("an error occurred."),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("ok."),
          )
        ],
      );
    },
  );
}
