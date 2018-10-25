//import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/eq_generator.dart';

class QuestionText extends StatefulWidget {
  //final String _question;

  @override
  State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText> {
  List test = generateEq();

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Color.fromRGBO(0, 0, 0, 0.0),
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        child: new Center(  
          child: new Text(test[0] + test[1] + test[2] + " =", style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),)
        )
      ),
    );
  }
}