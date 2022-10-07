import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/widget/decorated_button.dart';
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
    return Stack(
      children: [
        Container(
          decoration: kBackgroundDecoration,
        ),
        Positioned.fill(
          child: Container(
            margin: EdgeInsets.only(top: 200),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.isLogin ? "Sign In" : "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 300),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade100))),
                      child: TextField(
                        controller: widget.emailController,
                        decoration: InputDecoration(
                          errorText: emailErrorText,
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: kTextFieldHintStyle,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: widget.passwordController,
                        decoration: InputDecoration(
                          errorText: passwordErrorText,
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: kTextFieldHintStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DecoratedButton(
                child: Center(
                  child: Text(
                    widget.isLogin ? "Sign In" : "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                onTap: () {
                  if (widget.isLogin) {
                    authenticateLogin();
                  } else {
                    authenticateRegister();
                  }
                },
              ),
              widget.isLogin
                  ? SizedBox(
                      height: 70,
                    )
                  : SizedBox.shrink(),
              widget.isLogin
                  ? Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.only(top: 180),
                child: GestureDetector(
                  onTap: () {
                    if (widget.isLogin) {
                      // Go to Sign Up Page
                    } else {
                      // Go to Sign In Page
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.isLogin
                              ? 'Don\'t have an Account? '
                              : 'Already have an Account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: widget.isLogin ? 'Sign Up' : 'Sign In',
                          style: TextStyle(
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
