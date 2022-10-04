// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredModel extends StatefulWidget {
  const PredModel({super.key});

  @override
  _PredModelState createState() => _PredModelState();
}

class _PredModelState extends State<PredModel> {
  var predValue = "";
  @override
  void initState() {
    super.initState();
    predValue = "click predict button";
  }

  Future<void> predData() async {
    final interpreter = await Interpreter.fromAsset('prediction_model.tflite');
    var input = [
      [74.0, 72.0, 1.0, 250.0, 72.0, 1.0]
    ];
    var output = List.filled(1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    print(output[0][0]);

    setState(() {
      predValue = output[0][0].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 243, 33, 128),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Posibility of donor to donate next month.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            MaterialButton(
              color: Color.fromARGB(255, 243, 33, 128),
              child: Text(
                "predict",
                style: TextStyle(fontSize: 25),
              ),
              onPressed: predData,
            ),
            SizedBox(height: 12),
            Text(
              "Predicted value :  $predValue ",
              style: TextStyle(color: Colors.red, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
