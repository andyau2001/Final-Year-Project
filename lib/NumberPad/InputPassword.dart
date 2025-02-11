// main.dart
import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/HomePage/getUsername.dart';
import 'package:new_app/HomeScreen.dart';
import 'package:new_app/NumberPad/InputPassword.dart';
import 'package:new_app/NumberPad/getPaymentPassword.dart';
import 'package:new_app/Page/HomePage.dart';
import 'package:new_app/createPayment/createPayment.dart';

// import our custom number keyboard
import 'PassNumPad.dart';

class InputPassword extends StatefulWidget {
  @override
  _InputPasswordState createState() => _InputPasswordState();

  final String amount;
  final String receiverUID;

  InputPassword({
    required this.amount,
    required this.receiverUID,
  });
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
User? user = auth.currentUser;

class UserProfile {
  final String? username;
  final String? userUID;
  final String? paymentPassword;

  UserProfile({
    this.username,
    this.userUID,
    this.paymentPassword,
  });

  factory UserProfile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return UserProfile(
      username: data?['username'],
      userUID: data?['userUID'],
      paymentPassword: data?['paymentPassword'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "username": username,
      if (userUID != null) "userUID": userUID,
      if (paymentPassword != null) "paymentPassword": paymentPassword,
    };
  }
}

// Future<String> getPaymentPassword() async {
//   // Create a reference to the cities collection
//   final userProfileRef = db.collection("userProfile");
//
// // Create a query against the collection.
//   print(user!.uid);
//   final query = userProfileRef.where("userUID", isEqualTo: user!.uid).withConverter(
//     fromFirestore: UserProfile.fromFirestore,
//     toFirestore: (UserProfile UserProfile, _) => UserProfile.toFirestore(),);
//   final data = await query.get();
//   return "hi";
// }

String docID = '';

Future getDocId() async {
  await FirebaseFirestore.instance.collection('userProfile').get().then(
        (snapshot) =>
        snapshot.docs.forEach((document) {
          if (document.data()["userUID"] == auth.currentUser?.uid) {
            docID = document.reference.id;
          }
        }),
  );
}

Future<String?> getPaymentPasswordByUid(String docID) async {
  try {
    getDocId();
    print(docID);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot userProfileSnapshot =
    await firestore.collection('userProfile').doc(docID).get();

    if (userProfileSnapshot.exists) {
      String? paymentPassword = userProfileSnapshot.get('paymentPassword');
      return paymentPassword;
    } else {
      print('User not found');
      return null;
    }
  } catch (e) {
    print('Error fetching paymentPassword: $e');
    return null;
  }
}

class _InputPasswordState extends State<InputPassword> {
  // text controller
  final TextEditingController _myController = TextEditingController();

  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _collectionReference.snapshots();
  }

  CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection('userProfile');

  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Align(
        alignment: Alignment.center,
        child: Text("Please enter password",
        style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
    ),),
    ),
    // display the entered numbers
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 70,
              child: Center(
                  child: TextField(
                obscureText: true,
                maxLength: 6,
                controller: _myController,
                textAlign: TextAlign.center,
                showCursor: false,
                style: const TextStyle(fontSize: 40),
                // Disable the default soft keybaord
                keyboardType: TextInputType.none,
              )),
            ),
          ),
          // implement the custom NumPad
          NumPad(
              buttonSize: 75,
              buttonColor: Color(0xffFCB800),
              iconColor: Colors.black,
              controller: _myController,
              delete: () {
                _myController.text = _myController.text
                    .substring(0, _myController.text.length - 1);
              },
              // do something with the input numbers
              onSubmit: () async {
                if (_myController.text != '') {
                  var bytes = utf8.encode(_myController.text);
                  var digest = sha256.convert(bytes);
                  String? dbPaymentPassword =
                      await getPaymentPasswordByUid(docID);
                  String userInputPaymentPassword = digest.toString();
                  print("db");
                  print(dbPaymentPassword);
                  print("user");
                  print(userInputPaymentPassword);
                  if (dbPaymentPassword == userInputPaymentPassword) {
                    var newPayment = await CreatePayment.sendPayment(
                        receiverUID: widget.receiverUID,
                        password: _myController.text,
                        amount: widget.amount);
                    if (newPayment != null) {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => HomeScreen()));
                      print("Success");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Payment Successful'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    // Use Navigator.pop to navigate back to the previous screen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  },
                                ),
                              ],
                            );
                          });
                    }
                    // else {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: Text('Incorrect Password'),
                    //       );
                    //     },
                    //   );
                    // }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Incorrect Password'),
                        );
                      },
                    );
                  }
                }
              })

          // builder: (_) => AlertDialog(
          //   content: Text(
          //     "Payment Successful",
          //     style: const TextStyle(fontSize: 30),
          //   ),
          // ));
          // }
          //   else{
          //     print("Not Match");
          //     showDialog(
          //         context: context,
          //         builder: (_) => AlertDialog(
          //           content: Text(
          //             "Incorrect Payment Passord",
          //             style: const TextStyle(fontSize: 30),
          //           ),
          //         ));
          //   }
          // }
          // Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
          //debugPrint('Payment Successful');
        ],
      ),
    );
  }
}