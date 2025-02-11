import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_app/HomePage/recentRecord.dart';
import 'package:intl/intl.dart';



String docID = '';


Future<String?> getUsernameByUserUID(String userUID) async {
  try {
    await FirebaseFirestore.instance.collection('userProfile').get().then(
          (snapshot) =>
          snapshot.docs.forEach((document) {
            if (document.data()["userUID"] == userUID) {
              docID = document.reference.id;
            }
          }),
    );
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot userProfileSnapshot =
    await firestore.collection('userProfile').doc(docID).get();

    if (userProfileSnapshot.exists) {
      String? username = userProfileSnapshot.get('username');
      return username;
    } else {
      print('User not found');
      return null;
    }
  } catch (e) {
    print('Error fetching username: $e');
    return null;
  }
}

class getRecord extends StatelessWidget{

  final String documentId;

  getRecord({required this.documentId});

  @override
  Widget build (BuildContext context){

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('paymentRecord');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data =
          snapshot.data!.data() as Map <String, dynamic>;
          String displayName = auth.currentUser?.uid != null? data["receiverName"]: data["senderName"];
          return recentRecord(
                  name: displayName,
                  date: DateFormat('MMM d, yyyy').format(DateTime.parse(data["date"].toDate().toString())),
                  direction: data["senderUID"] == auth.currentUser?.uid? "Sent": "Received",
                  amount: data["amount"].toDouble(),
                );
        }
        return Text("Loading");
      }),
    );
  }
}