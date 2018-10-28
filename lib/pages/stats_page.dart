import 'package:flutter/material.dart';

import './home_page.dart';

import '../utils/random_colors.dart';

import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Color currentColor;

  void initState() {
    super.initState();
    currentColor = randomColorGen();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      body: InkWell(
        onTap: () => changeColor(),
        child: Center(
          child: Column(
            children: <Widget>[],
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