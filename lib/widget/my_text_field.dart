// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  bool isEmail;
  var errorText;
  bool isTutorial;
  bool isFirstTutorial;
  MyTextField({
    super.key,
    required this.controller,
    required this.errorText,
    required this.hintText,
    required this.icon,
    required this.isEmail,
    this.isFirstTutorial = false,
    this.isTutorial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: isTutorial
          ? isFirstTutorial
              ? BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade100)))
              : null
          : isEmail
              ? BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade100)))
              : null,
      child: TextField(
        obscureText: isTutorial
            ? false
            : isEmail
                ? false
                : true,
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
        ),
        keyboardType: isTutorial
            ? null
            : isEmail
                ? TextInputType.emailAddress
                : TextInputType.visiblePassword,
        controller: controller,
        selectionControls: CupertinoTextSelectionControls(),
        decoration: InputDecoration(
          prefixIcon: isTutorial
              ? null
              : Icon(
                  icon,
                  color: Colors.black,
                ),
          errorText: errorText,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
