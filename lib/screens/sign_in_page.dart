import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tutorials_wallah/widget/authentication_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isDeviceConnected = false;
  var subscription;
  var connection = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        connection = await InternetConnectionChecker().hasConnection;
        setState(() {
          isDeviceConnected = connection;
        });
      } else {
        setState(() {
          connection = false;
          isDeviceConnected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDeviceConnected) {
      return Scaffold(
        body: AuthForm(
          emailController: emailController,
          passwordController: passwordController,
          isLogin: true,
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Internet Not Available'),
              ElevatedButton(
                  onPressed: () => checkInternet(), child: Text('Retry'))
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void checkInternet() async {
    connection = await InternetConnectionChecker().hasConnection;
    setState(() {
      isDeviceConnected = connection;
    });
  }
}
