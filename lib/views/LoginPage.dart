import 'package:fit_buddy/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  Widget _loginForm() {
    return Form(
        key: _loginFormKey,
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Color(0xffebedf0),
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Color(0xffebedf0),
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Material(
                      elevation: 12.0,
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        child: TextButton(
                            child: Text('Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff91c788)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              )),
                            ),
                            onPressed: () {}),
                      )),
                  SizedBox(height: 25.0),
                  Row(children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 50.0,
                            ))),
                    Text('OR'),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: 50.0,
                            ))),
                  ]),
                  Container(
                      width: double.infinity,
                      child: SignInButton(Buttons.Google,
                          text: 'Log in with Google',
                          onPressed: () async{
                            googleSignIn().then((value) {
                              if(value == null) {

                              } else {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                              }
                            });

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(width: 0, style: BorderStyle.none),
                          ),
                          elevation: 5.0)),
                ],
              ),
            )));
  }

  Widget _signUpButton() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(children: [
          Text("Don't have an account?"),
          TextButton(child: Text('Sign Up'), onPressed: () {}),
        ]));
  }

  Future<GoogleSignInAccount> googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      var account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _loginForm(),
        SizedBox(height: 25.0),
        _signUpButton(),
      ],
    ));
  }
}
