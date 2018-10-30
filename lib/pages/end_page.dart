import 'package:flutter/material.dart';
import 'package:quickmath/main.dart';
import 'dart:math';

import '../pages/home_page.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';

class EndPage extends StatefulWidget {
  final int score;
  final Color color;
  EndPage({Key key, @required this.score, @required this.color}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState(score: score, previousColor: color);
}

class _EndPageState extends State<EndPage> {
  final int score;
  Color previousColor, currentColor;
  _EndPageState({Key key, @required this.score, @required this.previousColor});

  @override
  void initState() {
    super.initState();
    currentColor = randomColorGen(previousColor);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: theme == 'dark' ? Colors.black : theme == 'darkColorText' ? Colors.black : currentColor,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            // decoration: BoxDecoration(
            //   border: new Border.all(color: Colors.white, width: 6.0)
            // ),
            padding: new EdgeInsets.all(5.0),
            alignment: Alignment.topCenter,
            child: new Text("Results", style: TextStyle(color: theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? colors[new Random().nextInt(7)] : Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold,)),
          ),
          new Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
            child: new Text("Final Score: $score",
              style: TextStyle(color: theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? colors[new Random().nextInt(7)] : Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold,)
            ),
          ),
          new Container(
            // decoration: BoxDecoration(
            //   border: new Border.all(color: Colors.white, width: 2.0),
            // ),
            child: new TextButton(
              "Home", 
              () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null), 
              TextStyle(color: theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? colors[new Random().nextInt(7)] : Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
              EdgeInsets.all(5.0)
            ),
          ),
        ],
      ),
    );
  }
}