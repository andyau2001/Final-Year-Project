import 'package:flutter/material.dart';

class BankButton extends StatefulWidget {
  @override
  _BankButtonState createState() => _BankButtonState();
}

class _BankButtonState extends State<BankButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => print("Top Up Button Pressed"),
                child: Image(image:
                AssetImage('Images/topup.png'),
                  height: 50,
                ),
              ),
              Text('Top Up', style:
                TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => print("Transfer to Bank Button Pressed"),
                child: Image(image:
                AssetImage('Images/deposit.png'),
                  height: 50,
                ),
              ),
              Text('Transfer to Bank',  style:
                TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => print("Unlink Bank Button Pressed"),
                child: Image(image:
                AssetImage('Images/unlink.png'),
                  height: 50,
                ),
              ),
              Text('Unlink Bank',  style:
                TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}