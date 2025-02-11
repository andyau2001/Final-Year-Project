import 'package:flutter/material.dart';

class BankDetail extends StatefulWidget {
  @override
  _BankDetailState createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail>{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage('Images/bank.png'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bank Name', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800
              ),
              ),
              Text('ABC Bank', style: TextStyle(
                fontSize: 18,
              ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bank Account', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800
                  ),
                  ),
                  Text('1234 1234 1234 1234', style: TextStyle(
                    fontSize: 18,
                  ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}