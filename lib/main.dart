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
                  theme: ThemeData(primaryColor: Color(0xff91c788)),
                  debugShowCheckedModeBanner: false,
                  home: NavigationPage());
            } else {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(primaryColor: Color(0xff91c788)),
                  home: LoginPage());
            }
          }

          return MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        });
  }
}
