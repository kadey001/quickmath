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

  int _x = 0;
  double _y = 0.0;
  int _z = 0;

  void mult(bool firstRun) {
    if (firstRun == true) {
      _z = multMinC + Random().nextInt(multMaxC);
      _x = multMinA + Random().nextInt(_z);
    }
    if (_z.toDouble() % _x.toDouble() == 0) {
      _y = (_z.toDouble() / _x.toDouble());
    } else {
      --_x;
      firstRun = false;
      mult(firstRun);
    }
  }

  void div() {
    _z = divMinC + Random().nextInt(divMaxC);
    _y = divMinB + Random().nextInt(divMaxB).toDouble();
    _x = _z * _y.toInt();
  }

  void add() {
    _z = addMinC + Random().nextInt(addMaxC);
    _x = addMinA + 1 + Random().nextInt(_z - 2);
    _y = _z.toDouble() - _x.toDouble();
  }

  void sub() {
    _z = 1 + Random().nextInt(subMin);
    _x = subMin + 1 + Random().nextInt(subMaxA);
    _y = (_x.toDouble() - _z.toDouble());
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
  List _equation = [_x, eqTypeString, _y.toInt(), _z];
  return _equation;
}