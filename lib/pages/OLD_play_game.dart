import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'home_page.dart';
import 'end_page.dart';

import '../UI/countdown.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';
import '../utils/eq_generator.dart';
//import '../utils/score.dart';

class PlayPage extends StatefulWidget {
  final Color color;
  PlayPage({Key key, @required this.color}) : super(key: key);
  @override
  State createState() => new PlayPageState(previousColor: color);
}

class PlayPageState extends State<PlayPage> with TickerProviderStateMixin {
  PlayPageState({Key key, @required this.previousColor});
  final DatabaseReference database = FirebaseDatabase.instance.reference().child('users').child('test');
  StreamSubscription<Event> _scoreSubscription;
  //DatabaseError _error;
  
  AnimationController _controller;

  static const int gameTimerStart = 60; //Default timer 60 seconds
  int score;
  List equation;
  List<int> inputNum = [];
  bool nextQuestion;
  Color currentColor, previousColor;


  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: gameTimerStart)
    );
    _controller.forward();

    equation = generateEq('normal');
    score = 0;
    currentColor = randomColorGen(previousColor);
    previousColor = currentColor;
    nextQuestion = false;

    database.set({
      'score': 0,
    });
    database.keepSynced(true);
    _scoreSubscription = database.onValue.listen((Event event) {
      setState(() {
        //_error = null;
        score = event.snapshot.value ?? 0;
      });
    });
  }

  void numberInput(int x) {
    if(x == 10) {
      if(inputNum.isEmpty){
        return;
      } 
      else{
        inputNum.removeLast();
        print(inputNum);
        this.setState(() {
          nextQuestion = false;
        });
      }
    }
    else if(inputNum.length >= 3) {
      return;
    }
    else{
      inputNum.add(x);
      print(inputNum);
      this.setState(() {
        nextQuestion = false;
      });
    }
  }

  int listToInt(List<int> toStringList) {
    int number = 0;
    int listLength = toStringList.length;

    switch(listLength) {
      case 1:
        int x = toStringList[0];
        number = x;
        return number;

      case 2:
        int x = toStringList[0];
        number = x * 10;
        x = toStringList[1];
        number = number + x;
        return number;
    
      case 3:
        int x = toStringList[0];
        number = x * 100;
        x = toStringList[1];
        number = number + (x * 10);
        x = toStringList[2];
        number = number + x;
        return number;
    }
    return 0;
  }

  String problemType(int type) {
    switch (type) {
      case 0: return " * ";
      case 1: return " / ";
      case 2: return " + ";
      case 3: return " - ";
    }
    return "ERROR";
  }

  void handleAnswer(int userAnswer, int answer) {
    if (userAnswer == answer) {
      //FIXME: Figure out a way to keep score up to date using least ammount of database download cap
      database.reference().set({
        'score': score + 100,
      });

      score += 100;
    }
    equation.clear();
    equation = generateEq('normal');
    inputNum.clear();
    this.setState(() {
      nextQuestion = true;
      currentColor = randomColorGen(previousColor);
      previousColor = currentColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new EndPage(score: score, color: currentColor,)), (Route route) => route == null);
      }
    });
    return new Scaffold(
      backgroundColor: currentColor,
      body: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 50.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text("Score: $score",
                  style: new TextStyle(
                    color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                  alignment: Alignment.centerLeft,
                  padding: new EdgeInsets.fromLTRB(0.0, 0.0, 160.0, 25.0),
                  icon: new Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () { 
                    inputNum.clear();
                    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null);
                  }
                ),
                //Countdown Timer
                new Text("Timer: ",
                  style: new TextStyle(
                    color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold,
                  ),
                ),
                new Container(
                  child: new Countdown(
                    animation: new StepTween(
                      begin: gameTimerStart,
                      end: 0,
                    ).animate(_controller),
                  ),
                ),
              ],
            )
            
          ),
          
          //Question Box
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Material(
                  color: Color.fromRGBO(0, 0, 0, 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.symmetric(vertical: 10.0),
                    child: new Center(  
                      child: new Text(equation[0].toString() + equation[1] + equation[2].toString() + " = ", style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),)
                    )
                  ),
                ),
              ],
            ),
          ),
          //Answer Box
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Material(
                  color: Color.fromRGBO(0, 0, 0, 0.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: new Border.all(color: Colors.white, width: 2.0)
                    ),
                    child: new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: new Center(
                        child: new Text(inputNum.isEmpty ? "  " : listToInt(inputNum).toString(), style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),)
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Buttons Row 1
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextButton("1", 
                () => numberInput(1), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 10.0)
                ),
                new TextButton("2", 
                () => numberInput(2), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0)
                ),
                new TextButton("3", 
                () => numberInput(3), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0)
                ),
              ],
            ),
          ),
          //Buttons Row 2
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextButton("4", 
                () => numberInput(4), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 10.0)
                ),
                new TextButton("5", 
                () => numberInput(5), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0) 
                ),
                new TextButton("6", 
                () => numberInput(6), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0) 
                ),
              ],
            ),
          ),
          //Buttons Row 3
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextButton("7", 
                () => numberInput(7), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 10.0)
                ),
                new TextButton("8", 
                () => numberInput(8), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0)
                ),
                new TextButton("9", 
                () => numberInput(9), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0)
                ),
              ],
            ),
          ),
          //Buttons Row 4
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //FIXME: Replace <- and -> with custom icons
                new TextButton("<-", 
                () => numberInput(10), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 10.0)
                ),
                new TextButton("0", 
                () => numberInput(0), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold)
                ),
                new TextButton("->", 
                () => handleAnswer(listToInt(inputNum), equation[3]),
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
    void dispose() {
      _controller.dispose();
      _scoreSubscription.cancel();
      super.dispose();
    }
}