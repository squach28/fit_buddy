import 'package:fit_buddy/services/AuthenticationService.dart';
import 'package:fit_buddy/views/LoginPage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override 
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final authenticationService = AuthenticationService();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: TextButton(
                child: Text('Sign Out'),
                onPressed: () {
                  authenticationService.signOut();
                  authenticationService.googleSignOut();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                })),
    );
  }
}