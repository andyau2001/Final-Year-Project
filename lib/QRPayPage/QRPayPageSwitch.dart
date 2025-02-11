import 'package:flutter/material.dart';
import 'package:new_app/Page/PayPage.dart';

class QRPayPageSwitch extends StatefulWidget {
  @override
  _QRPayPageSwitchState createState() => _QRPayPageSwitchState();
}

class _QRPayPageSwitchState extends State<QRPayPageSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xffFCB800),
        child: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PayPage()));
          },
          icon: Icon(
            Icons.swap_vert,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}