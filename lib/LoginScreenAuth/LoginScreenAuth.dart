import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:new_app/GetRecord/getRecord.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirm,
    required String paymentPassword,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user;

    try {
      print(email);
      print(password);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      user = userCredential.user;
      // await user!.updateProfile(displayName: username);
      // await user.reload();
      user = auth.currentUser;

      var bytes = utf8.encode(paymentPassword);
      var encryptedPaymentPassword = sha256.convert(bytes);

      if (user?.uid != null) {
        // Create a new user with a first and last name
        final userProfileData = <String, dynamic>{
          "userUID": user!.uid,
          "username": username,
          "phone": phone,
          "paymentPassword": encryptedPaymentPassword.toString(),
          "email": email,
          "bankBalance": 5000,
        };

// Add a new document with a generated ID
        db.collection("userProfile").add(userProfileData).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    // required BuildContext context,
  }) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}

//FirebaseAuth.instance.signOut();