import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_app/HistoryPage/HistoryTransaction.dart';

class HistoryTransaction extends StatefulWidget {
  @override
  _HistoryTransactionState createState() => _HistoryTransactionState();

  final String name;
  final String date;
  final String direction;
  final double amount;

  HistoryTransaction({
    required this.name,
    required this.date,
    required this.amount,
    required this.direction
  });

}

class _HistoryTransactionState extends State<HistoryTransaction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
      child: Container(
        height: 90,
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage('Images/sent.png')),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(widget.direction, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                      ),
                      SizedBox(width: 10),
                      Text("(" + widget.name + ")", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                      ),
                    ],
                  ),
                  Text(widget.date, style: TextStyle(
                    fontSize: 20.0,
                  ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(widget.amount.toString(),  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: (widget.direction == "Sent") ? Colors.red : Colors.green,
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}