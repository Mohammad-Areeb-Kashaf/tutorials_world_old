import 'package:flutter/material.dart';

class DecoratedButton extends StatelessWidget {
  const DecoratedButton(
      {super.key, required Widget this.child, required Function this.onTap});

  final child;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Colors.deepPurple.shade500,
              Colors.deepPurple.shade600,
            ])),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
