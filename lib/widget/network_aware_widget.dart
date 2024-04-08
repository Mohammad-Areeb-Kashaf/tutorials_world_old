import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorials_world/services/network_services.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAwareWidget(
      {super.key, required this.onlineChild, required this.offlineChild});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(builder: (context, data, child) {
      return data == NetworkStatus.Online ? onlineChild : offlineChild;
    });
  }
}
