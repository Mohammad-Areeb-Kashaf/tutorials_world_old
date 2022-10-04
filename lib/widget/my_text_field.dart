import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final labelText;
  final hintText;
  final obscureText;
  final errorText;
  final isEmail;
  final controller;
  final isEnabled;

  const MyTextField({
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.errorText,
    required this.isEmail,
    required this.controller,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: isEnabled,
      controller: controller,
      cursorHeight: 28,
      style: TextStyle(
        fontSize: 28,
      ),
      obscureText: obscureText ?? false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      decoration: InputDecoration(
        errorText: errorText ?? null,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          fontSize: 28,
        ),
        hintStyle: TextStyle(
          fontSize: 28,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
