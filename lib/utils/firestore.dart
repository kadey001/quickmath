import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;
  FirebaseUser user;

  //Returns a map of easy, normal, and hard highscores
  Future<Map> getHighScores() async {
    Map currentHighScores = {"easyHighScore" : 1, "normalHighScore" : 1, "hardHighScore" : 1};
    user = await authService.currentUser();
    DocumentReference docRef = _db.collection('users').document(user.uid);
    await docRef.get().then((DocumentSnapshot ds) => {
      currentHighScores = ds["highScores"]
    }).catchError((e) => {
      print(e.toString())
    });

    return currentHighScores;
  }

  //Adds a new high score based on difficulty and returns coriosponding highscore
  Future<int> updateHighScores(int score, String difficulty) async {
    FirebaseUser user = await authService.currentUser();
    DocumentReference docRef = _db.collection('users').document(user.uid);
    Map currentHighScores = await getHighScores();

    //Updates high score in database if the new score is higher
    switch(difficulty) {
      case "easy":
        int easyHighScore = currentHighScores["easyHighScore"];
        if(score > easyHighScore) {
          await docRef.updateData({ 'highScores.easyHighScore' : score });
          return score;
        }
        return easyHighScore;
      case "normal":
        int normalHighScore = currentHighScores["normalHighScore"];
        if(score > normalHighScore) {
          await docRef.updateData({ 'highScores.normalHighScore' : score });
          return score;
        }
        return normalHighScore;
      case "hard":
        int hardHighScore = currentHighScores["hardHighScore"];
        if(score > hardHighScore) {
          await docRef.updateData({ 'highScores.hardHighScore' : score });
          return score;
        }
        return hardHighScore;
      default:
        //1 is impossible score to get so if highScore is 1 then there is an error
        return 1;
    }
  }
}
//Initialize the class
final FirestoreService firestoreService = FirestoreService();