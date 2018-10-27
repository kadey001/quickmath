import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Score {
  int score = 0;

  DocumentReference reference;

  Score.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['score'] != null),
      score = map['score'];

  Score.fromSnapshot(DataSnapshot snapshot) {
    score = snapshot.value['score'];
  }

  @override
  String toString() => "Score<$score>";

  Score(this.score);

  int get getScore => score;
  set addScore(int value) => score += value;
  set setScore(int value) => score = value;
}