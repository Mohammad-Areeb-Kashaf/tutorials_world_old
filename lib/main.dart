import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_wallah/screens/home_page.dart';
import 'package:tutorials_wallah/screens/sign_in_page.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorials Wallah',
      home: HomePage(),
    );
  }
}
