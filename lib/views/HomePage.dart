import 'package:fit_buddy/services/AuthenticationService.dart';
import 'package:fit_buddy/views/LoginPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Home Page')));
  }
}
