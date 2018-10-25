import 'package:flutter/material.dart';
import 'dart:math';

final List colors = [Colors.blueAccent, 
  Colors.greenAccent, 
  Colors.deepPurpleAccent, 
  Colors.redAccent, 
  Colors.orangeAccent,
  Colors.grey,
  Colors.cyan,
  Colors.pinkAccent
  ];

Color randomColorGen() {
  return colors[new Random().nextInt(8)];
}

Color randomColorGenCheck(Color previousColor) {
  Color newColor = colors[new Random().nextInt(8)];
  while(newColor == previousColor) { 
    newColor = colors[new Random().nextInt(8)];
  }
  return newColor;
}