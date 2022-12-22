import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';

final userRef = FirebaseFirestore.instance.collection('User');

class MyUser {
  final String id;
  final String userName;
  String photoUrl;
  final String email;
  //userType
  List<String> groupsList = [];
  //FavoritGroupID
  //LastGroup - (when exit the app last time) think about it can be complicated
  //                                          maybe use the first group when init

  MyUser({
    required this.id,
    required this.userName,
    required this.photoUrl,
    required this.email,
  });

  factory MyUser.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return MyUser(
        id: snapshot['userId'],
        userName: snapshot['userName'],
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email']);
  }

  //Function to add user to a group, the group id added to users list
  Future addUserToGroup(String groupId) async {
    //Get doc referance
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    docRef.get().then((doc) => {
          if (doc.exists)
            {
              this.groupsList.add(groupId),
              userRef
                  .doc(currentUser.id)
                  .update({'groupList': FieldValue.arrayUnion(groupsList)})
            }
          else
            {print('No such Document!')}
        });
  }
}
