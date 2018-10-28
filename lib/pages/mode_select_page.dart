import 'package:flutter/material.dart';

import '../pages/play_page.dart';
import '../pages/home_page.dart';
import '../pages/easy_mode_page.dart';
import '../pages/Play_Game_Page.dart';
import '../pages/normal_mode_page.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';

/*TODO: Add animations for text and Time limit chosing buttons 
that fly in from the right when difficulty is selected */

class ModeSelectPage extends StatefulWidget {
  final Color color;
  ModeSelectPage({Key key, @required this.color}) : super(key:key);
  @override
  State createState() => new _ModeSelectPageState(previousColor: color);
}

class _ModeSelectPageState extends State<ModeSelectPage> {
  final Color previousColor;
  _ModeSelectPageState({Key key, @required this.previousColor});
  Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = randomColorGen(previousColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            // decoration: BoxDecoration(
            //   border: new Border.all(color: Colors.white, width: 4.0)
            // ),
            padding: new EdgeInsets.only(bottom: 15.0),
            child: new Text("Chose Difficulty", style: TextStyle(color: Colors.white, fontSize: 45.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
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
            alignment: Alignment.center,
            child: new TextButton("Easy",
              () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new PlayGamePage(color: currentColor, difficulty: 'easy',))),
              TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold, ),
              EdgeInsets.fromLTRB(26.0, 27.0, 26.0, 25.0)
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new TextButton("Normal",
              () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new PlayGamePage(color: currentColor, difficulty: 'normal',)), (Route route) => route == null),
              TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold, ),
              EdgeInsets.all(25.0)
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new TextButton("Hard",
              () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new PlayGamePage(color: currentColor, difficulty: 'hard',)), (Route route) => route == null),
              TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold, ),
              EdgeInsets.all(25.0)
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new TextButton("Back",
              () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null),
              TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold, ),
              EdgeInsets.all(25.0)
            ),
          ),
        ],
      ),
    );
  }
}