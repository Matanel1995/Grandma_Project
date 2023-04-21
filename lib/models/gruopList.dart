import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/widgets/groupWidget.dart';

class groupList extends StatelessWidget {
  const groupList(BuildContext context, {super.key});

  Widget buildListTile(BuildContext context, String title, IconData iconData,
      VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: tapHandler,
    );
  }

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
            return buildTitle(context, 'Empty data');
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
