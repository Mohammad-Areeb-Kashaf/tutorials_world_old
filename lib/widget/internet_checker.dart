import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tutorials_wallah/screens/no_internet_page.dart';

class InternetChecker extends StatefulWidget {
  InternetChecker({super.key, this.child});

  final child;

  @override
  State<InternetChecker> createState() => _InternetCheckerState();
}

class _InternetCheckerState extends State<InternetChecker> {
  static var isDeviceConnected = true;
  static var subscription = null;
  static var connection = false;
  late Timer timer;
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
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) async {
      connection = await InternetConnectionChecker().hasConnection;
      setState(() {
        isDeviceConnected = connection;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDeviceConnected) {
      return widget.child;
    } else {
      return NoInternetPage();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    subscription.cancel();
  }
}
