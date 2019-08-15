import 'firestore.dart';

class Score {
  int score = 0;

  

  @override
  String toString() => "Score<$score>";

  Score(this.score);

  int get getScore => score;
  set addScore(int value) => score += value;
  set setScore(int value) => score = value;
}