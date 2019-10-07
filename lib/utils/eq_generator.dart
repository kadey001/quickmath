import 'dart:math';

/* Class creates an equation from random values.
  
  For eqType: 0 = Multiplication, 1 = Division, 2 = Addition, 3 = Subtraction.
  
  Eq layout: A eqType B = C
 */

List generateEq(String difficulty) {
  String eqTypeString;
  int multMaxC, multMinA, multMinC, addMinA, addMinC, addMaxC, subMaxA, subMinA, subMinC, subMin, divMinC, divMaxC, divMinB, divMaxB;
  final int eqType = Random().nextInt(4);
  bool firstRun = true;
  
  //TODO: Balance difficulties
  if(difficulty == 'easy') {
    multMaxC = 30;
    multMinC = 1;
    multMinA = 1;

    subMaxA = 80;
    subMinA = 1;
    subMinC = 1;
    subMin = 20;

    divMaxC = 10;
    divMinC = 1; 
    divMaxB = 10;
    divMinB = 2;
    
    addMaxC = 100;
    addMinC = 10;
    addMinA = 1;
  }
  else if(difficulty == 'normal') {
    multMaxC = 30;
    multMinC = 1;
    multMinA = 1;

    subMaxA = 900;
    subMinA = 10;
    subMinC = 10;
    subMin = 100;

    divMaxC = 10;
    divMinC = 1; 
    divMaxB = 10;
    divMinB = 2;
    
    addMaxC = 1000;
    addMinC = 100;
    addMinA = 10;
  } 
  else if(difficulty == 'hard') {
    multMaxC = 30;
    multMinC = 1;
    multMinA = 1;

    subMaxA = 9000;
    subMinA = 100;
    subMinC = 100;
    subMin = 1000;

    divMaxC = 10;
    divMinC = 1; 
    divMaxB = 10;
    divMinB = 2;
    
    addMaxC = 10000;
    addMinC = 1000;
    addMinA = 100;
  }

  int _a = 0;
  double _b = 0.0;
  int _c = 0;

  void mult(bool firstRun) {
    if (firstRun == true) {
      _c = multMinC + Random().nextInt(multMaxC);
      _a = multMinA + Random().nextInt(_c);
    }
    if (_c.toDouble() % _a.toDouble() == 0) {
      _b = (_c.toDouble() / _a.toDouble());
    } else {
      --_a;
      firstRun = false;
      mult(firstRun);
    }
  }

  void div() {
    _c = divMinC + Random().nextInt(divMaxC);
    _b = divMinB + Random().nextInt(divMaxB).toDouble();
    _a = _c * _b.toInt();
  }

  void add() {
    _c = addMinC + Random().nextInt(addMaxC);
    _a = addMinA + 1 + Random().nextInt(_c - 2);
    _b = _c.toDouble() - _a.toDouble();
  }

  void sub() {
    _c = subMinC + Random().nextInt(subMin);
    _a = subMin + subMinA + Random().nextInt(subMaxA);
    _b = (_a.toDouble() - _c.toDouble());
  }

  //Checking for equation type
  switch(eqType) {
    case 0:
      try {
        mult(firstRun);
      } catch(e) {
        print(e.toString());
      }
      eqTypeString = "*";
      break;
    case 1:
      try {
        div();
      } catch(e) {
        print(e.toString());
      }
      eqTypeString = "/";
      break;
    case 2:
      try {
        add();
      } catch(e) {
        print(e.toString());
      }
      eqTypeString = "+";
      break;
    default:
      try {
        sub();
      } catch(e) {
        print(e.toString());
      }
      eqTypeString = "-";
  }
  //Return the equation in the form of a list
  List _equation = [_a, eqTypeString, _b.toInt(), _c];
  return _equation;
}