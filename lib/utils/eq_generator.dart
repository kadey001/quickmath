import 'dart:math';

/* Class creates an equation from random values.
  
  For eqType: 0 = Multiplication, 1 = Division, 2 = Addition, 3 = Subtraction.
  
  Eq layout: x eqType y = z
 */

List generateEq() {
  int _xMax, _xMin = 1;
  const int _zMin = 1;
  const int _zMax = 400;

  double returnValue;
  int _x = 0;
  double _y = 0.0;
  int _z = _zMin + (Random().nextInt(_zMax - _zMin));

  double mult(_z, bool firstRun) {
    
    if(firstRun == true){
      _xMax = _z;
      _x = _xMin + (Random().nextInt(_xMax - _xMin));
    }
    if(_z.toDouble() % _x.toDouble() == 0) {
      returnValue = (_z.toDouble() / _x.toDouble());
      //return returnValue;
    }
    else {
      --_x;
      firstRun = false;
      mult(_z, firstRun);
    }
    return returnValue;
  }

  void div(int _z) {
    //TODO
  }

  void add(int _z) {
    _xMax = _z;
    _x = _xMin + (Random().nextInt(_xMax - _xMin));
    _y = (_z.toDouble() - _x.toDouble());
  }

  double sub(int _z) {
    _xMin = _z;
    _xMax = 800;
    _x = _xMin + (Random(1).nextInt(_xMax - _xMin));
    return (_x.toDouble() - _z.toDouble());
  }  

  int eqType = Random().nextInt(3);
  bool firstRun = true;

  if(eqType == 0) {
    _y = mult(_z, firstRun);
  }
  if(eqType == 1) {
    add(_z);
  }
  if(eqType == 2) {
    add(_z);
  }
  if(eqType == 3) {
    _y = sub(_z);
  }

  List<int> _equation = [_x, eqType, _y.toInt(), _z];

  return _equation;
}