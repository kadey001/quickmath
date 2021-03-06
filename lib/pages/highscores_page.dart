import 'package:flutter/material.dart';
import 'package:quickmath/main.dart';

import '../utils/button.dart';
import '../utils/random_colors.dart';
import '../utils/firestore.dart';

class HighScoresPage extends StatefulWidget {
  final Color color;
  HighScoresPage({Key key, @required this.color}) : super(key: key);
  @override
  _HighScoresPageState createState() => _HighScoresPageState(previousColor: color);
}

class _HighScoresPageState extends State<HighScoresPage> {
  final Color previousColor;
  Color currentColor;
  _HighScoresPageState({Key key, @required this.previousColor});

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
                FutureBuilder(
                  future: firestoreService.getHighScores(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      print(snapshot.error.toString());
                      return snapshot.error;
                    } else if(snapshot.connectionState == ConnectionState.done) {
                      return snapshot.hasData ? new Container(
                        alignment: Alignment.center,
                        child: Text(snapshot.data.easyHighScore),
                      ) : new CircularProgressIndicator();
                    } else {
                      return Text("");
                    }
                  },
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