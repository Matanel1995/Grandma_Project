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
  late String currentGroupId = "this is not changed";
  //LastGroup - (when exit the app last time) think about it can be complicated
  //                                          maybe use the first group when init

  MyUser(
      {required this.id,
      required this.userName,
      required this.photoUrl,
      required this.email,
      required this.currentGroupId});

  factory MyUser.forUserWidget(
      String id, String userName, String photoUrl, String email) {
    return MyUser(
        id: id,
        userName: userName,
        photoUrl: photoUrl,
        email: email,
        currentGroupId: currentUser.currentGroupId);
  }

  factory MyUser.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return MyUser(
      id: snapshot['userId'],
      userName: snapshot['userName'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
      currentGroupId: snapshot['currentGroupId'],
    );
  }

  //Function to add user to a group, the group id added to users list
  Future addUserToGroup(String groupId) async {
    //Get doc referance
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              currentUser.currentGroupId = groupId,
              groupsList.add(groupId),
              userRef.doc(currentUser.id).update(
                {
                  'groupList': FieldValue.arrayUnion(groupsList),
                  'currentGroupId': currentUser.currentGroupId
                },
              ),
            }
          else
            {print('No such Document!')}
        });
  }

  Future ChangeCurrentGroup(String groupId) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    await docRef.get().then((doc) => {
          if (doc.exists &&
              groupsList
                  .contains(groupId)) //if group exist and user is part of it
            {
              docRef.update({'currentGroupId': groupId}),
              currentUser.currentGroupId = groupId,
            }
          else
            {print("DOC NOT FOUND!")}
        });
  }
}
