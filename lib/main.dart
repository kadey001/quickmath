import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/home_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomePage()
  ));
  });
}