import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:quickmath/utils/auth.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static final String route = "login-page";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginButton = Container(
      padding: EdgeInsets.all(10.0),
      child: Material(
        child: MaterialButton(
          minWidth: 150.0,
          height: 50.0,
          color: Colors.deepOrangeAccent,
          child: Text('Guest Login'),
          onPressed: () => authService.anonSignIn().then((FirebaseUser user) {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage(user: user,)));
          }),
        ),
      ),  
    );
    final googleSignInButton = Container(
      padding: EdgeInsets.all(10.0),
      child: Material(
        child: MaterialButton(
          minWidth: 150.0,
          height: 50.0,
          color: Colors.deepOrangeAccent,
          child: Text('Google Login'),
          onPressed: () => authService.googleSignIn().then((FirebaseUser user) {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage(user: user,)));
          }),
        ),
      ), 
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              loginButton,
              googleSignInButton,
            ],
          ),
        ),
      ),
    );
  }
}