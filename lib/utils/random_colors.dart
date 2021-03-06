import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quickmath/main.dart';

final int maxColor = 7;

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
    Color newColor = colors[new Random().nextInt(maxColor)];
    while(newColor == previousColor) { 
      newColor = colors[new Random().nextInt(maxColor)];
    }
    return newColor;
  }
  return colors[new Random().nextInt(maxColor)];
}

//Using customColor makes the text that color when using the dark color theme.
Color themeTextColor([Color customColor]) {
  if(customColor != null) {
    return theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? customColor : Colors.white;
  }
  return theme == 'rainbow' ? Colors.white : theme == 'darkColorText' ? colors[new Random().nextInt(maxColor)] : Colors.white;
}