import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class getBankBalance extends StatelessWidget{

  final String documentId;

  getBankBalance({required this.documentId});

  @override
  Widget build (BuildContext context){

    CollectionReference users = FirebaseFirestore.instance.collection('userProfile');
    // print(documentId);
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          Map<dynamic, dynamic> data =
          snapshot.data!.data() as Map <dynamic, dynamic>;
          print('data');
          return Text(data["bankBalance"], style:  TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            ),
          );
        }
        return Text ("Loading", style:  TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          ),
        );
      }),
    );
  }
}