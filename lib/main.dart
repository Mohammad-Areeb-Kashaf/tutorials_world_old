import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorials_world/constants.dart';
import 'package:tutorials_world/screens/verify_email_page.dart';
import './firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutorials_world/screens/sign_in_page.dart';
import 'package:tutorials_world/services/network_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  MyApp({super.key});

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
        debugShowCheckedModeBanner: false,
        title: 'Tutorials World',
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.dark,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.kalam().fontFamily,
              fontSize: 24,
            ),
          ),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            unselectedIconTheme: IconThemeData(color: Colors.grey.shade500),
            selectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Constants.purpleColor,
            ),
          ),
          listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 4.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Constants.purpleColor,
          ),
          iconTheme: const IconThemeData(
            color: Constants.purpleColor,
          ),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(
              color: Constants.purpleColor,
            ),
            titleTextStyle: TextStyle(
              color: Constants.purpleColor,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.kalam().fontFamily,
              fontSize: 24,
            ),
            backgroundColor: Colors.white,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Constants.purpleColor,
            unselectedItemColor: Colors.grey.shade500,
            selectedLabelStyle: const TextStyle(
              color: Constants.purpleColor,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Constants.purpleColor,
            ),
            selectedIconTheme: const IconThemeData(
              color: Constants.purpleColor,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey.shade500,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          listTileTheme: const ListTileThemeData(
            textColor: Colors.black,
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Constants.purpleColor,
                width: 4.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        home:
            _auth.currentUser != null ? const VerifyEmailPage() : SignInPage(),
      ),
    );
  }
}
