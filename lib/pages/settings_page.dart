import 'package:flutter/material.dart';

import './home_page.dart';

import '../utils/random_colors.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: randomColorGen(),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 75.0,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null),
            ),
          ],
        )
      ),
    );
  }
}