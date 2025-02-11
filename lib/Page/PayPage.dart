import 'package:flutter/material.dart';

import 'package:new_app/PayPage/PayPageSwitch.dart';
import 'package:new_app/PayPage/PayPageBar.dart';
import 'package:new_app/PayPage/PayPageContent.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget> [
              PayPageBar(),
              SizedBox(height: 30),
              PayPageContent(),
              PayPageSwitch(),
              ],
          ),
        ),
      ),
    );
  }
}