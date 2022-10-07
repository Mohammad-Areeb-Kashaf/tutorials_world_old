import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tutorials_wallah/screens/no_internet_page.dart';
import 'package:tutorials_wallah/screens/sign_in_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      title: 'Tutorials Wallah',
      home: displayScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  checkInternet() async {
    connection = await InternetConnectionChecker().hasConnection;
    setState(() {
      isDeviceConnected = connection;
    });
  }

  displayScreen() {
    if (isDeviceConnected) {
      return SignInPage();
    } else {
      return NoInternetPage(onTap: checkInternet());
    }
  }
}
