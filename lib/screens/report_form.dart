// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ug_blood_donate/screens/first_screens/blood_page.dart';
import 'package:ug_blood_donate/services/database_report.dart';
import 'package:ug_blood_donate/components/constants.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  Barcode my_id;
  MyCustomForm({Key? key, required this.my_id}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final List<String> bloods = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  TextEditingController glucose = TextEditingController();
  TextEditingController cholesterol = TextEditingController();
  TextEditingController bilirubin = TextEditingController();
  //TextEditingController bloodtype = TextEditingController();
  TextEditingController rbc = TextEditingController();
  TextEditingController mvc = TextEditingController();
  TextEditingController platelets = TextEditingController();
  TextEditingController hospital = TextEditingController();
  late String bloodtype;
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
                  controller: hospital,
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
                      hintText: 'Please enter a hospital name'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter a hospital name' : null,
                  // onChanged: (val) => setState(() => hospital = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter glucose levels',
                  //decoration: textInputDecoration,
                  controller: glucose,
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
                      hintText: 'Please enter glucose levels'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter glucose levels' : null,
                  // onChanged: (val) => setState(() => glucose = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter cholesterol levels',
                  // decoration: textInputDecoration,
                  controller: cholesterol,
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
                      hintText: 'Please enter cholesterol levels'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter cholesterol levels' : null,
                  // onChanged: (val) => setState(() => cholesterol = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter bilirubin levels',
                  // decoration: textInputDecoration,
                  controller: bilirubin,
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
                      hintText: 'Please enter bilirubin levels'),
                ),
                DropdownButtonFormField(
                  hint: const Text('Blood Type'),
                  decoration: textInputDecoration,
                  items: bloods.map((blood) {
                    return DropdownMenuItem(
                      value: blood,
                      child: Text('$blood'),
                    );
                  }).toList(),
                  onChanged: (val) =>
                      setState(() => bloodtype = val.toString()),
                ),
                TextFormField(
                  controller: rbc,
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
                      hintText: 'Please enter rbc levels'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter rbc levels' : null,
                  // onChanged: (val) => setState(() => rbc = val),
                ),
                TextFormField(
                  // initialValue: 'Please enter platelets levels',
                  // decoration: textInputDecoration,
                  controller: platelets,
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
                      hintText: 'Please enter platelets levels'),
                  // validator: (val) =>
                  //     val!.isEmpty ? 'Please enter platelets levels' : null,
                  // onChanged: (val) => setState(() => platelets = val),
                ),
                TextFormField(
                  controller: mvc,
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
                      hintText: 'Please enter mvc levels'),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () async {
                        print('Pressed1:${glucose.text}');
                        // It returns true if the form is valid, otherwise returns false
                        await DatabaseService(uid: '${widget.my_id}')
                            .updateUserRepost(
                                glucose.text,
                                cholesterol.text,
                                bilirubin.text,
                                bloodtype,
                                rbc.text,
                                mvc.text,
                                platelets.text,
                                hospital.text);
                        print(
                            'pressed2:${hospital.text}\n ${widget.my_id.code}');
                        glucose.clear();
                        cholesterol.clear();
                        bilirubin.clear();
                        //bloodtype,
                        rbc.clear();
                        mvc.clear();
                        platelets.clear();
                        hospital.clear();

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
