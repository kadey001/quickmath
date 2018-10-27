import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../utils/score.dart';

class Test extends StatefulWidget {
  @override
  State createState() => TestState();
}

class TestState extends State<Test> {
  final DatabaseReference database = FirebaseDatabase.instance.reference().child('users');
  DatabaseReference _messageRef;
  int score = 0;

  sendData() {
    database.set({
      'score': 100 + score,
      'name' : 'Cuck'
    });
    score += 100;
    database.reference().child('score').once().then((DataSnapshot snapshot) {
      print('Value: ${snapshot.value}');
    });
  }

  @override
  void initState(){
    super.initState();
    _messageRef = database.reference().child('name');
    // database.reference().child('score').once().then((DataSnapshot snapshot) {
    //   print('Value: ${snapshot.value}');
    // });
      
  }

  // Future<DatabaseReference> getCurrentUserRef() async {
  //   return database.reference().child('users'); 
  // }

  // readData() async {
  //   var reference = await getCurrentUserRef();
  //   DocumentSnapshot user = await reference.get();
  //   print(user.data.toString());
  // }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () => sendData(),
            child: Text("Send Data"),
          ),
          //Text("Score: ${snapshot.value}"),
        ]
      )
    );
  }
}