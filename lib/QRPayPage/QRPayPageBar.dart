import 'package:flutter/material.dart';
import 'package:new_app/Page/HomePage.dart';

class QRPayPageBar extends StatefulWidget {
  @override
  _QRPayPageBarState createState() => _QRPayPageBarState();
}

class _QRPayPageBarState extends State<QRPayPageBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () { Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage())); },
            icon: Icon(Icons.arrow_back_rounded),
            iconSize: 35,
          ),
          TextButton(
            onPressed: () { Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage())); },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            child: const Text("Back"),
          )
        ],
      ),
    );
  }
}