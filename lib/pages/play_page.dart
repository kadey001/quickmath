import 'package:flutter/material.dart';
import 'dart:math';

import 'home_page.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/answer_box.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';

class PlayPage extends StatefulWidget {
  @override
  State createState() => new PlayPageState();
}

class PlayPageState extends State<PlayPage> {
  int gameTimer = 60; //Default timer 60 seconds

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: randomColorGen(),
      body: new Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: Row(
              children: <Widget>[
                new IconButton(
                  alignment: Alignment.topLeft,
                  padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  icon: new Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null),
                ),
              ],
            )
          ),
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 200.0),
            alignment: Alignment.center,
            //margin: const EdgeInsets.only(top: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new QuestionText(),
                new AnswerBox(),
              ],
            ),
          ),
        ],
      ),  
    );
  }
}