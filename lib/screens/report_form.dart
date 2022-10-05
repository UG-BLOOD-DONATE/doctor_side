// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:ug_blood_donate/services/database_report.dart';
import 'package:ug_blood_donate/components/constants.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  String my_id;
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
  final List<String> sugars = [
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
  TextEditingController bloodtype = TextEditingController();
  TextEditingController rbc = TextEditingController();
  TextEditingController mvc = TextEditingController();
  TextEditingController platelets = TextEditingController();
  TextEditingController hospital = TextEditingController();

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
            children: <Widget>[
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
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Please enter a hospital name'),
                // validator: (val) =>
                //     val!.isEmpty ? 'Please enter a hospital name' : null,
                // onChanged: (val) => setState(() => hospital = val),
              ),
              TextField(
                // initialValue: 'Please enter glucose levels',
                //decoration: textInputDecoration,
                controller: glucose,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(
                              Icons.mail_outlined,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.pink),
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(
                              Icons.mail_outlined,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.pink),
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(
                              Icons.mail_outlined,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Please enter bilirubin levels'),
                // validator: (val) =>
                //     val!.isEmpty ? 'Please enter bilirubin levels' : null,
                // onChanged: (val) => setState(() => bilirubin = val),
              ),
              DropdownButtonFormField(
                //value: bloodtype == null ? 'Blood Type' : bloodtype,
                hint: Text('Blood Type'),
                decoration: textInputDecoration,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => bloodtype = val.toString()),
              ),
              TextFormField(
                // initialValue: 'Please enter rbc levels',
                // decoration: textInputDecoration,
                controller:rbc,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(
                              Icons.mail_outlined,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.pink),
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(
                              Icons.mail_outlined,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Please enter platelets levels'),
                // validator: (val) =>
                //     val!.isEmpty ? 'Please enter platelets levels' : null,
                // onChanged: (val) => setState(() => platelets = val),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async {
                      // It returns true if the form is valid, otherwise returns false
                      if (_formKey.currentState!.validate()) {
                        var user;
                        await DatabaseService(uid: widget.my_id)
                            .updateUserRepost(glucose.text, cholesterol.text, bilirubin.text,
                                bloodtype.text, rbc.text, mvc.text, platelets.text, hospital.text );
                        // If the form is valid, display a Snackbar.
                        final snackBar = SnackBar(
                          content: const Text('Data has processed!'),
                          backgroundColor: (Colors.black12),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // Scaffold.of(context).showSnackBar(
                        //     SnackBar(content: Text('Data is in processing.')));
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:ug_blood_donate/models/user_model.dart';
// import 'package:ug_blood_donate/services/database_report.dart';
// import 'package:ug_blood_donate/components/constants.dart';
// import 'package:ug_blood_donate/components/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SettingsForm extends StatefulWidget {
//   @override
//   _SettingsFormState createState() => _SettingsFormState();
// }

// class _SettingsFormState extends State<SettingsForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4'];
//   final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

//   // form values
//   String _currentName;
//   String _currentSugars;
//   int _currentStrength;

//   @override
//   Widget build(BuildContext context) {
//     User user = Provider.of<User>(context);

//     return StreamBuilder<UserData>(
//         stream: DatabaseService(uid: user.uid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             UserData userData = snapshot.data;
//             return Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     'Update your brew settings.',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     initialValue: userData.name,
//                     decoration: textInputDecoration,
//                     validator: (val) =>
//                         val!.isEmpty ? 'Please enter a name' : null,
//                     onChanged: (val) => setState(() => _currentName = val),
//                   ),
//                   SizedBox(height: 10.0),
//                   DropdownButtonFormField(
//                     value: _currentSugars,
//                     decoration: textInputDecoration,
//                     items: sugars.map((sugar) {
//                       return DropdownMenuItem(
//                         value: sugar,
//                         child: Text('$sugar sugars'),
//                       );
//                     }).toList(),
//                     onChanged: (val) =>
//                         setState(() => _currentSugars = val.toString()),
//                   ),
//                   SizedBox(height: 10.0),
//                   Slider(
//                     value: (_currentStrength).toDouble(),
//                     activeColor: Colors.brown[_currentStrength],
//                     inactiveColor: Colors.brown[_currentStrength],
//                     min: 100.0,
//                     max: 900.0,
//                     divisions: 8,
//                     onChanged: (val) =>
//                         setState(() => _currentStrength = val.round()),
//                   ),
//                   ElevatedButton(
//                       //color: Colors.pink[400],
//                       child: Text(
//                         'Update',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           await DatabaseService(uid: user.uid).updateUserRepost(
//                               _currentSugars, _currentName, _currentStrength);
//                           Navigator.pop(context);
//                         }
//                       }),
//                 ],
//               ),
//             );
//           } else {
//             return Loading();
//           }
//         });
//   }
// }
