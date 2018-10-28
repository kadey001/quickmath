import 'package:flutter/material.dart';

import './home_page.dart';

import '../utils/random_colors.dart';

class SettingsPage extends StatelessWidget {
  final Color previousColor;
  SettingsPage({Key key, @required this.previousColor});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: randomColorGen(previousColor),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              )
            ],
          )
        ),
      ),
    );
  }
}