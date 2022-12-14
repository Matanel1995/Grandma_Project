import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/widgets/UserWidget.dart';
import 'package:google_signin/widgets/promoCard.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('User').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error occurred');
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //creating a map to store user details
                Map<String, dynamic> userDetails =
                    snapshot.data!.docs[index].data();
                print(userDetails['groupList'].toString());
                if (userDetails['groupList']
                        .toString()
                        .contains(currentUser.currentGroupId) &&
                    currentUser.currentGroupId != '0') {
                  MyUser tempUser = MyUser.fromFirestore(userDetails);
                  return UserWidget.fromMyUser(tempUser);
                } else {
                  return Container();
                }
                //creating user object with firestoreBuilder
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
}
