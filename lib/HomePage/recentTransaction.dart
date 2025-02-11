import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_app/GetRecord/getRecord.dart';
import 'package:new_app/HomePage/Cards.dart';
import 'package:new_app/HomePage/recentRecord.dart';
import 'package:new_app/Page/HistoryPage.dart';

class recentTransaction extends StatefulWidget {
  @override
  _recentTransactionState createState() => _recentTransactionState();
}

class _recentTransactionState extends State<recentTransaction> {
//document ids
  List<String> docIDs = [];

//get doc ids
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('paymentRecord').orderBy('date', descending: true).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        if (document.data()["senderUID"] == auth.currentUser?.uid || document.data()["receiverUID"] == auth.currentUser?.uid){
          docIDs.add(document.reference.id);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transaction', style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                            color: Colors.black,
                        ),
                        ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: docIDs.length,
                      itemBuilder: (context, index){
                        return getRecord(documentId: docIDs[index]);
                      },
                    );
                  }
              ),
              // ListView(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   children: [
              //     recentRecord(
              //       name: "Test",
              //       date: DateFormat('MMM d, yyyy').format(DateTime.now()),
              //       direction: "Sent",
              //       amount: 1234,
              //     ),
              //     recentRecord(
              //       name: "Test",
              //       date: DateFormat('MMM d, yyyy').format(DateTime.now()),
              //       direction: "Received",
              //       amount: 2000,
              //     ),
              //     recentRecord(
              //       name: "",
              //       date: DateFormat('MMM d, yyyy').format(DateTime.now()),
              //       direction: "Received",
              //       amount: 2000,
              //     ),
              //   ],
              // ),
            )
          ]
        ),
    );
  }
}