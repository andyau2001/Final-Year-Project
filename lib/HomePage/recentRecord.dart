import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_app/GetRecord/getRecord.dart';
import 'package:new_app/HomePage/Cards.dart';
import 'package:new_app/HomePage/recentRecord.dart';


class recentRecord extends StatefulWidget {
  @override
  _recentRecordState createState() => _recentRecordState();
  final String? name;
  final String date;
  final String direction;
  final double amount;

  recentRecord({
    required this.name,
    required this.date,
    required this.amount,
    required this.direction
  });
}

String docID = '';

Future getPaymentRecordId() async {
  await FirebaseFirestore.instance.collection('paymentRecord').get().then(
        (snapshot) =>
        snapshot.docs.forEach((document) {
          if (document.data()["senderUID"] == auth.currentUser?.uid) {
            docID = document.reference.id;
          } else {
            print ("user not found");
          }
        }),
  );
}

Future<String?> getSenderNameByUid(String docID) async {
  try {
    //getPaymentRecordId();
    print(docID);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot paymentRecordSnapshot =
    await firestore.collection('paymentRecord').doc(docID).get();

    if (paymentRecordSnapshot.exists) {
      String? receiverUID = paymentRecordSnapshot.get('receiverUID');
      return receiverUID;
    } else {
      print('receiverUID not found');
      return null;
    }
  } catch (e) {
    print('Error fetching receiverUID: $e');
    return null;
  }
}


class _recentRecordState extends State<recentRecord> {

  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _collectionReference.snapshots();
  }

  CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection('paymentRecord');

  Widget build(BuildContext context) {
    print(getSenderNameByUid(docID));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
      child: Container(
        height: 90,
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: widget.direction == 'sent'
                  ? AssetImage('Images/sent.png')
                  : AssetImage('Images/receive.png')),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(widget.direction, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                      ),
                      SizedBox(width: 10),
                      Text("(${widget.name})", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                      ),
                    ],
                  ),
                  Text(widget.date, style: TextStyle(
                      fontSize: 20.0,
                  ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(widget.amount.toString(),  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: (widget.direction == "Sent") ? Colors.red : Colors.green,
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}