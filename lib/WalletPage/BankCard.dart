import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BankCard extends StatefulWidget {
  @override
  _BankCardState createState() => _BankCardState();
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

class _BankCardState extends State<BankCard> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _collectionReference.snapshots();
  }

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('userProfile');

  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: 380,
      decoration: BoxDecoration(
        color: Color(0xffFCB800),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: FutureBuilder<Map<String, dynamic>?>(
          future: getBankBalanceByUserUID(auth.currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!;
              final originbankbalance = NumberFormat('#,##0', 'en_US');
              final finalbalance =
                  originbankbalance.format(data['bankBalance']);
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 130.0, left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "HKD \$" + finalbalance.toString(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Text("Loading");
            }
          }),
    );
  }
}
