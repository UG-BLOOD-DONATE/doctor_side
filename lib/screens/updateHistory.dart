import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ug_blood_donate/screens/histroy.dart';

// void main() => runApp(const MaterialApp(home: MyHome()));

class HistoryScanner extends StatelessWidget {
  const HistoryScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(),
            ));
          },
          child: const Text('user history'),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          String? ui = result!.code;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return History(
                                my_id: ui,
                              );
                            }),
                          );
                        },
                        child: Text(
                            'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
                      ),
                    )
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}






// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:flutter/material.dart';
// import 'package:ug_blood_donate/components/custom_card.dart';
// import 'package:ug_blood_donate/screens/histroy.dart';
// import 'dart:io';

// import 'package:ug_blood_donate/screens/report_form.dart';

// var rsl;

// class qrscanner extends StatefulWidget {
//   const qrscanner({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _qrscannerState();
// }

// class _qrscannerState extends State<qrscanner> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() => this.controller = controller);
//     controller.scannedDataStream.listen((scanData) async {
//       controller.pauseCamera();
//       setState(
//         () => result = scanData,
//       );
//       controller.resumeCamera();
//     });
//   }

//   // void reassemble() {
//   //   super.reassemble();
//   //   if (Platform.isAndroid) {
//   //     //controller!.resumeCamera();
//   //     controller!.pauseCamera();
//   //   } else if (Platform.isIOS) {
//   //     controller!.resumeCamera();
//   //   }
//   // }

//   void readQr() async {
//     controller!.resumeCamera();
//     if (result != null) {
//       rsl = result.toString();
//       controller!.pauseCamera();
//       print(result!.code);
//       controller!.dispose();
      // setState(() {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //       return MyCustomForm(
      //         my_id: rsl, //result.toString(),
      //       );
      //     }),
      //   );
      // });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     readQr();
//     //dispose();
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           CustomCard(
//             onTap: () {
//               if (rsl == null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (BuildContext context) {
//                     return MyCustomForm(
//                       my_id: rsl, //result.toString(),
//                     );
//                   }),
//                 );
//               } else {
//                 final snackBar = SnackBar(
//                   content: const Text('try scan again'),
//                   backgroundColor: (Colors.black12),
//                   action: SnackBarAction(
//                     label: 'dismiss',
//                     onPressed: () {},
//                   ),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               }
//             },
//             child: Text('tap for report_form'),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           CustomCard(
//             onTap: () {
//               if (rsl != null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (BuildContext context) {
                    // return History(
                    //   my_id: rsl, //result.toString(),
                    // );
//                   }),
//                 );
//               } else {
//                 final snackBar = SnackBar(
//                   content: const Text('try scan again'),
//                   backgroundColor: (Colors.black12),
//                   action: SnackBarAction(
//                     label: 'dismiss',
//                     onPressed: () {},
//                   ),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               }
//             },
//             child: Text('tap for histroy'),
//           ),
//         ],
//       ),
//       body: QRView(
//         key: qrKey,
//         onQRViewCreated: _onQRViewCreated,
//         overlay: QrScannerOverlayShape(
//           borderColor: Colors.pink,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: 250,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
