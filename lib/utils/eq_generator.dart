import 'dart:math';

/* Class creates an equation from random values.
  
  For eqType: 0 = Multiplication, 1 = Division, 2 = Addition, 3 = Subtraction.
  
  Eq layout: A eqType B = C
 */

List generateEq(String difficulty) {
  String eqTypeString;
  int multMaxC, multMinA, multMinC, addMinA, addMinC, addMaxC, subMaxA, subMin, divMinC, divMaxC, divMinB, divMaxB;
  final int eqType = Random().nextInt(4);
  bool firstRun = true;
  
  //TODO: Balance difficulties
  if(difficulty == 'easy') {
    multMaxC = 30;
    multMinC = 1;
    multMinA = 1;

    subMaxA = 13;
    subMin = 10;

    divMaxC = 10;
    divMinC = 1; 
    divMaxB = 10;
    divMinB = 2;
    
    addMaxC = 30;
    addMinC = 6;
    addMinA = 1;
  }
  else if(difficulty == 'normal') {
    multMaxC = 30;
    multMinC = 1;
    multMinA = 1;

    subMaxA = 13;
    subMin = 10;

    divMaxC = 10;
    divMinC = 1; 
    divMaxB = 10;
    divMinB = 2;
    
    addMaxC = 30;
    addMinC = 6;
    addMinA = 1;
  } 
  else if(difficulty == 'hard') {
    multMaxC = 30;
    multMinC = 1;
    multMinA = 1;

    subMaxA = 13;
    subMin = 10;

    divMaxC = 10;
    divMinC = 1; 
    divMaxB = 10;
    divMinB = 2;
    
    addMaxC = 30;
    addMinC = 6;
    addMinA = 1;
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
    _c = 1 + Random().nextInt(subMin);
    _a = subMin + 1 + Random().nextInt(subMaxA);
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
      div();
      eqTypeString = "/";
      break;
    case 2:
      try {
        add();
      } catch(e) {
        print(e.toString());
      }
      add();
      eqTypeString = "+";
      break;
    default:
      sub();
      eqTypeString = "-";
  }
  //Return the equation in the form of a list
  List _equation = [_a, eqTypeString, _b.toInt(), _c];
  return _equation;
}