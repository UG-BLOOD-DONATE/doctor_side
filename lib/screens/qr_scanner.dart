import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'dart:io';

import 'package:ug_blood_donate/screens/report_form.dart';

var rsl;

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
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(
        () => result = scanData,
      );
      controller.resumeCamera();
    });
  }

  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     //controller!.resumeCamera();
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  void readQr() async {
    controller!.resumeCamera();
    if (result != null) {
      rsl = result.toString();
      controller!.pauseCamera();
      print(result!.code);
      controller!.dispose();
      setState(() {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) {
        //     return MyCustomForm(
        //       my_id: rsl, //result.toString(),
        //     );
        //   }),
        // );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    //dispose();
    return Scaffold(
      appBar: AppBar(
        leading: CustomCard(
          onTap: () {
            if (rsl != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return MyCustomForm(
                    my_id: rsl, //result.toString(),
                  );
                }),
              );
            } else {
              final snackBar = SnackBar(
                content: const Text('try scan again'),
                backgroundColor: (Colors.black12),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Text('tap to write report'),
        ),
      ),
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
