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

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(validatePassword);
    _confirmPasswordController.addListener(validateConfirmPassword);
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
                      scrollDown();
                    },
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _emailController,
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
                      scrollDown();
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
                    onEditingComplete: () {
                      focusScopeNode.nextFocus();
                      scrollDown();
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 1.0),
                      child: Row(children: [
                        Text('Password must be at least 6 characters'),
                        SizedBox(width: 5.0),
                        passwordValidated
                            ? Icon(Icons.check)
                            : Icon(Icons.clear),
                      ])),
                  SizedBox(height: 20.0),
                  TextFormField(
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
                    onEditingComplete: () {
                      focusScopeNode.nextFocus();
                      scrollDown();
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
                            onPressed: () {
                              if (validateFields()) {
                                final firstName = _firstNameController.text;
                                final email = _emailController.text;
                                final password = _passwordController.text;

                                authenticationService.signUp(
                                    firstName, email, password);
                              }
                            }),
                      )),
                ],
              ),
            )));
  }
// TODO change scrollDown parameter to widget? center the screen based on the widget
  void scrollDown() {
    _scrollController.animateTo(100,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void validatePassword() {
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

  void validateConfirmPassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    print('password: ' + password + ' confirmPassword: ' + confirmPassword);
    if (password == confirmPassword) {
      setState(() {
        confirmPasswordValidated = true;
      });
    } else {
      setState(() {
        confirmPasswordValidated = false;
      });
    }
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signupPageHeader(),
                _signupForm(),
              ],
            )));
  }
}
