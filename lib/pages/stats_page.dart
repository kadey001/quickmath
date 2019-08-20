import 'package:flutter/material.dart';
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
    final double deviceWidth = MediaQuery.of(context).size.shortestSide;
    final double deviceHeight = MediaQuery.of(context).size.longestSide;
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