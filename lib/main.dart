import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import './pages/home_page.dart';

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

  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomePage(firestore: firestore)
  ));
  });
}