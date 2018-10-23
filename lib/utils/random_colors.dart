import 'package:flutter/material.dart';
import 'dart:math';

final List colors = [Colors.blueAccent, 
  Colors.greenAccent, 
  Colors.deepPurpleAccent, 
  Colors.redAccent, 
  Colors.orangeAccent,
  Colors.amberAccent,
  Colors.cyanAccent,
  Colors.pinkAccent
  ];

Color randomColorGen() {
  return colors[new Random().nextInt(5)];
}