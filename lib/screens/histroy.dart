// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:ug_blood_donate/screens/first_screens/blood_page.dart';
import 'package:ug_blood_donate/screens/qr_scanner.dart';
import 'package:ug_blood_donate/services/database_report.dart';
import 'package:ug_blood_donate/components/constants.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class History extends StatefulWidget {
  String my_id;
  History({Key? key, required this.my_id}) : super(key: key);

  @override
  HistoryState createState() {
    return HistoryState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class HistoryState extends State<History> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  TextEditingController month_of_Ldonation = TextEditingController();
  TextEditingController month_of_Fdonation = TextEditingController();
  //TextEditingController made_donation = TextEditingController();
  TextEditingController no_of_dtns = TextEditingController();
  TextEditingController total_donations = TextEditingController();
  //TextEditingController month_of_donation = TextEditingController();
  TextEditingController Donor_no = TextEditingController();
  TextEditingController blood_donated = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: total_donations,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(
                      Icons.mail_outlined,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'enter total number of donations'),
              ),
              TextFormField(
                controller: month_of_Ldonation,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(
                      Icons.mail_outlined,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'enter month of last donation'),
              ),
              TextFormField(
                controller: month_of_Fdonation,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(
                      Icons.mail_outlined,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'Enter month since first donation'),
              ),
              // TextFormField(
              //   controller: made_donation,
              //   decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.grey[200],
              //       prefixIcon: const Icon(
              //         Icons.mail_outlined,
              //         color: Colors.pink,
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //           borderSide:
              //               const BorderSide(width: 3, color: Colors.pink),
              //           borderRadius: BorderRadius.circular(9.0)),
              //       enabledBorder: OutlineInputBorder(
              //           borderSide:
              //               const BorderSide(width: 2, color: Colors.pink),
              //           borderRadius: BorderRadius.circular(9.0)),
              //       hintText: ''),
              // ),
              TextFormField(
                controller: no_of_dtns,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(
                      Icons.mail_outlined,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'Please enter total number of donations'),
              ),
              // TextFormField(
              //   controller: month_of_donation,
              //   decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.grey[200],
              //       prefixIcon: const Icon(
              //         Icons.mail_outlined,
              //         color: Colors.pink,
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //           borderSide:
              //               const BorderSide(width: 3, color: Colors.pink),
              //           borderRadius: BorderRadius.circular(9.0)),
              //       enabledBorder: OutlineInputBorder(
              //           borderSide:
              //               const BorderSide(width: 2, color: Colors.pink),
              //           borderRadius: BorderRadius.circular(9.0)),
              //       hintText: 'enter month of last donation'),
              // ),
              TextFormField(
                controller: Donor_no,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(
                      Icons.mail_outlined,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'Enter year_of_donation'),
              ),
              TextFormField(
                controller: blood_donated,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(
                      Icons.mail_outlined,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.pink),
                        borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'enter total blood donated'),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async {
                      // It returns true if the form is valid, otherwise returns false

                      await DatabaseService(uid: widget.my_id)
                          .updateDonorHistory(
                        total_donations.text,
                        month_of_Ldonation.text,
                        month_of_Fdonation.text,
                        Donor_no.text,
                        blood_donated.text,
                        1.toString(),
                      );
                      // month_of_Ldonation.clear();
                      // month_of_Fdonation.clear();
                      // //made_donation.clear();
                      // no_of_dtns.clear();
                      // total_donations.clear();
                      // //month_of_donation.clear();
                      // Donor_no.clear();
                      // blood_donated.clear();

                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (BuildContext context) {
                      //     return const Request_page();
                      //   }),
                      // );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
