import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {duration = 4}) {
  final snackBar = SnackBar(
    duration: Duration(seconds: duration),
    content: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
