/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Page/HomePage.dart';

class UserManagement{
  storeNewUser(user, context) async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
      .collection('userProfile')
      .doc(firebaseuser?.uid)
      .set({'email': user.email, 'userUID':user.userUID})
      .then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage())))
      .catchError((e) {
        print(e);
    });
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget{

  final String documentId;

  GetUserName({required this.documentId});

  @override
  Widget build (BuildContext context){

    CollectionReference users = FirebaseFirestore.instance.collection('userProfile');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data =
                snapshot.data!.data() as Map <String, dynamic>;
            return Text(data["username"], style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),);
          }
          return Text ("Loading");
        }),
    );
  }
}