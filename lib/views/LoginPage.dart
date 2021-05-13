import 'package:fit_buddy/models/SignInResult.dart';
import 'package:fit_buddy/services/AuthenticationService.dart';
import 'package:fit_buddy/views/HomePage.dart';
import 'package:fit_buddy/views/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final authenticationService = AuthenticationService();

  Widget _loginPageHeader() {
    return Padding(
        padding:
            EdgeInsets.only(left: 25.0, top: 50.0, bottom: 20.0, right: 20.0),
        child: Text('Log In', style: TextStyle(fontSize: 25.0)));
  }

  Widget _loginForm() {
    return Form(
        key: _loginFormKey,
        autovalidateMode: _autoValidateMode,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                 keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                focusNode: emailFocusNode,
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
                controller: _passwordController,
                validator: validatePassword,
                focusNode: passwordFocusNode,
                decoration: InputDecoration(
                  fillColor: Color(0xffebedf0),
                  filled: true,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                ),
                obscureText: true,
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(width: 0, style: BorderStyle.none),
                          )),
                        ),
                        onPressed: () async {
                          if(!validateFields()) {

                          } else {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            SignInResult signInResult = await authenticationService.logIn(email, password);
                            // TODO show progress indicator while waiting for login
                            if(signInResult != SignInResult.SUCCESS) {
                              _showLoginAlert(signInResult);
                              emailFocusNode.unfocus();
                              passwordFocusNode.unfocus();
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                            }

                          }

                        }),
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
                      text: 'Log in with Google', onPressed: () async {
                    googleSignIn().then((value) {
                      if (value == null) {
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
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
        ));
  }

  Widget _signUpText() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text("Don't have an account?",
              style: TextStyle(
                fontSize: 16.0,
              )),
          TextButton(
              child: Text('Sign Up',
                  style: TextStyle(fontSize: 16.0, color: Color(0xff567551))),
              onPressed: () {
                emailFocusNode.unfocus();
                passwordFocusNode.unfocus();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              }),
        ]));
  }

  Widget _forgotPasswordText() {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextButton(
              child: Text('Forgot your password?',
                  style: TextStyle(fontSize: 16.0, color: Color(0xff567551))),
              onPressed: () {}),
        ]));
  }

  String validateEmail(String value) {
    if(value.isEmpty) {
      return 'Email cannot be empty';
    } else if(!EmailValidator.validate(value)) {
      return 'Email is not valid';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if(value.isEmpty) {
      return 'Password cannot be empty';
    } else {
      return null;
    }
  }

  bool validateFields() {
    if(!_loginFormKey.currentState.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return false;
    } else {
      return true;
    }
  }

   Future<void> _showLoginAlert(SignInResult signInResult) {
    switch (signInResult) {
      case SignInResult.USER_NOT_FOUND:
        {
          return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("User doesn't Exist"),
                  content: Text("Try using a different email or creating an account"),
                  actions: [
                    TextButton(
                        child: Text('OK',
                            style: TextStyle(color: Color(0xff567551))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                );
              });
        }
      case SignInResult.WRONG_PASSWORD:
        {
          return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Incorrect Password'),
                  content: Text('Please try again'),
                  actions: [
                    TextButton(
                        child: Text('OK',
                            style: TextStyle(color: Color(0xff567551))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                );
              });
        }

      case SignInResult.FAIL:
        {
          return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Login Failed'),
                  content: Text('Please try again later'),
                  actions: [
                    TextButton(
                        child: Text('OK',
                            style: TextStyle(color: Color(0xff567551))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                );
              });
        }

      default:
        {
          return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Account Creation Failed'),
                  content: Text('Please try again'),
                  actions: [
                    TextButton(
                        child: Text('OK',
                            style: TextStyle(color: Color(0xff567551))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                );
              });
        }
    }
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
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _loginPageHeader(),
                _loginForm(),
                SizedBox(height: 25.0),
                _signUpText(),
                _forgotPasswordText(),
              ],
            )));
  }
}
