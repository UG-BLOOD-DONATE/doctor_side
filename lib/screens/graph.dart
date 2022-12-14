import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:ug_blood_donate/components/bottom_navigation_bar.dart';

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(primarySwatch: Colors.redAccent[400]),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  String O = '';
  String A = '';
  String B = '';
  String AB = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Blood_stat")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      //print('hi user');
      if (value.exists) {
        setState(() {
          O = value.data()!["O"];
          A = value.data()!["A"];
          AB = value.data()!["AB"];
          B = value.data()!["B"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('O', int.parse(O)),
      _SalesData('AB', int.parse(AB)),
      _SalesData('B', int.parse(B)),
      _SalesData('A', int.parse(A)),
    ];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            iconSize: 24.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BaseBar(),
                  ));
            },
            icon: const Icon(Icons.navigate_before_sharp),
          ),
          backgroundColor: Color.fromARGB(255, 194, 10, 172),
          title: const Text('Donation chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly blood donation analtsis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.bloodtypes,
                    yValueMapper: (_SalesData sales, _) => sales.no_of_donors,
                    name: 'num_of_dnrs',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                color: Color.fromARGB(255, 194, 10, 172),

                //Enable the trackball
                trackball: SparkChartTrackball(
                    color: Colors.blue,
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    color: Colors.blue,
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].bloodtypes,
                yValueMapper: (int index) => data[index].no_of_donors,
                dataCount: 4,
              ),
            ),
          )
        ]));
  }
}

class _SalesData {
  _SalesData(this.bloodtypes, this.no_of_donors);

  final String bloodtypes;
  final int no_of_donors;
}
