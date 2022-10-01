import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:ug_blood_donate/screens/report_form.dart';

class qrscanner extends StatefulWidget {
  const qrscanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _qrscannerState();
}

class _qrscannerState extends State<qrscanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      //controller!.dispose();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return MyCustomForm(
            my_id: result.toString(),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.pink,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
