import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/screens/home_page.dart';
import 'package:tutorials_wallah/screens/reset_password_page.dart';
import 'package:tutorials_wallah/screens/sign_in_page.dart';
import 'package:tutorials_wallah/screens/sign_up_page.dart';
import 'package:tutorials_wallah/services/auth_errors.dart';
import 'package:tutorials_wallah/widget/my_text_field.dart';

class AuthForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLogin;
  
  const AuthForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLogin,
  });
  

  

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _auth = FirebaseAuth.instance;
  String? emailErrorText;
  String? passwordErrorText;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.isLogin ? "Sign In" : "Sign Up",
                style: TextStyle(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Colors.white
                        : Constants.purpleColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
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
                        border: Border.all(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Constants.kDarkBorderColor
                                : Constants.kLightBorderColor,
                            width: 3.0),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? null
                            : [
                                const BoxShadow(
                                  color: Color.fromRGBO(118, 32, 230, .3),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                ),
                              ],
                      ),
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
                          setState(() {
                            isLoading = true;
                          });
                          authenticateSignIn();
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          authenticateSignUp();
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .background
                              : Constants.purpleColor,
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
                            height: 30,
                          )
                        : const SizedBox.shrink(),
                    widget.isLogin
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => ResetPasswordPage()));
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
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
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: widget.isLogin ? 'Sign Up' : 'Sign In',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        setState(() {
          isLoading = true;
        });
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        if (e.toString().contains('email')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: true,
                isUser: false,
                isPassword: false);
          });
        } else if (e.toString().contains('wrong-password')) {
          setState(() {
            passwordErrorText = checkLoginAuthError(
                e: e.toString(),
                isEmail: false,
                isUser: false,
                isPassword: true);
          });
        } else if (e.toString().contains('user')) {
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
        } else if (e.toString().contains('device')) {
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
            .contains('@') ==
        false) {
      emailErrorText = "Email should contain '@'";
    } else {
      var email = widget.emailController.text.trim();
      var password = widget.passwordController.text.trim();

      try {
        setState(() {
          isLoading = true;
        });
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => const HomePage(),
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
