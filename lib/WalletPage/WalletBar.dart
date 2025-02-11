import 'package:flutter/material.dart';

class WalletBar extends StatefulWidget {
  @override
  _WalletBarState createState() => _WalletBarState();
}

class _WalletBarState extends State<WalletBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Your Wallet', style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w800
          ),
          ),
        ],
      ),
    );
  }
}