import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QRPayPageContent extends StatefulWidget {
  @override
  _QRPayPageContentState createState() => _QRPayPageContentState();
}

class _QRPayPageContentState extends State<QRPayPageContent>{

  String qrCode = "Unknown";
/*
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isIOS){
      controller!.pauseCamera();
    } else if (Platform.isAndroid) {
      controller!.resumeCamera();
    }
  }*/

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Scan QR Code", style: TextStyle(
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
                        color: Colors.white,
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
                        color: Color(0xffFCB800),
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
                    ),
                  )

/*                        child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated),
                      ),
              ),
              result != null?Text("Barcode Type: ${describeEnum(result!.format)} Data:${result!.code}") : const Text("Scan a Code")*/
            ],
          ),
        ],
      ),
    );
  }

/*  void _onQRViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });

    @override
    void dispose() {
      controller?.dispose();
      super.dispose();
    }
  }*/

  Future <void> scanQRcode() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'cancel',
      true,
      ScanMode.QR,
    );

    if(!mounted) return;
    setState(() {
      this.qrCode = qrCode;
    });
  }

}