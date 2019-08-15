import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickmath/main.dart';

import 'login_page.dart';

import './highscores_page.dart';
import './mode_select_page.dart';
import './settings_page.dart';
import './stats_page.dart';

import '../utils/button.dart';
import '../utils/random_colors.dart';

class HomePage extends StatefulWidget {
  static final String route = "home-page";
  final FirebaseUser user;
  final Firestore firestore;
  HomePage({this.firestore, this.user});
  
  _HomePageState createState() => _HomePageState(firestore: firestore, user: user);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({this.firestore, this.user});
  final FirebaseUser user;
  final Firestore firestore;
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
    StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final List<DocumentSnapshot> documents = snapshot.data.documents;
        String username = documents[0].data['username'].toString();
        print(username);
        //return FirestoreListView(documents: snapshot.data.documents);
      },
    );

    return Scaffold(
      backgroundColor: theme == 'dark' ? Colors.black : theme == 'darkColorText' ? Colors.black : currentColor,
      body: InkWell(
        onTap: () => changeColor(),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                  border: new Border.all(color: Colors.white, width: 8.0)
                ),
                padding: new EdgeInsets.all(20.0),
                child: new Text("Quick Math", style: TextStyle(color: themeTextColor(), fontSize: 50.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
              ),
              new Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: new Text('')
              ),
              new TextButton(
                "Play", 
                () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ModeSelectPage(color: currentColor))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
              new TextButton(
                "High Scores", 
                () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HighScoresPage(color: currentColor,))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
              new TextButton(
                "Stats", 
                () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new StatsPage(color: currentColor,))), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.all(20.0)
              ),
              new TextButton(
                "Settings", 
                () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SettingsPage(color: currentColor,))), 
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