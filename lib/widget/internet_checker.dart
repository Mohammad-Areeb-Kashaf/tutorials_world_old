import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tutorials_wallah/screens/no_internet_page.dart';
import 'package:tutorials_wallah/widget/network_aware_widget.dart';

class InternetChecker extends StatelessWidget {
  final Widget child;

  const InternetChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        onlineChild: child,
        offlineChild: NoInternetPage(),
      ),
    );
  }
}
