import 'package:flutter/material.dart';
import 'dart:math';

final List colors = [Colors.blueAccent, 
  Colors.greenAccent[400], 
  Colors.deepPurpleAccent, 
  Colors.redAccent, 
  Colors.orangeAccent[400],
  Colors.blueAccent,
  Colors.cyan,
  Colors.pinkAccent
  ];

Color randomColorGen() {
  return colors[new Random().nextInt(8)];
}

//Makes sure that background color doesn't repeat
Color randomColorGenCheck(Color previousColor) {
  Color newColor = colors[new Random().nextInt(8)];
  while(newColor == previousColor) { 
    newColor = colors[new Random().nextInt(8)];
  }
  return newColor;
}