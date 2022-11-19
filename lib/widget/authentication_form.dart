import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_wallah/screens/home_page.dart';
import 'package:tutorials_wallah/services/auth_errors.dart';
import 'package:tutorials_wallah/screens/sign_in_page.dart';
import 'package:tutorials_wallah/screens/sign_up_page.dart';
import 'package:tutorials_wallah/widget/my_text_field.dart';
import 'package:tutorials_wallah/constants.dart';

class AuthForm extends StatefulWidget {
  var emailController;
  var passwordController;
  var isLogin;

  AuthForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.isLogin,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _auth = FirebaseAuth.instance;
  var emailErrorText;
  var passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.isLogin ? "Sign In" : "Sign Up",
                style: const TextStyle(
                    color: Constants.purpleColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 100),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        MyTextField(
                          controller: widget.emailController,
                          errorText: emailErrorText,
                          hintText: "Enter Email",
                          icon: Icons.person_outline,
                          isEmail: true,
                        ),
                        MyTextField(
                          controller: widget.passwordController,
                          errorText: passwordErrorText,
                          hintText: "Enter Password",
                          icon: Icons.lock_outline,
                          isEmail: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.isLogin) {
                        authenticateSignIn();
                      } else {
                        authenticateSignUp();
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.purpleColor,
                      ),
                      child: Center(
                        child: Text(
                          widget.isLogin ? "Sign In" : "Sign Up",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.isLogin
                      ? const SizedBox(
                          height: 70,
                        )
                      : const SizedBox.shrink(),
                  widget.isLogin
                      ? const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: widget.isLogin
                        ? const EdgeInsets.only(top: 150.0)
                        : const EdgeInsets.only(top: 175.0),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.isLogin) {
                          // Go to Sign Up Page
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignUpPage()));
                        } else {
                          // Go to Sign In Page
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignInPage()));
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.isLogin
                                  ? 'Don\'t have an Account? '
                                  : 'Already have an Account? ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: widget.isLogin ? 'Sign Up' : 'Sign In',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  authenticateSignIn() async {
    setState(() {
      emailErrorText = null;
      passwordErrorText = null;
    });
    if (widget.emailController.text.isEmpty &
        widget.passwordController.text.isEmpty) {
      setState(() {
        emailErrorText = 'Please enter your Email';
        passwordErrorText = 'Please enter your Password';
      });
    } else if (widget.emailController.text.isEmpty) {
      setState(() {
        emailErrorText = 'Please enter your Email';
      });
    } else if (widget.passwordController.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Please enter your Email';
      });
    } else if (widget.passwordController.text.length < 6) {
      setState(() {
        passwordErrorText = 'Password should at least contain 6 characters';
      });
    } else {
      var email = widget.emailController.text;
      var password = widget.passwordController.text;

      try {
        print('signing in');
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        if (e.toString().toLowerCase().split(' ').contains('email')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: true,
                isUser: false,
                isPassword: false);
          });
        } else if (e
            .toString()
            .toLowerCase()
            .split(' ')
            .contains('wrong-password')) {
          setState(() {
            passwordErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: false,
                isUser: false,
                isPassword: true);
          });
        } else if (e.toString().toLowerCase().split(' ').contains('user')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: false,
                isUser: true,
                isPassword: false);
            passwordErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: false,
                isUser: true,
                isPassword: false);
          });
        } else if (e.toString().toLowerCase().split(' ').contains('device')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: false,
                isUser: true,
                isPassword: false);
            passwordErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: false,
                isUser: true,
                isPassword: false);
          });
        } else {}
      }
    }
  }

  authenticateSignUp() async {
    setState(() {
      emailErrorText = null;
      passwordErrorText = null;
    });
    if (widget.emailController.text.isEmpty &
        widget.passwordController.text.isEmpty) {
      setState(() {
        emailErrorText = 'Please enter your Email';
        passwordErrorText = 'Please enter your Password';
      });
    } else if (widget.emailController.text.isEmpty) {
      setState(() {
        emailErrorText = 'Please enter your Email';
      });
    } else if (widget.passwordController.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Please enter your Email';
      });
    } else if (widget.passwordController.text.length < 6) {
      setState(() {
        passwordErrorText = 'Password should at least contain 6 characters';
      });
    } else if (widget.emailController.text
            .toString()
            .toLowerCase()
            .split(' ')
            .contains('@') ==
        false) {
      emailErrorText = "Email should contain '@'";
    } else {
      var email = widget.emailController.text;
      var password = widget.passwordController.text;

      try {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        if (e.toString().toLowerCase().split(' ').contains('email')) {
          setState(() {
            emailErrorText =
                checkRegisterAuthError(e: e, isEmail: true, isUser: false);
          });
        } else if (e.toString().toLowerCase().split(' ').contains('network')) {
          setState(() {
            emailErrorText =
                checkRegisterAuthError(e: e, isEmail: false, isUser: true);
            passwordErrorText =
                checkRegisterAuthError(e: e, isEmail: false, isUser: true);
          });
        }
      }
    }
  }
}
