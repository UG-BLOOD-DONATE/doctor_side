// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredModel {
  final String totalVolumnDonated;
  final String monthSinceLdonation;
  final String monthSinceFdonation;
  final String donorNo;
  //String blood_donated,
  final String madeDonation;
  final String noOfDtns;
  PredModel(
      {required this.totalVolumnDonated,
      required this.monthSinceLdonation,
      required this.monthSinceFdonation,
      required this.donorNo,
      required this.madeDonation,
      required this.noOfDtns});

  var predValue;

//   @override
//   _PredModelState createState() => _PredModelState();
// }

// class _PredModelState extends State<PredModel> {
//   var predValue = "";
//   @override
//   void initState() {
//     super.initState();
//     predValue = "click predict button";
//   }

  Future<String> predData() async {
    final interpreter = await Interpreter.fromAsset('prediction_model.tflite');
    var input = [
      [
        double.parse(donorNo),
        double.parse(monthSinceLdonation),
        double.parse(noOfDtns),
        double.parse(totalVolumnDonated),
        double.parse(monthSinceFdonation),
        double.parse(madeDonation)
      ]
    ];
    var output = List.filled(1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    print(output[0][0]);

    // setState(() {
    //   predValue = output[0][0].toString();
    // });
    return predValue;
  }
}

  //@override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Color.fromARGB(255, 243, 33, 128),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             "Posibility of donor to donate next month.",
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           SizedBox(height: 12),
  //           MaterialButton(
  //             color: Color.fromARGB(255, 243, 33, 128),
  //             child: Text(
  //               "predict",
  //               style: TextStyle(fontSize: 25),
  //             ),
  //             onPressed: predData,
  //           ),
  //           SizedBox(height: 12),
  //           Text(
  //             "Predicted value :  $predValue ",
  //             style: TextStyle(color: Colors.red, fontSize: 23),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

