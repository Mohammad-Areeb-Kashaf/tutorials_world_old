import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          fontFamily: GoogleFonts.montserrat().fontFamily,
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'Marhey', fontSize: 20),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            shape: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xff6539b3),
          ),
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
