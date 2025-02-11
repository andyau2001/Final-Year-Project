import 'package:flutter/material.dart';

import 'package:new_app/WalletPage/BankButton.dart';
import 'package:new_app/WalletPage/BankDetail.dart';
import 'package:new_app/WalletPage/WalletBar.dart';
import 'package:new_app/WalletPage/BankCard.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>{
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              WalletBar(),
              SizedBox(height: 40),
              BankCard(),
              Image(
                image: AssetImage('Images/doublearrow.png'),
                height: 150,
              ),
              BankDetail(),
              BankButton(),
              ],
            ),
          ),
      );
  }
}
