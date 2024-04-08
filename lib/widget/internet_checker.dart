import 'package:flutter/material.dart';
import 'package:tutorials_world/screens/no_internet_page.dart';
import 'package:tutorials_world/widget/network_aware_widget.dart';

class InternetChecker extends StatelessWidget {
  final Widget child;

  const InternetChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        onlineChild: child,
        offlineChild: const NoInternetPage(),
      ),
    );
  }
}
