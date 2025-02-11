import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeBar extends StatefulWidget {
  @override
  _HomeBarState createState() => _HomeBarState();
}



class _HomeBarState extends State<HomeBar> {
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Home', style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w800
                ),
                ),
              ],
            ),
        );
      }
            /*Flexible(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  recentRecord(),
                ],
              ),
            )*/
}
