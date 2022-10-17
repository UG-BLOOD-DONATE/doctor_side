// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ug_blood_donate/components/bottom_navigation_bar.dart';
import 'package:ug_blood_donate/models/predite_user.dart';

class DonerProfilePage extends StatefulWidget {
  final String documentId;
  const DonerProfilePage({super.key, required this.documentId});

  @override
  State<DonerProfilePage> createState() => _DonerProfilePageState();
}

class _DonerProfilePageState extends State<DonerProfilePage> {
  MapType _currentMapType = MapType.normal;
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(0.3272399, 32.57796);
  static const LatLng destination = LatLng(0.312222, 32.585556);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  var name;
  var pic;
  var loc;
  var blood;
  var num;
  var prob;
  var totalVolumnDonated;
  var monthSinceLdonation;
  var monthSinceFdonation;
  var donorNo;
  //String blood_donated,
  var madeDonation;
  var noOfDtns;
  final db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("histroy")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      //print('hi user');
      if (value.exists) {
        setState(() {
          totalVolumnDonated = value.data()!['total_volumn_donated'];
          monthSinceLdonation = value.data()!['month_since_Ldonation'];
          monthSinceFdonation = value.data()!['month_since_Fdonation'];
          donorNo = value.data()!['Donor_no'];
          madeDonation = value.data()!['made_donation'];
          noOfDtns = value.data()!['no_of_dtns'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            name = data['fullname'];
            blood = data['bloodType'];
            loc = data['location'];
            pic = data['photoURL'];
            num = data['phonenumber'];

            //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          }

          //return Text("loading");
          // return StreamBuilder<QuerySnapshot>(
          //     stream: db.collection('histroy').snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         snapshot.data!.docs.map((doc) {
          // totalVolumnDonated = doc['total_volumn_donated'];
          // monthSinceLdonation = doc['month_since_Ldonation'];
          // monthSinceFdonation = doc['month_since_Fdonation'];
          // donorNo = doc['Donor_no'];
          // madeDonation = doc['made_donation'];
          // noOfDtns = doc['no_of_dtns'];
          //           // print('${total_volumn_donations}');
          //         });
          //       }
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
                title: const Text("Find Donors"),
                centerTitle: true,
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              body: ListView(children: [
                Center(
                  child: Image.network(
                    pic,
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '                ${name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                    /*3*/
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Colors.pink),
                      Text(loc),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      children: <Widget>[
                        Center(
                          child: new Image.asset(
                            'assets/images/iconsase.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                            child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              noOfDtns,
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              " Time/s donated",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )),
                        // ListTile(
                        //   title: Text('Probability to donate next month:'),
                        //   subtitle: Text(''),//${prob}
                        // ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: <Widget>[
                        new Positioned(
                            child: new Image.asset(
                          'assets/images/icon.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        )),
                        Positioned(
                          child: Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                              ),
                              // ignore: prefer_const_constructors
                              Text(
                                "Blood Type ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                blood,
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      /*1*/
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.contact_phone,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  label: const Text('Call Now'),
                                  onPressed: () {
                                    print('Pressed');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                150, 27, 158, 163)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                    Expanded(
                      /*1*/
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.navigate_before_sharp,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  label: const Text('See prediction'),
                                  onPressed: () => Navigator.push(
                                        context, //true
                                        MaterialPageRoute(
                                          builder: (_) => PredModel(
                                            donorNo: donorNo,
                                            madeDonation: madeDonation,
                                            monthSinceFdonation:
                                                monthSinceFdonation,
                                            monthSinceLdonation:
                                                monthSinceLdonation,
                                            noOfDtns: noOfDtns,
                                            totalVolumnDonated:
                                                totalVolumnDonated,
                                          ),
                                        ),
                                      ),
                                  // {
                                  //   print('Pressed');
                                  // },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 233, 10, 103)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
                new Container(
                  height: 350,
                  width: 200,
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        compassEnabled: true,
                        mapType: MapType.hybrid,
                        initialCameraPosition: const CameraPosition(
                            tilt: 9.0,
                            target: LatLng(0.339535, 32.571199),
                            zoom: 10.5),
                        markers: {
                          const Marker(
                            markerId: MarkerId("currentLocation"),
                            position: LatLng(0.339535, 32.571199),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ]));
        });
    //   },
    // );
  }
}
