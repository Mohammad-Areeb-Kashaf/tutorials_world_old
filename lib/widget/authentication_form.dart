import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_wallah/widget/my_text_field.dart';
import 'package:tutorials_wallah/Utilities/auth_errors.dart';

class AuthForm extends StatefulWidget {
  final emailController;
  final passwordController;
  final isLogin;

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

  var emailErrorText = null;

  var passwordErrorText = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          labelText: 'Email',
          hintText: 'Enter Your Email',
          obscureText: false,
          errorText: emailErrorText,
          isEmail: true,
          controller: widget.emailController,
          isEnabled: true,
        ),
        const SizedBox(
          height: 30,
        ),
        MyTextField(
          labelText: 'Password',
          hintText: 'Enter Your Password',
          obscureText: true,
          errorText: passwordErrorText,
          isEmail: true,
          controller: widget.passwordController,
          isEnabled: true,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () async {
            if (widget.isLogin) {
              authenticateLogin();
            } else {
              authenticateRegister();
            }
          },
          child: Text(
            widget.isLogin ? 'Sign In' : 'Register',
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
          style: ElevatedButton.styleFrom(minimumSize: const Size(1400, 50)),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(106.0, 50.0))),
            onPressed: () {
              if (widget.isLogin) {
                // Navigator.pushReplacement(context,
                //     CupertinoPageRoute(builder: (context) => Register()));
              } else {
                // Navigator.pushReplacement(
                //     context, CupertinoPageRoute(builder: (context) => Login()));
              }
            },
            child: Text(
              widget.isLogin ? 'Register' : 'Sign In',
              style: TextStyle(
                fontSize: 26,
                color: Colors.deepPurpleAccent.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  authenticateLogin() async {
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
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Future.delayed(Duration.zero, () {
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Home(
          //               user: _auth.currentUser!.uid,
          //               isGoogleSignedIn: false,
          //             )));
        });
      } catch (e) {
        print(e);
        if (e.toString().contains('email')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e, isEmail: true, isUser: false, isPassword: false);
          });
        } else if (e.toString().contains('wrong-password')) {
          setState(() {
            passwordErrorText = checkLoginAuthError(
                e: e, isEmail: false, isUser: false, isPassword: true);
          });
        } else if (e.toString().contains('user')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e, isEmail: false, isUser: true, isPassword: false);
            passwordErrorText = checkLoginAuthError(
                e: e, isEmail: false, isUser: true, isPassword: false);
          });
        } else if (e.toString().contains('device')) {
          setState(() {
            emailErrorText = checkLoginAuthError(
                e: e, isEmail: false, isUser: true, isPassword: false);
            passwordErrorText = checkLoginAuthError(
                e: e, isEmail: false, isUser: true, isPassword: false);
          });
        }
      }
    }
  }

  authenticateRegister() async {
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
    } else if (widget.emailController.text.toString().contains('@') == false) {
      emailErrorText = "Email should contain '@'";
    } else if (widget.emailController.text.toString().contains('.com') ==
        false) {
      emailErrorText = "Email should contain '.com'";
    } else {
      var email = widget.emailController.text;
      var password = widget.passwordController.text;

      try {
        final user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Future.delayed(Duration.zero, () {
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Home(
          //               user: _auth.currentUser!.uid,
          //               isGoogleSignedIn: false,
          //             )));
        });
      } catch (e) {
        print(e);
        if (e.toString().contains('email')) {
          setState(() {
            emailErrorText =
                checkRegisterAuthError(e: e, isEmail: true, isUser: false);
          });
        } else if (e.toString().contains('network')) {
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
