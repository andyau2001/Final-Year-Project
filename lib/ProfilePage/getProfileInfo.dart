import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class getProfileInfo extends StatelessWidget{

  final String documentId;

  getProfileInfo({required this.documentId});

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
              fontSize: 18.0,
              color: Colors.grey
          ),);
        }
        return Text ("Loading");
      }),
    );
  }
}