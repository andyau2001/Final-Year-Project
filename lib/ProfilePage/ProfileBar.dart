import 'package:flutter/material.dart';

class ProfileBar extends StatefulWidget {
  @override
  _ProfileBarState createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Profile', style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w800
          ),
          ),
        ],
      ),
    );
  }
}