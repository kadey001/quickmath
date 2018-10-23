import 'package:flutter/material.dart';

/* Todo: Make box static and */

class AnswerBox extends StatefulWidget {
  @override
  State createState() => new AnswerBoxState();
}

class AnswerBoxState extends State<AnswerBox> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Color.fromRGBO(0, 0, 0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          border: new Border.all(color: Colors.white, width: 2.0)
        ),
        child: new Padding(
          padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: new Center(
            child: new Text("480", style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),)
          )
        ),
      ),
    );
  }
}