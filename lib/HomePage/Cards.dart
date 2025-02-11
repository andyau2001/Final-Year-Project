import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:new_app/HomePage/getUsername.dart';

class CardsList extends StatefulWidget {
  @override
  _CardsListState createState() => _CardsListState();
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
User? user = auth.currentUser;

class UserProfile {
  final String? username;
  final String? phone;
  final String? userUID;

  UserProfile({
    this.username,
    this.phone,
    this.userUID,

  });

  factory UserProfile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserProfile(
      username: data?['username'],
      phone: data?['phone'],
      userUID: data?['userUID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "username": username,
      if (phone != null) "phone": phone,
      if (userUID != null) "userUID": userUID,
    };
  }
}
// Future<String> getUserName() async {
//   // Create a reference to the cities collection
//   final userProfileRef = db.collection("userProfile");
//
// // Create a query against the collection.
//   print(user!.uid);
//   final query = userProfileRef.where("userUID", isEqualTo: user!.uid).withConverter(
//       fromFirestore: UserProfile.fromFirestore,
//       toFirestore: (UserProfile UserProfile, _) => UserProfile.toFirestore(),);
//   final data = await query.get();
//   return "hi";
// }

class _CardsListState extends State<CardsList> {

    late Stream<QuerySnapshot> _stream;

    @override
    void initState(){
      super.initState();
      _stream = _collectionReference.snapshots();
  }
    CollectionReference _collectionReference= FirebaseFirestore.instance.collection('userProfile');

  /*final Stream<QuerySnapshot> users =
    FirebaseFirestore.instance.collection('userProfile').snapshots();

  final user = FirebaseAuth.instance.currentUser!;*/

  //document ids
  List<String> docIDs = [];

  //get doc ids
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('userProfile').get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          if (document.data()["userUID"] == auth.currentUser?.uid){
            docIDs.add(document.reference.id);
          }
        }),
    );
  }
  @override
  Widget build(BuildContext context) {
    //Future<String> username = getUsername();
    CollectionReference users = FirebaseFirestore.instance.collection('userProfile');
     return Padding(
       padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome Back', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                ),
                /*StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if (snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      if (snapshot.connectionState == ConnectionState.active){
                        QuerySnapshot querySnapshot = snapshot.data;
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                ),*/


                /*Text('User 001', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                ),*/

                Expanded(
                  child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index){
                      return ListTile(
                      title: GetUserName(documentId: docIDs[index]),
                      );
                      },
                      );
                    }
                    ),
                    ),

                /*
                Expanded(
                  child: FutureBuilder(
                    builder: (context,snapshot){
                      return ListView.builder(
                          itemCount: docIDs.length,
                          itemBuilder: (context, index){
                            return ListTile(
                            title: GetUserName(documentId: docIDs[index]),
                            );
                          });
                    },
                  ),
                )*/
            ],
          )
        );
     // CardDetail()
  }
}