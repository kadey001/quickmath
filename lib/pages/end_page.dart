import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/play_page.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';
import '../utils/score.dart';

class EndPage extends StatefulWidget {
  final Score score;

  EndPage({Key key, @required this.score}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState(score: score);
}

class _EndPageState extends State<EndPage> {
  final Score score;
  Score _score = Score(0);

  _EndPageState({Key key, @required this.score});

  @override
    void initState() {
      _score = score;
      print(_score);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: randomColorGen(),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              border: new Border.all(color: Colors.white, width: 6.0)
            ),
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            alignment: Alignment.topCenter,
            child: new Text("Results", style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold,)),
          ),
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
            child: new Text("Final Score: " + _score.score.toString(),
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold,)
            ),
          ),
          new Container(
            decoration: BoxDecoration(
              border: new Border.all(color: Colors.white, width: 2.0),
            ),
            child: new TextButton(
              "Home", 
              () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null), 
              TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}