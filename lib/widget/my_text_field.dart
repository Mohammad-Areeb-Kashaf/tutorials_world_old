// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  bool isEmail;
  var errorText;
  MyTextField({
    super.key,
    required this.controller,
    required this.errorText,
    required this.hintText,
    required this.icon,
    required this.isEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: isEmail
          ? BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)))
          : null,
      child: TextField(
        obscureText: isEmail == false ? true : false,
        cursorColor: Colors.black,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        controller: controller,
        selectionControls: CupertinoTextSelectionControls(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey.shade400,
          ),
          errorText: errorText,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
