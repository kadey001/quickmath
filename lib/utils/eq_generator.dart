import 'dart:math';

/* Class creates an equation from random values.
  
  For eqType: 0 = Multiplication, 1 = Division, 2 = Addition, 3 = Subtraction.
  
  Eq layout: x eqType y = z
 */

List generateEq(String difficulty) {
  String eqTypeString;
  int multMaxZ, multMinX, multMinZ, addMinX, addMinZ, addMaxZ, subMaxX, subMin, divMinZ, divMaxZ, divMinY, divMaxY;
  final int eqType = Random().nextInt(4);
  bool firstRun = true;
  
  //TODO: Balance difficulties
  if(difficulty == 'easy') {
    multMaxZ = 30;
    multMinZ = 1;
    multMinX = 1;

    subMaxX = 13;
    subMin = 10;

    divMaxZ = 10;
    divMinZ = 1; 
    divMaxY = 10;
    divMinY = 2;
    
    addMaxZ = 30;
    addMinZ = 6;
    addMinX = 1;
  }
  else if(difficulty == 'normal') {
    multMaxZ = 30;
    multMinZ = 1;
    multMinX = 1;

    subMaxX = 13;
    subMin = 10;

    divMaxZ = 10;
    divMinZ = 1; 
    divMaxY = 10;
    divMinY = 2;
    
    addMaxZ = 30;
    addMinZ = 6;
    addMinX = 1;
  } 
  else if(difficulty == 'hard') {
    multMaxZ = 30;
    multMinZ = 1;
    multMinX = 1;

    subMaxX = 13;
    subMin = 10;

    divMaxZ = 10;
    divMinZ = 1; 
    divMaxY = 10;
    divMinY = 2;
    
    addMaxZ = 30;
    addMinZ = 6;
    addMinX = 1;
  }
  else {
    
  }

  int _x = 0;
  double _y = 0.0;
  int _z = 0;

  void mult(bool firstRun) {
    if (firstRun == true) {
      _z = multMinZ + Random().nextInt(multMaxZ);
      _x = multMinX + Random().nextInt(_z);
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
    _z = divMinZ + Random().nextInt(divMaxZ);
    _y = divMinY + Random().nextInt(divMaxY).toDouble();
    _x = _z * _y.toInt();
  }

  void add() {
    _z = addMinZ + Random().nextInt(addMaxZ);
    _x = addMinX + 1 + Random().nextInt(_z - 2);
    _y = _z.toDouble() - _x.toDouble();
  }

  void sub() {
    _z = 1 + Random().nextInt(subMin);
    _x = subMin + 1 + Random().nextInt(subMaxX);
    _y = (_x.toDouble() - _z.toDouble());
  }

  

  if(eqType == 0) {
    try {
      mult(firstRun);
    } catch (e) {
      print(e.toString());
    }
    
    eqTypeString = "*";
  }
  else if(eqType == 1) {
    div();
    eqTypeString = "/";
  }
  else if(eqType == 2) {
    try {
      add();
    } catch (e) {
      print(e.toString());
    }
    add();
    eqTypeString = "+";
  }
  else {
    sub();
    eqTypeString = "-";
  }

  List _equation = [_x, eqTypeString, _y.toInt(), _z];

  //print(_equation);

  return _equation;
}