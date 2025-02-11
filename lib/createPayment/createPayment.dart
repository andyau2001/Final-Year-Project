import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
User? user = auth.currentUser;

Future<Map<String, dynamic>?> getBankBalanceByUserUID(String uid) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>?> querySnapshot = await firestore
        .collection('userProfile')
        .where('userUID', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      print('User not found');
      return null;
    }
  } catch (e) {
    print('Error fetching user profile: $e');
    return null;
  }
}



Future<String?> getUsernameByUserUID(String userUID) async {
  String docID = '';
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

class CreatePayment {

  late Stream<QuerySnapshot> _stream;

  CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection('userProfile');

  static Future<String?> sendPayment({
    required String receiverUID,
    required String password,
    required String amount,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    User? user;
    try {
      print(receiverUID);
      print(password);
      print(amount);
      user = auth.currentUser;

      if (user?.uid != null) {
       
        final newPayment = <String, dynamic>{
          "senderUID": user!.uid,
          "senderName": await getUsernameByUserUID(user.uid),
          "receiverUID": receiverUID,
          "receiverName": await getUsernameByUserUID(receiverUID),
          "amount": double.parse(amount),
          "date": DateTime.now(),
        };

        // FutureBuilder<Map<String, dynamic>?>(
        //     future: getBankBalanceByUserUID(auth.currentUser!.uid),
        //     builder: (BuildContext context,
        //         AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasError) {
        //         return Center(child: Text('Error: ${snapshot.error}'));
        //       } else if (snapshot.hasData) {
        //         Map<String, dynamic> data = snapshot.data!;
        //       } else {return Text ("Loading");}
        //     },
        // );


// Add a new document with a generated ID
        db.collection("paymentRecord").add(newPayment).then((
            DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
      }
    } catch (e) {
      print(e);
    }
    return 'success';
  }
}