import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';

final userRef = FirebaseFirestore.instance.collection('User');

class MyUser {
  final String id;
  final String userName;
  String photoUrl;
  final String email;
  bool isViewer;
  List<dynamic> groupsList = [];
  late String currentGroupId = "this is not changed";

  MyUser(
      {required this.id,
      required this.userName,
      required this.photoUrl,
      required this.email,
      required this.currentGroupId,
      required this.groupsList,
      required this.isViewer});

  factory MyUser.forUserWidget(
      String id, String userName, String photoUrl, String email) {
    return MyUser(
        id: id,
        userName: userName,
        photoUrl: photoUrl,
        email: email,
        currentGroupId: currentUser.currentGroupId,
        groupsList: currentUser.groupsList,
        isViewer: currentUser.isViewer);
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
      groupsList: snapshot['groupList'],
      isViewer: snapshot['isViewer'],
    );
  }

  //Function to add user to a group, the group id added to users list
  Future addUserToGroup(String groupId) async {
    print("In add user to Group!");
    //Get doc referance
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              print('Doc Exist!'),
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

  Future changeViewMode(bool isViewer) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('User').doc(currentUser.id);
    //check if document exist
    await docRef.get().then(
      (doc) {
        if (doc.exists) {
          docRef.update({'isViewer': isViewer});
        }
      },
    );
    currentUser.isViewer = isViewer;
  }
}
