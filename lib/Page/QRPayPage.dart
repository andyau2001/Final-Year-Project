import 'package:flutter/material.dart';

import 'package:new_app/QRPayPage/QRPayPageBar.dart';
import 'package:new_app/QRPayPage/QRPayPageContent.dart';
import 'package:new_app/QRPayPage/QRPayPageSwitch.dart';

class QRPayPage extends StatefulWidget {
  @override
  _QRPayPageState createState() => _QRPayPageState();
}

class _QRPayPageState extends State<QRPayPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget> [
            QRPayPageBar(),
            SizedBox(height: 30),
            QRPayPageContent(),
            QRPayPageSwitch(),
          ],
        ),
      ),
      ),
    );
  }
}