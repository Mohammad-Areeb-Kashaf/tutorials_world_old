import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorials_world/constants.dart';
import 'package:tutorials_world/widget/my_text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var emailErrorText;
  bool isEmailSent = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
        ),
      ),
      body: isEmailSent
          ? const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Reset Password Email has been sent to your email, Please reset your password and try again.',
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 100),
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
                        ],
                      ),
                      child: MyTextField(
                        controller: widget.emailController,
                        errorText: emailErrorText,
                        hintText: "Enter Email",
                        icon: Icons.person_outline,
                        isEmail: true,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        try {
                          _auth.sendPasswordResetEmail(
                              email: widget.emailController.text);
                          setState(() {
                            isEmailSent = true;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.purpleColor,
                        ),
                        child: const Center(
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
