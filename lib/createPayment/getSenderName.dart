import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/NumberPad/InputPassword.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<String> getSenderName(String s) async {
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  await firestore.collection('paymentRecord').doc("senderUID").get();

  if (documentSnapshot.exists) {
    // Access the field value using the [] operator
    return documentSnapshot['paymentRecord'];
  } else {
    return 'Document does not exist';
  }
}