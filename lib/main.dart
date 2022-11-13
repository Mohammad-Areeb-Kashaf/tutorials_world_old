import 'package:flutter/material.dart';
import './firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutorials_wallah/screens/home_page.dart';
import 'package:tutorials_wallah/screens/sign_in_page.dart';
import 'package:tutorials_wallah/services/network_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatus>(
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
          initialData: NetworkStatus.Online,
        ),
      ],
      child: MaterialApp(
        title: 'Tutorials Wallah',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          listTileTheme: const ListTileThemeData(
            textColor: Colors.black,
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        home: _auth.currentUser != null ? HomePage() : SignInPage(),
      ),
    );
  }
}
