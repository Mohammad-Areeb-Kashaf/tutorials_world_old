import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tutorials_wallah/widget/authentication_form.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
