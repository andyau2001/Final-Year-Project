import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:new_app/ProfilePage/ProfileBar.dart';
import 'package:new_app/ProfilePage/ProfileSetting.dart';
import 'package:new_app/ProfilePage/SettingButton.dart';
import 'package:new_app/ProfilePage/getProfileInfo.dart';
import 'package:new_app/loginScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
User? user = auth.currentUser;

Future<Map<String, dynamic>?> getUserProfileByUid(String uid) async {
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

class _ProfilePageState extends State<ProfilePage> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _collectionReference.snapshots();
  }

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('userProfile');

  String docID = "";

  //get doc ids
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('userProfile').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            if (document.data()["username"] == auth.currentUser?.displayName) {
              docID = document.reference.id;
              print("good");
            }
          }),
        );
  }

  // Future<String?> getUserNameByUid(String docID) async {
  //   try {
  //     //getPaymentRecordId();
  //     print(docID);
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //     DocumentSnapshot userProfileSnapshot =
  //     await firestore.collection('userProfile').doc(docID).get();
  //
  //     if (userProfileSnapshot.exists) {
  //       String? username = userProfileSnapshot.get('username');
  //       return username;
  //     } else {
  //       print('profile username not found');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching receiverUID: $e');
  //     return null;
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: FutureBuilder<Map<String, dynamic>?>(
              future: getUserProfileByUid(auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      ProfileBar(),
                      SizedBox(height: 30),
                      ProfileSetting(
                        title: 'Name/ Nickname',
                        subTitle: data['username'],
                      ),
                      ProfileSetting(
                        title: 'Email',
                        subTitle: auth.currentUser!.email.toString(),
                      ),
                      ProfileSetting(
                        title: 'Phone Number',
                        subTitle: data['phone'],
                      ),
                      ProfileSetting(
                        title: 'Daily Transaction Limit',
                        subTitle: 'HKD 5,000',
                      ),
                      SettingButton(button: 'Password Change'),
                      SettingButton(button: 'Help?'),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 350,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            primary: Color(0xff000000),
                          ),
                          child: Text("LOGOUT",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text("Loading");
                }
              })),
    );
  }
}
