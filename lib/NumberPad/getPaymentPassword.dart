import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// String getPaymentPassword() {
//  final String documentId;
//
//   getPaymentPassword({required this.documentId});
//
//     CollectionReference users = FirebaseFirestore.instance.collection('userProfile');
//
//     FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder: ((context, snapshot){
//         if (snapshot.connectionState == ConnectionState.done){
//           Map<String, dynamic> data =
//           snapshot.data!.data() as Map <String, dynamic>;
//           print(data);
//           return data["paymentPassword"];
//         }
//         return 'error';
//       }),
//     );
//   }

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<String> getPaymentPassword(String s) async {
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  await firestore.collection('userProfile').doc('paymentPassword').get();

  if (documentSnapshot.exists) {
    // Access the field value using the [] operator
    return documentSnapshot['paymentPassword'];
  } else {
    return 'Document does not exist';
  }
}