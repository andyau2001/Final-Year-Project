import 'package:flutter/material.dart';

class HistoryBar extends StatefulWidget {
  @override
  _HistoryBarState createState() => _HistoryBarState();
}

class _HistoryBarState extends State<HistoryBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Payment History', style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w800
          ),
          ),
        ],
      ),
    );
  }
}