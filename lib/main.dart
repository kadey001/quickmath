import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './pages/home_page.dart';
import './pages/login_page.dart';
import './utils/auth.dart';

/*TODO: Update settings through database so that it is will
  stay set when re-launching game */
String theme = 'rainbow'; //'rainbow' 'dark' are alternatives
Widget _defaultHome = LoginPage();

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'quickmathA',
    options: const FirebaseOptions(
      googleAppID: '1:592653824088:android:4a30b470a2237bfe',
      gcmSenderID: '592653824088',
      apiKey: 'AIzaSyA7eZwIkd24EyhRHtOvRJ5v5dXhEGXiVoY',
      projectID: 'quick-math-23fc2',
    ),
  );

  bool loginStatus = await authService.signInStatus();
  FirebaseUser user = await authService.currentUser();
  if(loginStatus) {
    _defaultHome = HomePage(user: user);
  }

  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder> {
    LoginPage.route: (BuildContext context) => LoginPage(),
    HomePage.route: (BuildContext context) => HomePage(),
  };

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: _defaultHome, //changes home route based on sign in status
      routes: routes,
    );
  }
}

// import './pages/test.dart';

// void main() => runApp(new MaterialApp(home: new Test()));