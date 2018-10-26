class Score {
  //final String key;
  int _score;

  Score(this._score);

  int get score => _score;
  set addScore(int value) => _score += value;
  set setScore(int value) => _score = value;

  // Score.fromJson(this.key, Map data) {
  //   _score = data['score'];
  // }
}