import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quickmath/main.dart';

import '../pages/home_page.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';
import '../utils/firestore.dart';

class EndPage extends StatefulWidget {
  final int score;
  final String difficulty;
  final Color color;
  EndPage({Key key, @required this.score, @required this.difficulty, @required this.color}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState(score: score, difficulty: difficulty, previousColor: color);
}

class _EndPageState extends State<EndPage> {
  final int score;//Displayed score
  final String difficulty;
  Color previousColor, currentColor;
  _EndPageState({Key key, @required this.score, @required this.difficulty, @required this.previousColor});

  @override
  void initState() {
    super.initState();
    currentColor = randomColorGen(previousColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme == 'dark' ? Colors.black : theme == 'darkColorText' ? Colors.black : currentColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //   border: new Border.all(color: Colors.white, width: 6.0)
            // ),
            padding: EdgeInsets.all(5.0),
            alignment: Alignment.topCenter,
            child: Text("Results", style: TextStyle(color: theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? colors[new Random().nextInt(7)] : Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold,)),
          ),
          Container(
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
          Container(
            child: FutureBuilder(
              future: firestoreService.updateHighScores(score, difficulty),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text(snapshot.error.toString());
                } else if(snapshot.connectionState == ConnectionState.done){
                  return snapshot.hasData ? Text("Highscore: " + snapshot.data.toString()) : CircularProgressIndicator();
                } else {
                  return Text("Highscore: 0");
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text("Final Score: $score",
              style: TextStyle(color: theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? colors[new Random().nextInt(7)] : Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold,)
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: new Border.all(color: Colors.white, width: 2.0),
            // ),
            child: TextButton(
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