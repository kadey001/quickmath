import 'package:flutter/material.dart';

import 'home_page.dart';

import '../utils/random_colors.dart';
import '../utils/button.dart';
import '../utils/eq_generator.dart';

//List<int> inputNum = [];

class PlayPage extends StatefulWidget {
  
  
  @override
  State createState() => new PlayPageState();
}

class PlayPageState extends State<PlayPage> {
  int gameTimer = 60; //Default timer 60 seconds
  List equation = generateEq();
  List<int> inputNum = [];
  bool nextQuestion = true;

  Color currentColor = randomColorGen();

  void numberInput(int x) {
    nextQuestion = false;
    if(x == 10) {
      //Clear Numbers from answer box or remove last????
      inputNum.removeLast();
      print(inputNum);
      this.setState(() {});
    }
    else if(inputNum.length >= 3) {
      return;
    }
    else{
      inputNum.add(x);
      print(inputNum);
      this.setState(() {});
      print(currentColor);
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
  }

  String problemType(int type) {
    switch (type) {
      case 0: return " * ";
      case 1: return " / ";
      case 2: return " + ";
      case 3: return " - ";
    }
  }

  void handleAnswer(int userAnswer, int answer) {
    userAnswer == answer ? print("Correct!") : print("Wrong!");
    equation.clear();
    equation = generateEq();
    inputNum.clear();
    nextQuestion = true;
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: nextQuestion == true ? randomColorGen() : currentColor,
      body: new Column(
        children: <Widget>[
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                  alignment: Alignment.centerLeft,
                  padding: new EdgeInsets.fromLTRB(0.0, 30.0, 160.0, 25.0),
                  icon: new Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () { 
                    inputNum.clear();
                    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomePage()), (Route route) => route == null);
                  }
                ),
                new Text("Timer: ",
                  style: new TextStyle(
                    color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold,
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(80.0)
                  ),
                  alignment: Alignment.topRight,
                  child: new Text(gameTimer.toString(), 
                    style: new TextStyle(
                      color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ),
          //Question Box
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Material(
                  color: Color.fromRGBO(0, 0, 0, 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.symmetric(vertical: 20.0),
                    child: new Center(  
                      child: new Text(equation[0].toString() + problemType(equation[1]) + equation[2].toString() + " = ", style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),)
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
                        child: new Text(inputNum.isEmpty ? "   " : listToInt(inputNum).toString(), style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),)
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Buttons Row 1
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextButton("1", 
                () => numberInput(1), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("2", 
                () => numberInput(2), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("3", 
                () => numberInput(3), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
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
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("5", 
                () => numberInput(5), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("6", 
                () => numberInput(6), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
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
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("8", 
                () => numberInput(8), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("9", 
                () => numberInput(9), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
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
                new TextButton("<-", 
                () => numberInput(10), 
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("0", 
                () => numberInput(0), 
                TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold) 
                ),
                new TextButton("->", 
                () => handleAnswer(listToInt(inputNum), equation[3]),
                TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold) 
                ),
              ],
            ),
          ),
        ],
      ),  
    );
  }
}