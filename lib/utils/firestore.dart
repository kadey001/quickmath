import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  //Get current user's high score
  Future<int> getHighScore() async {
    int currentHighScore;
    FirebaseUser user = await authService.currentUser();
    DocumentReference docRef = _db.collection('users').document(user.uid);
    docRef.get().then((DocumentSnapshot ds) => {
      currentHighScore = ds["highScore"]
    }).catchError((e) => {
      print(e.toString())
    });
    return currentHighScore;
  }

  //Adds a new high score to list
  void newHighScore(int score) async {
    int currentHighScore = 0;
    FirebaseUser user = await authService.currentUser();
    DocumentReference docRef = _db.collection('users').document(user.uid);
    docRef.get().then((DocumentSnapshot ds) => {
      currentHighScore = ds["highScore"]
    }).catchError((e) => {
      print(e.toString())
    });

    //Updates high score in database if the new score is higher
    if(score > currentHighScore) {
      await docRef.updateData({ 'highScore' : score });
    } else {
      //Nothing as the high score will stay the same
    }
    return;
  }
}
//Initialize the class
final FirestoreService firestoreService = FirestoreService();