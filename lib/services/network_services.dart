import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) async {
      networkStatusController.add(await _getNetworkStatus(status));
    });
    var timer =
        Timer.periodic(Duration(seconds: 8), (timer) => checkInternet());
  }
  checkInternet() async {
    var connection = await InternetConnectionChecker().hasConnection;
    connection
        ? networkStatusController.add(NetworkStatus.Online)
        : networkStatusController.add(NetworkStatus.Offline);
  }

  _getNetworkStatus(ConnectivityResult status) async {
    if (status != ConnectivityResult.none) {
      var connection = await InternetConnectionChecker().hasConnection;
      return connection ? NetworkStatus.Online : NetworkStatus.Offline;
    } else {
      return NetworkStatus.Offline;
    }
  }
}
