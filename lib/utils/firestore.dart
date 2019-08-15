import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get list of current user's highscores
  Future<List> getHighScores() async {

  }

  //Adds a new highscore to list
  void newHighScore(int score) async {

  }
}