import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
