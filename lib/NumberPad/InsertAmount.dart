// main.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/HomePage/Cards.dart';
import 'package:new_app/NumberPad/InputPassword.dart';

// import our custom number keyboard
import 'AmountNumPad.dart';

class InputAmount extends StatefulWidget {
  @override
  _InputAmountState createState() => _InputAmountState();

  final String receiverUID;

  InputAmount({required this.receiverUID});
}

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

class _InputAmountState extends State<InputAmount> {
  // text controller
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _collectionReference.snapshots();
  }

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('userProfile');

  final TextEditingController _myController = TextEditingController();

  //document ids
  String receiverDocID = "";
  String senderDocID = "";
  String receiverName = "";

  //get doc ids
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('userProfile').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            if (document.data()["userUID"] == widget.receiverUID) {
              receiverName = document.data()["username"];
              receiverDocID = document.reference.id;
            }
          }),
        );
    await FirebaseFirestore.instance.collection('userProfile').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        if (document.data()["userUID"] == auth.currentUser!.uid) {
          senderDocID = document.reference.id;
        }
      }),
    );

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: getBankBalanceByUserUID(auth.currentUser!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!;
            //print(data['bankBalance']);
            return FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please enter an amount sent to ${receiverName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        // display the entered numbers
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 70,
                            child: Center(
                                child: TextField(
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
                        AmountNumPad(
                          buttonSize: 75,
                          buttonColor: Color(0xffFCB800),
                          iconColor: Colors.black,
                          controller: _myController,
                          delete: () {
                            _myController.text = _myController.text
                                .substring(0, _myController.text.length - 1);
                          },
                          // do something with the input numbers
                          onSubmit: () {
                            if (int.parse(_myController.text) > data['bankBalance']) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Insufficent Balance'),
                                  );
                                },
                              );
                              // showDialog(
                              //     context: context,
                              //     builder: BuildContext context) {
                              //       return AlertDialog(
                              //       title: Text('Insufficient Balance'),
                              //       );
                              // };
                            }else {
                              _collectionReference.doc(receiverDocID).update({
                            'bankBalance': FieldValue.increment((int.parse(_myController.text)))
                            });
                              _collectionReference.doc(senderDocID).update({
                                'bankBalance': FieldValue.increment(-(int.parse(_myController.text)))
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InputPassword(
                                          amount: _myController.text,
                                          receiverUID: widget.receiverUID,
                                        )));
                          }
                            /*debugPrint('Your code: ${_myController.text}');
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Text(
                          "You code is ${_myController.text}",
                          style: const TextStyle(fontSize: 30),
                        ),
                      ));*/
                          },
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Text("Loading");
          }
        });
  }
}
