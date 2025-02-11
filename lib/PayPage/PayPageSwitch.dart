import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:new_app/NumberPad/InsertAmount.dart';

import 'package:new_app/Page/QRPayPage.dart';

class PayPageSwitch extends StatefulWidget {
  @override
  _PayPageSwitchState createState() => _PayPageSwitchState();
}

class _PayPageSwitchState extends State<PayPageSwitch> {

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.DEFAULT);
      //
      // barcodeScanRes = FlutterBarcodeScanner.getBarcodeStreamReceiver(
      //     "#ff6666", "Cancel", false, ScanMode.DEFAULT)
      //     .listen((barcodeScanRes) {
        print(barcodeScanRes);
        //print("Hello");
      if (barcodeScanRes == auth.currentUser!.uid){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Invalid QR Code"),
            content: Text("You cannot pay yourself"),
            );
          },
        );
      } else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InputAmount(receiverUID: barcodeScanRes,)));
      }

      } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xffFCB800),
        child: IconButton(
          onPressed: () {
            scanQR();
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QRPayPage()));

          },
          icon: Icon(
            Icons.swap_vert,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}