import 'package:flutter/material.dart';

import 'package:new_app/HistoryPage/HistoryBar.dart';
import 'package:new_app/HistoryPage/TransactionList.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>{
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          HistoryBar(),
          TransactionList(),
        ],
      ),
    ),
    );
  }
}