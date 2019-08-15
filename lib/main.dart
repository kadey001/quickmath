import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import './pages/home_page.dart';
import './pages/login_page.dart';

import './utils/auth.dart';

//TODO: Update theme using database
String theme = 'rainbow'; //'rainbow' 'dark' are alternatives
Widget _defaultHome = LoginPage();

Future<void> main() async {
  //Configuring App options/settings
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'quickmathA',
    options: const FirebaseOptions(
      googleAppID: '1:592653824088:android:4a30b470a2237bfe',
      gcmSenderID: '592653824088',
      apiKey: 'AIzaSyA7eZwIkd24EyhRHtOvRJ5v5dXhEGXiVoY',
      projectID: 'quick-math-23fc2',
    ),
  );

  //Checking if user is already signed in for automatic redirection to login or home page
  bool loginStatus = await authService.signInStatus();
  if(loginStatus) {
    _defaultHome = HomePage();
  }

  //Setting up Firestore
  //TODO: Is this nessisary? Maybe only check if logged in?
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  //Run app in portrait only mode
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