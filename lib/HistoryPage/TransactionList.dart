import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_app/GetRecord/getRecord.dart';
import 'package:new_app/HistoryPage/HistoryTransaction.dart';
import 'package:new_app/HomePage/Cards.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

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
                // Text('Today', style: TextStyle(
                //   fontSize: 20.0,
                //   fontWeight: FontWeight.w600,
                //   color: Colors.black,
                // ),
                // ),
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

            /*ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                HistoryTransaction(),
                HistoryTransaction(),
              ],
            ),*/
          )
        ],
      ),
    );
  }

}