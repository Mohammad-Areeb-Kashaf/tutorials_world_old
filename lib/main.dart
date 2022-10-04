import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutorials Wallah',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isDeviceConnected = false;
  var subscription;
  var connection = false;

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Internet Available'),
              ElevatedButton(onPressed: () => checkInternet(), child: Text('check'))
            ],
          ),
        ),
      );
    } else {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Internet Not Available'),
                ElevatedButton(onPressed: () => checkInternet(), child: Text('Retry'))
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
