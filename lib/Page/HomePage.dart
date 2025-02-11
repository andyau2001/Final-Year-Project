import 'package:flutter/material.dart';
import 'package:new_app/HomePage/CardDetail.dart';

import 'package:new_app/HomePage/Cards.dart';
import 'package:new_app/HomePage/HomeBar.dart';
import 'package:new_app/HomePage/recentTransaction.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
          HomeBar(),
          CardsList(),
          CardDetail(),
          recentTransaction(),
          ],
        ),
    );
  }
}