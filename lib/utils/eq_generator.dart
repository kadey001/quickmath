import 'dart:math';

/* Class creates an equation from random values.
  
  For eqType: 0 = Multiplication, 1 = Division, 2 = Addition, 3 = Subtraction.
  
  Eq layout: x eqType y = z
 */

List generateEq() {
  int _xMax, _xMin = 1;
  const int _zMin = 1;
  const int _zMax = 100;

  int _x = 0;
  double _y = 0.0;
  int _z = _zMin + (Random().nextInt(_zMax - _zMin));

  void mult(bool firstRun) {
    if (firstRun == true) {
      _xMax = _z;
      _x = _xMin + (Random().nextInt(_xMax - _xMin));
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
    int z = 1 + Random().nextInt(21);
    _z = z;
    _y = 2 + Random().nextInt(11).toDouble();
    _x = _z * _y.toInt();
  }

  void add() {
    _xMax = _z;
    _x = _xMin + (Random().nextInt(_xMax - _xMin));
    _y = (_z.toDouble() - _x.toDouble());
  }

  void sub() {
    _xMin = _z;
    _xMax = 100;
    _x = _xMin + (Random().nextInt(_xMax - _xMin));
    _y = (_x.toDouble() - _z.toDouble());
  }

  int eqType = Random().nextInt(4);
  bool firstRun = true;

  eqType == 0
      ? mult(firstRun)
      : eqType == 1 ? div() : eqType == 2 ? add() : sub();

  List<int> _equation = [_x, eqType, _y.toInt(), _z];

  print(_equation);

  return _equation;
}