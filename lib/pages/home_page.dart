import 'package:flutter/material.dart';
import 'package:quickmath/main.dart';

import './highscores_page.dart';
import './mode_select_page.dart';
import './settings_page.dart';
import './stats_page.dart';

import '../utils/button.dart';
import '../utils/random_colors.dart';
import '../utils/auth.dart';

class HomePage extends StatefulWidget {
  static final String route = "home-page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color currentColor;
  MediaQueryData queryData;
  double aspectRatio, textScale;
  //String theme;

  @override
  void initState() {
    super.initState();
    currentColor = randomColorGen();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    queryData = MediaQuery.of(context);
    textScale = queryData.textScaleFactor;
    aspectRatio = queryData.devicePixelRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme == 'dark' ? Colors.black : theme == 'darkColorText' ? Colors.black : currentColor,
      body: InkWell(
        onTap: () => changeColor(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 8.0)
                ),
                padding: EdgeInsets.all(20.0),
                child: Text("Quick Math", style: TextStyle(color: themeTextColor(), fontSize: 50.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('')
              ),
              TextButton(
                "Play", 
                () => Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  ModeSelectPage(color: currentColor))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
              TextButton(
                "High Scores", 
                () => Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  HighScoresPage(color: currentColor,))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
               TextButton(
                "Stats", 
                () => Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  StatsPage(color: currentColor,))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
               TextButton(
                "Settings", 
                () => Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  SettingsPage(color: currentColor,))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
            ],
          ),
        ), 
      ),
    );
  }

  void changeColor() {
    setState(() {
      currentColor = randomColorGen(currentColor);
    });
  }
}