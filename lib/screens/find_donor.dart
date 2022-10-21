import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/components/bottom_navigation_bar.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:ug_blood_donate/components/custom_image.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/doner_profile.dart';

class FindDonor extends StatefulWidget {
  @override
  State<FindDonor> createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream, //db.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return CustomCard(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DonerProfilePage(
                          documentId: doc['uid'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CustomImage(
                      imageUrl: doc['photoURL'],
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                    title: Text(doc['fullname']),
                    subtitle: Text(doc['location']),
                    trailing: Text(doc['bloodType']),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
