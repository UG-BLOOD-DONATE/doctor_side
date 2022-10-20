import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

class UserNotification extends StatefulWidget {
  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  final Stream<QuerySnapshot> _notificationStream = FirebaseFirestore.instance
      .collection("bloodrequests")
      .snapshots(includeMetadataChanges: true);

  var fullname;
  var photoUrl;
  var bloodType;
  var location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _notificationStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              //Map<String, dynamic> id = document.id as Map<String, dynamic>;
              // FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(document
              //         .reference.id) //FirebaseAuth.instance.currentUser!.uid)
              //     .get()
              //     .then((value) {
              //   //print('$id');
              //   if (value.exists) {
              //     print('hi diiiii');
              //     setState(() {
              //       fullname = value.data()!["fullname"];
              //       location = value.data()!["location"];
              //       photoUrl = value.data()!["photoURL"];
              //       bloodType = value.data()!["bloodType"];
              //     });
              //   }
              //   print(fullname);
              // });
              return ListTile(
                // leading: Image(image: photoUrl),
                // title: Text(fullname),
                subtitle: Text(data['note']),
                trailing: Text(data['location']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
