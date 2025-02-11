import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PayPageContent extends StatefulWidget {
  @override
  _PayPageContentState createState() => _PayPageContentState();
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
User? user = auth.currentUser;

class _PayPageContentState extends State<PayPageContent>{
  Widget build(BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Display Your QR Code", style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
          ),
          SizedBox(height: 50),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 170,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffFCB800),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black, width: 5),
                            bottom: BorderSide(color: Colors.black, width: 2.5),
                            right: BorderSide(color: Colors.black, width: 2.5),
                            left: BorderSide(color: Colors.black,width: 5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code,
                              size: 35,
                            ),
                            Text("My QR Code", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                            ),
                          ],
                        ),
                      )
                  ),

                  Container(
                      width: 170,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black, width: 5),
                            bottom: BorderSide(color: Colors.black, width: 2.5),
                            right: BorderSide(color: Colors.black, width: 5),
                            left: BorderSide(color: Colors.black,width: 2.5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.storefront_outlined,
                              size: 35,
                            ),
                            Text("Pay to Business", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                            ),
                          ],
                        ),
                      )
                  )

                ],
              ),
              Container(
                  width: 340,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2.5),
                        bottom: BorderSide(color: Colors.black, width: 5),
                        right: BorderSide(color: Colors.black, width: 5),
                        left: BorderSide(color: Colors.black,width: 5),
                      ),
                    ),
                    child: Center(

                      //String data = 'https://www.example.com';
                      // QrImage qrImage = QrImage(
                      //   data: data,
                      //   version: QrVersions.auto,
                      //   size: 200.0,
                      //   gapless: false,
                      // );

                      child: QrImage(
                        data: auth.currentUser!.uid,
                        version: QrVersions.auto,
                        size: 300.0,
                        gapless: false,
                      ),
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}