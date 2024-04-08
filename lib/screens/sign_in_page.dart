import 'package:flutter/material.dart';
import 'package:tutorials_world/widget/authentication_form.dart';
import 'package:tutorials_world/widget/internet_checker.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        body: AuthForm(
          emailController: emailController,
          passwordController: passwordController,
          isLogin: true,
        ),
      ),
    );
  }
}
