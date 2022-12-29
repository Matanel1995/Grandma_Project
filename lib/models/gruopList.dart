import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/widgets/groupWidget.dart';

class groupList extends StatelessWidget {
  const groupList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Group').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error occurred');
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //creating a map to store user details
                Map<String, dynamic> groupDetails =
                    snapshot.data!.docs[index].data();
                //creating user object with firestoreBuilder
                var toCheck =
                    GetGroupId(snapshot.data!.docs[index].data().toString());
                if (currentUser.groupsList.contains(toCheck)) {
                  Group tempGroup = Group.fromFirestore(groupDetails);
                  return groupWidget.fromGroup(tempGroup);
                } else {
                  return Container();
                }
              },
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('state: ${snapshot.connectionState}');
        }
      },
    );
  }

  String GetGroupId(String data) {
    String helper = data.split(',')[2];
    helper = helper.split(':')[1];
    helper = helper.trim();
    return helper;
  }
}
