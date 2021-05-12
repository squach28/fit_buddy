import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _signupFormKey = GlobalKey<FormState>();
  final focusScopeNode = FocusScopeNode();
  final _passwordController = TextEditingController();
  final _scrollController = ScrollController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;


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
                    onEditingComplete: focusScopeNode.nextFocus,
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
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
                    validator: validatePassword,
                    onEditingComplete: focusScopeNode.nextFocus,
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
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
                  ),
                  SizedBox(height: 50.0),
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
                            onPressed: validateFields),
                      )),
                ],
              ),
            )));
  }

   void scrollDown() {
    _scrollController.animateTo(100,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  String validateFirstName(String value) {
    if(value.isEmpty) {
      return 'First name is required';
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    if(value.isEmpty) {
      return 'Email is required';
    } else if(!EmailValidator.validate(value)) {
      return 'Email is not valid';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if(value.isEmpty) {
      return 'Password is required';
    } else {
      return null;
    }
  }

    String validateConfirmPassword(String value) {
    final password = _passwordController.text;
    if(value.isEmpty) {
      return 'Confirm Password is required';
    } else if(value != password) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  void validateFields() {
    if(!_signupFormKey.currentState.validate()) {
      setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
      });

    } else {
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
