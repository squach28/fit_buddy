import 'package:fit_buddy/services/AuthenticationService.dart';
import 'package:fit_buddy/views/HomePage.dart';
import 'package:fit_buddy/views/LoginPage.dart';
import 'package:fit_buddy/views/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final ThemeData theme = new ThemeData(
    scaffoldBackgroundColor: Color(0xff222831),
    primaryColor: Color(0xff267055),
    textTheme: Typography.whiteRedwoodCity,
    primaryColorDark: Color(0xff222831),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(),
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // something went wrong
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final authenticationService = AuthenticationService();
            if (authenticationService.auth.currentUser != null) {
              return MaterialApp(
                  themeMode: ThemeMode.dark,
                  //theme: ThemeData(primaryColor: Color(0xff91c788), textTheme: Typography.whiteCupertino),
                  theme: theme,
                  debugShowCheckedModeBanner: false,
                  home: NavigationPage());
            } else {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: ThemeMode.dark,
                  theme: theme,
                  home: LoginPage());
            }
          }

          return MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        });
  }
}
