// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ug_blood_donate/screens/first_screens/blood_page.dart';
import 'package:ug_blood_donate/services/database_report.dart';
import 'package:ug_blood_donate/components/constants.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class B_G_stat extends StatefulWidget {
  //String? my_id;

  B_G_stat({Key? key}) : super(key: key);

  @override
  B_G_statState createState() {
    //print("${my_id.code}");
    return B_G_statState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class B_G_statState extends State<B_G_stat> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  TextEditingController A_controller = TextEditingController();
  TextEditingController B_controller = TextEditingController();
  TextEditingController AB_controller = TextEditingController();
  //TextEditingController bloodtype = TextEditingController();
  TextEditingController O_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  //initialValue: 'Please enter a hospital name',
                  //decoration: textInputDecoration,
                  controller: B_controller,
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
                      hintText: 'B'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter a hospital name' : null,
                  // onChanged: (val) => setState(() => hospital = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter glucose levels',
                  //decoration: textInputDecoration,
                  controller: O_controller,
                  keyboardType: TextInputType.number,
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
                      hintText: 'O'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter glucose levels' : null,
                  // onChanged: (val) => setState(() => glucose = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter cholesterol levels',
                  // decoration: textInputDecoration,
                  controller: AB_controller,
                  keyboardType: TextInputType.number,
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
                      hintText: 'AB'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter cholesterol levels' : null,
                  // onChanged: (val) => setState(() => cholesterol = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter bilirubin levels',
                  // decoration: textInputDecoration,
                  controller: A_controller,
                  keyboardType: TextInputType.number,
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
                      hintText: 'A'),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () async {
                        await DatabaseService(uid: user!.uid).updateBloodstat(
                            AB_controller.text,
                            O_controller.text,
                            B_controller.text,
                            A_controller.text);
                        AB_controller.clear();
                        O_controller.clear();
                        B_controller.clear();
                        A_controller.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const Request_page();
                          }),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
