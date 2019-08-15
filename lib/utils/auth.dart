import 'dart:async';
import 'package:flutter/material.dart';
import '../pages/login_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:play_games/play_games.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user; //Firebase user
  Observable<Map<String, dynamic>> profile; //Custom user data in Firestore
  Account account;
  PublishSubject loading = PublishSubject();

  //Constructor
  AuthService() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser user) {
      if(user != null) {
        return _db.collection('users').document(user.uid).snapshots().map((snap) => snap.data);
      } else {
        return Observable.just({ });
      }
    });
  }

  //Sign in with Google
  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    updateUserData(user);
    print("Signed in " + user.displayName);

    loading.add(false);
    return user;
  }
  
  //Sign in anonymously
  Future<FirebaseUser> anonSignIn() async {
    FirebaseUser user = (await _auth.signInAnonymously()).user;

    updateUserDataAnon(user);
    print("Signed in ${user.uid}");
    return user;
  }

  //TODO: Play Games Signin
  void playGamesSiginIn() async {
    loading.add(true);
    SigninResult result = await PlayGames.signIn();
    if(result.success) {
      await PlayGames.setPopupOptions();
      this.account = result.account;
    } else {
      print(result.message);
    }
    loading.add(false);
  }

  //Updates Firestore with user information
  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  //Updates Firestore with basic data for Anon users
  void updateUserDataAnon(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  //Signs out the user and returns them to the Login Page
  void signOut(context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  //Returns the current logged in FirebaseUser
  Future<FirebaseUser> currentUser() async {
    return await _auth.currentUser();
  }

  //Returns true if user currently signed in
  Future<bool> signInStatus() async {
    FirebaseUser currentUser = await _auth.currentUser();
    return currentUser != null ? true : false;
  }
}

final AuthService authService = AuthService();