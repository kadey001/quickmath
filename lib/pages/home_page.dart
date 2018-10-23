import 'package:flutter/material.dart';

import './highscores_page.dart';
import './play_page.dart';
import './settings_page.dart';
import './stats_page.dart';

import '../utils/button.dart';
import '../utils/random_colors.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: randomColorGen(),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              border: new Border.all(color: Colors.white, width: 8.0)
            ),
            padding: new EdgeInsets.all(10.0),
            child: new Text("Quick Math", style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),),
          ),
          new Text("\n\n\n"),
          new TextButton(
            "Play", 
            () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new PlayPage()), (Route route) => route == null), 
            TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold)
          ),
          new Text("\n"),
          new TextButton(
            "High Scores", 
            () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HighscoresPage()), (Route route) => route == null), 
            TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold)
          ),
          new Text("\n"),
          new TextButton(
            "Stats", 
            () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new StatsPage()), (Route route) => route == null), 
            TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold)
          ),
          new Text("\n"),
          new TextButton(
            "Settings", 
            () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new SettingsPage()), (Route route) => route == null), 
            TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }
}