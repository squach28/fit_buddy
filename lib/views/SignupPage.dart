import 'package:fit_buddy/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fit_buddy/services/AuthenticationService.dart';
import 'package:fit_buddy/models/SignUpResult.dart';

class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _signupFormKey =
      GlobalKey<FormState>(); // key to store the form's state
  final focusScopeNode =
      FocusScopeNode(); // allows focus to change from one field to another
  // text editing controllers for input fields
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _scrollController = ScrollController();
  AutovalidateMode _autoValidateMode =
      AutovalidateMode.disabled; // initialize auto validate mode to false

  final authenticationService = AuthenticationService();

  bool passwordValidated = false;
  bool confirmPasswordValidated = false;
  bool signingUp = false;
  bool confirmPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(validatePasswordLength);
    _confirmPasswordController.addListener(validateMatchingPasswords);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _signupPageHeader() {
    return Padding(
        padding:
            EdgeInsets.only(left: 25.0, top: 10.0, bottom: 20.0, right: 20.0),
        child: Text('Sign Up', style: TextStyle(fontSize: 25.0)));
  }

  Widget _signupForm() {
    return Form(
        key: _signupFormKey,
        autovalidateMode: _autoValidateMode,
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: FocusScope(
              node: focusScopeNode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Color(0xffebedf0),
                      filled: true,
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                    validator: validateFirstName,
                    onEditingComplete: () {
                      focusScopeNode.nextFocus();
                      scrollDown(focusScopeNode.focusedChild.rect.height);
                    },
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Color(0xffebedf0),
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                    validator: validateEmail,
                    onEditingComplete: () {
                      focusScopeNode.nextFocus();
                      scrollDown(200.0);
                    },
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Color(0xffebedf0),
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                    validator: validatePassword,
                    onEditingComplete: () {
                      focusScopeNode.nextFocus();
                      scrollDown(200.0);
                    },
                  ),
                  Padding(
                      
                      padding: EdgeInsets.only(top: 5.0, bottom: 1.0),
                      child: Row(children: [
                        Text('Password must be at least 6 characters'),
                        SizedBox(width: 5.0),
                        passwordValidated
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.clear, color: Colors.red),
                      ])),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onTap: () {
                      setState(() {
confirmPasswordFocused = true;
                      });
                    },
                    controller: _confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Color(0xffebedf0),
                      filled: true,
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                    validator: validateConfirmPassword,
                    onEditingComplete: () {
                      focusScopeNode.nextFocus();
                      setState(() {
                        confirmPasswordFocused = false;
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 1.0),
                      child: Row(children: [
                        Text('Passwords must match'),
                        SizedBox(width: 5.0),
                        confirmPasswordValidated
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.clear, color: Colors.red),
                      ])),
                  SizedBox(height: confirmPasswordFocused ? 100.0 : 0),
                  SizedBox(height: 40.0),
                  Material(
                      elevation: 12.0,
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        child: TextButton(
                            child: Text('Sign Up',
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
                            onPressed: () async {
                              if (validateFields()) {
                                final firstName = _firstNameController.text;
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                focusScopeNode.unfocus();
                                SignUpResult signUpResult =
                                    await authenticationService.signUp(
                                        firstName, email, password);
                                setState(() {
                                  signingUp = true;
                                });
                                if (signUpResult != SignUpResult.SUCCESS) {
                                  setState(() {
                                    signingUp = false;
                                  });
                                  _showSignUpAlert(signUpResult);
                                } else {
                                  // navigate to home page
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                                }
                              }
                            }),
                      )),
                ],
              ),
            )));
  }

// TODO change scrollDown parameter to widget? center the screen based on the widget
  void scrollDown(double height) {
    _scrollController.animateTo(height,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  String validateFirstName(String value) {
    if (value.isEmpty) {
      return 'First name is required';
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!EmailValidator.validate(value)) {
      return 'Email is not valid';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return '';
    } else {
      return null;
    }
  }

  String validateConfirmPassword(String value) {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if (password != confirmPassword) {
      return '';
    } else {
      return null;
    }
  }

  // method to constantly validate password length
  void validatePasswordLength() {
    final passwordLength = _passwordController.text.length;
    if (passwordLength >= 6) {
      setState(() {
        passwordValidated = true;
      });
    } else {
      setState(() {
        passwordValidated = false;
      });
    }
  }

  // method to constantly validate matching passwords
  void validateMatchingPasswords() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    print('password: ' + password + ' confirmPassword: ' + confirmPassword);
    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordValidated = false;
      });
    } else if (password != confirmPassword) {
      setState(() {
        confirmPasswordValidated = false;
      });
    } else {
      setState(() {
        confirmPasswordValidated = true;
      });
    }
  }

  bool validateFields() {
    if (!_signupFormKey.currentState.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return false;
    } else {
      return true;
    }
  }

  Future<void> _showSignUpAlert(SignUpResult signUpResult) {
    switch (signUpResult) {
      case SignUpResult.WEAK_PASSWORD:
        {
          return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Weak Password'),
                  content: Text('Password must be 6 characters or more'),
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
      case SignUpResult.EMAIL_IN_USE:
        {
          return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Email in Use'),
                  content: Text('Email is already used'),
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

      case SignUpResult.FAIL:
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            child: Stack(
              children: [
                Center(
                    child: Opacity(
                        opacity: signingUp ? 1.0 : 0.0,
                        child: CircularProgressIndicator())),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _signupPageHeader(),
                    _signupForm(),
                  ],
                )
              ],
            )));
  }
}
