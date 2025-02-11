import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build (BuildContext context) {

    return MaterialApp(
      title: "Flutter Login UI",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}