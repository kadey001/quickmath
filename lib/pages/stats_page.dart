import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quickmath/main.dart';

import '../utils/button.dart';
import '../utils/random_colors.dart';


class StatsPage extends StatefulWidget {
  final Color color;
  StatsPage({Key key, @required this.color}) : super(key: key);
  @override
  _StatsPageState createState() => _StatsPageState(previousColor: color);
}

class _StatsPageState extends State<StatsPage> {
  final Color previousColor;
  Color currentColor;
  _StatsPageState({Key key, @required this.previousColor});

  void initState() {
    super.initState();
    currentColor = randomColorGen(previousColor);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme == 'dark' ? Colors.black : theme == 'darkColorText' ? Colors.black : currentColor,
      body: InkWell(
        onTap: () => changeColor(),
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalDirection: VerticalDirection.up,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white,),
                          iconSize: 70.0,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton("TEST",
                    () => changeColor(),
                    TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold, ),
                    EdgeInsets.all(25.0)
                  ),
                ),
              ],
            ),
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