import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/widget/authentication_form.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Container(
        decoration: Constants.kBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: AuthForm(
            emailController: emailController,
            passwordController: passwordController,
            isLogin: true,
          ),
        ),
      ),
    );
  }
}
