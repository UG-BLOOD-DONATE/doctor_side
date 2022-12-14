//import 'package:alan_voice/alan_voice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogflow_grpc/generated/google/protobuf/struct.pb.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/create_event.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:ug_blood_donate/screens/create_event.dart';
import 'package:ug_blood_donate/screens/find_donor.dart';
import 'package:ug_blood_donate/screens/graph.dart';
import 'package:ug_blood_donate/screens/map/order_traking_page.dart';
import 'package:ug_blood_donate/screens/onboarding_screens.dart';
import 'package:ug_blood_donate/screens/qr_scanner.dart';
import 'package:ug_blood_donate/models/predite_user.dart';
import 'package:ug_blood_donate/screens/user_req.dart';
import 'package:ug_blood_donate/services/database_report.dart';
import 'package:ug_blood_donate/utils/firebase.dart';
//import 'package:ug_blood_donate/Doctor_side/screen/create_event.dart';

// void main() {
//   runApp(const Request_page());
// }

User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();

class Request_page extends StatefulWidget {
  const Request_page({super.key});

  @override
  State<Request_page> createState() => _Request_pageState();
}

class _Request_pageState extends State<Request_page> {
  _Request_pageState() {
    /// Init Alan Button with project key from Alan Studio
    //AlanVoice.addButton("2facc136948794a72cc9accffc83bf352e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    // AlanVoice.onCommand.add((command) {
    //   debugPrint("got new command ${command.toString()}");
    // });
  }
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      print('hi user');
      setState(() {
        loggedInUser = UserModel.fromMap(value.data());
      });
    });
    var users = FirebaseAuth.instance.authStateChanges().listen((users) {
      if (users == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      } else {}
    });
  }

  TextEditingController location = TextEditingController();
  TextEditingController hosiptal = TextEditingController();
  final Stream<QuerySnapshot> _notificationStream = FirebaseFirestore.instance
      .collection("bloodrequests")
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(248, 249, 247, 247),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '  Hello! ${loggedInUser.fullname}.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    subtitle: Text(
                      '  Thanks for your will.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        firebaseAuth.signOut();
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnboardingScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ),
                  const Divider(),
                  const Divider(),
                  TextFormField(
                    controller: hosiptal,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Hospital if you are new here or update',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const Divider(),
                  TextFormField(
                    controller: location,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Hospital location if you are new here or update',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                          );
                        },
                        child: Card(
                          color: Colors.red,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: const Color.fromARGB(255, 243, 248, 247),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 182, 2, 2)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () async {
                                await DatabaseService(uid: user!.uid)
                                    .updateDoctorHosiptal(
                                        hosiptal.text, location.text);
                              },
                              child: const Text('Send Details'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomCard(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FindDonor()),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 4.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.search,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Find Donars',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomCard(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CreateEvent();
                              }),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 4.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.bloodtype,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Event',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomCard(
                            onTap: () {},
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (BuildContext context) {
                            //     return PredModel();
                            //   }),
                            //),
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 8.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.campaign_outlined,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Campaign',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //color: const Color.fromARGB(255, 243, 248, 247),
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 254, 254)
                              .withOpacity(0.5),
                          spreadRadius: 20,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomCard(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ChartApp();
                              }),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Column(
                                children: const [
                                  Icon(Icons.bar_chart,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Statistics',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return GeofencePage();
                            })),
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  //color: const Color.fromARGB(255, 243, 248, 247),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 255, 254, 254)
                                          .withOpacity(0.5),
                                      spreadRadius: 20,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 32.0, horizontal: 4.0),
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.map_outlined,
                                      color: Colors.red,
                                      size: 40.0,
                                    ),
                                    Text(
                                      'Map',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return qrscanner();
                              }),
                            ),
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  //color: const Color.fromARGB(255, 243, 248, 247),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 255, 254, 254)
                                          .withOpacity(0.5),
                                      spreadRadius: 20,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 32.0, horizontal: 8.0),
                                child: Column(
                                  children: const [
                                    Icon(Icons.report,
                                        color: Colors.red, size: 40.0),
                                    Text(
                                      'Report',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Donation Request'),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return UserNotification();
                                  }),
                                ),
                            child: Text('See all')),
                      ],
                    ),
                  ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Image.asset('images/dice1.png'),
                  //           Column(
                  //             children: [
                  //               const Text(
                  //                 'Sabrina Binte Zahir',
                  //                 style: TextStyle(fontWeight: FontWeight.bold),
                  //               ),
                  //               Text(
                  //                 'Labaid Hospital',
                  //                 style: TextStyle(color: Colors.grey[500]),
                  //               ),
                  //               Text(
                  //                 'Science Lab, Dhaka 1205',
                  //                 style: TextStyle(color: Colors.grey[500]),
                  //               ),
                  //               Text(
                  //                 'Time: 02:00 PM, 19 January 2022',
                  //                 style: TextStyle(color: Colors.grey[500]),
                  //               )
                  //             ],
                  //           ),
                  //           Image.asset('images/dice1.png')
                  //         ],
                  //       ),
                  //       const Divider(),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Decline',
                  //             style: TextStyle(
                  //                 color: Colors.grey[500],
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //           const Text(
                  //             'Donate Now',
                  //             style: TextStyle(
                  //                 color: Colors.red,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: _notificationStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text("Loading"));
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return CustomCard(
                              onTap: () {},
                              child: ListTile(
                                title: Text(data['contact']),
                                subtitle: Text(data['note']),
                                trailing: Text(data['location']),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
