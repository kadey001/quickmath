import 'package:flutter/material.dart';
import 'dart:math';

final List colors = [
  Colors.blueAccent, 
  Colors.greenAccent[700], 
  Colors.deepPurpleAccent, 
  Colors.redAccent, 
  Colors.deepOrangeAccent,
  Colors.cyan,
  Colors.pinkAccent
  ];

Color randomColorGen([Color previousColor]) {
  if(previousColor != null) {
    Color newColor = colors[new Random().nextInt(7)];
    while(newColor == previousColor) { 
      newColor = colors[new Random().nextInt(7)];
    }
    return newColor;
  }
  return colors[new Random().nextInt(7)];
}