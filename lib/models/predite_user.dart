// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredModel extends StatefulWidget {
  final String totalVolumnDonated;
  final String monthSinceLdonation;
  final String monthSinceFdonation;
  final String donorNo;
  final String madeDonation;
  final String noOfDtns;
  PredModel(
      {super.key,
      required this.totalVolumnDonated,
      required this.monthSinceLdonation,
      required this.monthSinceFdonation,
      required this.donorNo,
      required this.madeDonation,
      required this.noOfDtns});

  var predValue;

  @override
  _PredModelState createState() => _PredModelState();
}

class _PredModelState extends State<PredModel> {
  var predValue;
  var donorNo;
  var monthSinceLdonation;
  var noOfDtns;
  var totalVolumnDonated;
  var monthSinceFdonation;
  var madeDonation;

  @override
  void initState() {
    super.initState();
    predValue = 0; //"click predict button";
    donorNo = widget.donorNo;
    monthSinceLdonation = widget.monthSinceLdonation;
    noOfDtns = widget.noOfDtns;
    totalVolumnDonated = widget.totalVolumnDonated;
    monthSinceFdonation = widget.monthSinceFdonation;
    madeDonation = widget.madeDonation;
  }

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

    setState(() {
      predValue = output[0][0]; //.toString();
    });
    return predValue * 100.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 33, 128),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Posibility of donor to donate next month.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            MaterialButton(
              color: const Color.fromARGB(255, 243, 33, 128),
              onPressed: predData,
              child: const Text(
                "predict",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 12),
            predValue >= 0.5
                ? Text(
                    "Higher chances of donating:${predValue * 100.round()} %  ",
                    style: const TextStyle(color: Colors.blue, fontSize: 23),
                  )
                : Text(
                    "lower chances of donating:${predValue * 100.round()} %  ",
                    style: const TextStyle(color: Colors.red, fontSize: 23),
                  ),
            const SizedBox(height: 12),
            // Container(
            //     child: int.parse(predValue) > 0.5
            //         ? Text(
            //             "Likely  to donate blood at :${predValue}/1  ",
            //             style:
            //                 const TextStyle(color: Colors.blue, fontSize: 23),
            //           )
            //         : Text(
            //             "Unlikely to donate blood at :${predValue}/1  ",
            //             style:
            //                 const TextStyle(color: Colors.blue, fontSize: 23),
            //           )),
            // const Text(
            //   "if the pobability is higher than 0.5 then the donor has higher pobabilitychances of donating next month",
            //   style: TextStyle(color: Colors.red, fontSize: 23),
            // ),
          ],
        ),
      ),
    );
  }
}
