import 'package:flutter/material.dart';
import 'package:tutorials_wallah/widget/authentication_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(
        emailController: emailController,
        passwordController: passwordController,
        isLogin: false,
      ),
    );
  }
}
