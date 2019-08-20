import 'package:flutter/material.dart';
import 'package:quickmath/main.dart';

import '../pages/end_page.dart';

import '../UI/countdown.dart';

import '../utils/eq_generator.dart';
import '../utils/random_colors.dart';
import '../utils/button.dart';

class PlayGamePage extends StatefulWidget {
  final Color color;
  final String difficulty;
  PlayGamePage({Key key, @required this.color, @required this.difficulty}) : super(key: key);
  @override
  State createState() => new PlayGamePageState(previousColor: color, difficulty: difficulty);
}

class PlayGamePageState extends State<PlayGamePage> with TickerProviderStateMixin{
  Color currentColor, previousColor;
  final String difficulty;
  PlayGamePageState({Key key, @required this.previousColor, @required this.difficulty});
  MediaQueryData queryData;
  double pixelRatio, textScale;
  int _score, firstNumber, secondNumber, userAnswer;
  String questionType;
  List question;
  List<int> answerList;
  
  AnimationController _controller;
  static const gameTimerStart = 60;

  //TODO: Add a countdown timer before game starts
  //TODO: Remove score for wrong answer (changes depending on difficulty)

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: gameTimerStart)
    );
    _controller.forward();

    currentColor = randomColorGen(previousColor);
    previousColor = currentColor;
    _score = 0;
    question = generateEq(difficulty);
    firstNumber = question[0];
    questionType = question[1];
    secondNumber = question[2];
    answerList = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    queryData = MediaQuery.of(context);
    textScale = queryData.textScaleFactor;
    pixelRatio = queryData.devicePixelRatio;
  }

  @override
  Widget build(BuildContext context) {
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
            builder: (BuildContext context) => new EndPage(score: _score, difficulty: difficulty, color: currentColor,)), 
          (Route route) => route == null);
      }
    });
    //Device size variables
    final double deviceWidth = MediaQuery.of(context).size.shortestSide;
    final double deviceHeight = MediaQuery.of(context).size.longestSide;
    final bool smallDevice = (deviceHeight < 600.0);
    final double buttonHeight = deviceHeight * .025;
    final double buttonWidth = deviceHeight * .025;
    final double textFontSize = smallDevice ? 40 : 50;
    final TextStyle buttonTextStyle = smallDevice ? TextStyle(color: Colors.white, fontSize: 40.0,) : TextStyle(color: Colors.white, fontSize: 50.0,);
    return Scaffold(
      backgroundColor: theme == 'dark' ? Colors.black : theme == 'darkColorText' ? Colors.black : currentColor,
      body: SafeArea(
        child: Center(
          //aspectRatio: aspectRatio ?? 100/100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //SCORE & TIME ROW
              Container(
                color: Colors.black.withOpacity(.25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Score: $_score", style: TextStyle(color: themeTextColor(), fontSize: smallDevice ? 20.0 : 30.0,)),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text("Time: ", style: TextStyle(color: themeTextColor(), fontSize: smallDevice ? 20.0 : 30.0,)),
                          Countdown(//TODO: Make timer smaller on smaller devices
                            animation: new StepTween(
                              begin: gameTimerStart,
                              end: 0,
                            ).animate(_controller),
                          ),
                        ],
                      )
                    ),                   
                  ],
                ),
              ),
              //PROBLEM ROW
              Container(
                //TODO: Find a way to scale this based on screen length/size
                //padding: EdgeInsets.symmetric(vertical: deviceHeight/100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: deviceHeight * .05),
                      child: Text("$firstNumber $questionType $secondNumber =",
                        style: TextStyle(color: Colors.white, fontSize: textFontSize, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              //ANSWER BOX
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: smallDevice ? 15.0 : 30.0),
                      child: Container(
                        width: 250,
                        height: deviceHeight * .12,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: new Border.all(color: Colors.white.withOpacity(0.9), width: 4.0),
                          shape: BoxShape.rectangle,
                        ),
                        alignment: Alignment.center,
                        child: Text(answerList.isEmpty ? "" : listToInt(answerList).toString(),
                          style: TextStyle(color: Colors.white, fontSize: textFontSize + 5, fontWeight: FontWeight.bold),
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextButton("1", 
                          () => handleButtonPress(1),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("2", 
                          () => handleButtonPress(2),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("3", 
                          () => handleButtonPress(3),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextButton("4", 
                          () => handleButtonPress(4),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("5", 
                          () => handleButtonPress(5),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("6", 
                          () => handleButtonPress(6),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextButton("7", 
                          () => handleButtonPress(7),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("8", 
                          () => handleButtonPress(8),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("9", 
                          () => handleButtonPress(9),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white,),
                          iconSize: smallDevice ? 45.0 : 50.0,
                          onPressed: () => handleButtonPress(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextButton("0", 
                          () => handleButtonPress(0),
                          buttonTextStyle,
                          EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonWidth)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white,),
                          iconSize: smallDevice ? 45.0 : 50.0,
                          onPressed: () => handleAnswer(),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ), 
    );
  }

  //**HELPER FUNCTIONS**
  void handleButtonPress(int numberPressed) {
    if(numberPressed == 0 && answerList.isNotEmpty) {
      if(answerList[0] == 0) {
        return;
      }
      else {
        answerList.add(numberPressed);
        this.setState(() {});
      }
    }
    else if(numberPressed == 10) {
      if(answerList.isEmpty) {
        return;
      }
      else {
        this.setState((){
          answerList.removeLast();
        });
      }
    }
    else if (answerList.length >= 4) {
      return;
    }
    else {
      answerList.add(numberPressed);
      this.setState(() {});
    }
  }

  //Determines if answer is correct and awards score accordingly
  void handleAnswer() {
    userAnswer = listToInt(answerList) ?? 0;
    int _answer = question[3];
    if(_answer == userAnswer) {
      switch(difficulty) {
        case "easy":
          _score += 20;
          break;
        case "normal":
          _score += 50;
          break;
        case "hard":
          _score += 100;
          break;
        default:
          //Nothing
      }
    }

    this.setState(() {
      question.clear();
      answerList.clear();
      question = generateEq(difficulty);
      firstNumber = question[0];
      questionType = question[1];
      secondNumber = question[2];
      currentColor = randomColorGen(previousColor);
      previousColor = currentColor;
    });
  }

  int listToInt(List<int> toIntList) {
    int number = 0;
    int listLength = toIntList.length;

    switch(listLength) {
      case 1:
        int x = toIntList[0];
        number = x;
        return number;
      case 2:
        int x = toIntList[0];
        number = x * 10;
        x = toIntList[1];
        number = number + x;
        return number;
      case 3:
        int x = toIntList[0];
        number = x * 100;
        x = toIntList[1];
        number = number + (x * 10);
        x = toIntList[2];
        number = number + x;
        return number;
      case 4:
        int x = toIntList[0];
        number = x * 1000;
        x = toIntList[1];
        number = number + (x * 100);
        x = toIntList[2];
        number = number + (x * 10);
        x = toIntList[3];
        number = number + x;
        return number;
    }
    return 0;
  }

  @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
}