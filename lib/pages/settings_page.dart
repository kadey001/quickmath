import 'package:flutter/material.dart';
import 'package:quickmath/main.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';
import '../utils/auth.dart';
import '../utils/firestore.dart';

class SettingsPage extends StatefulWidget {
  final Color color;
  SettingsPage({Key key, @required this.color}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState(previousColor: color);
}

class _SettingsPageState extends State<SettingsPage> {
  final Color previousColor;
  Color currentColor;
  _SettingsPageState({Key key, @required this.previousColor});

  void initState() {
    super.initState();
    currentColor = randomColorGen(previousColor);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme == 'rainbow' ? currentColor : Colors.black,
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
                          iconSize: 50.0,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton("Dark Mode",
                    () => updateTheme('dark'),
                    TextStyle(color: themeTextColor(), fontSize: 30.0, fontWeight: FontWeight.bold, ),
                    EdgeInsets.all(15.0)
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton("Dark & Color Text",
                    () => updateTheme('darkColorText'),
                    TextStyle(color: themeTextColor(), fontSize: 30.0, fontWeight: FontWeight.bold, ),
                    EdgeInsets.all(15.0)
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton("Rainbow Mode",
                    () => updateTheme('rainbow'),
                    TextStyle(color: themeTextColor(), fontSize: 30.0, fontWeight: FontWeight.bold, ),
                    EdgeInsets.all(15.0)
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton("Sign Out",
                    () => authService.signOut(context),
                    TextStyle(color: themeTextColor(), fontSize: 30.0, fontWeight: FontWeight.bold, ),
                    EdgeInsets.all(15.0)
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

  void updateTheme(String newTheme) {
    setState(() {
      theme = newTheme;
    });
  }
}