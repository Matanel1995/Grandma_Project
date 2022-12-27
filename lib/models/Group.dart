import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'user.dart';

//Get doc referance
CollectionReference collectionRef =
    FirebaseFirestore.instance.collection('Group');

class Group {
  late String groupName;
  late String groupId;
  late Map<String, dynamic> groupUsers = Map();
  late String groupPhotoUrl;
  late String groupManagerId;

  Group(
      {required this.groupId,
      required this.groupName,
      required this.groupManagerId,
      required this.groupPhotoUrl,
      required this.groupUsers});

  Group.widgetConstructor({
    required this.groupName,
    required this.groupPhotoUrl,
  });

  factory Group.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    //print(currentUser.groupsList.toString());
    return Group(
        groupName: snapshot['groupName'],
        groupId: snapshot['groupId'],
        groupUsers: snapshot['groupUsers'],
        groupPhotoUrl: snapshot['groupPhotoUrl'],
        groupManagerId: snapshot['groupManagerId']);
  }

  // static Future helperFromFirestore(String currGroupId) async {
  //   await collectionRef
  //       .doc(currGroupId)
  //       .get()
  //       .then((DocumentSnapshot docSnapshot) {
  //     return docSnapshot.data() as Map<String, dynamic>;
  //   });
  // }

  Group._privateConstructor(
      {required this.groupId,
      required this.groupName,
      required this.groupPhotoUrl,
      required this.groupUsers,
      required this.groupManagerId});

  static Future<Group> createAsync(
    //Function to create new group and store it in firebase
    MyUser user,
    String groupName, [
    String groupPhotoUrl =
        'https://st4.depositphotos.com/11634452/41441/v/600/depositphotos_414416674-stock-illustration-picture-profile-icon-male-icon.jpg',
  ]) async {
    print("In create async!");
    //Create new document in Group collection
    DocumentReference docRef = collectionRef.doc();
    String groupId = docRef.id;
    Map<String, int> groupUsers = {user.id: 0};
    await collectionRef.doc(groupId).set({
      'groupName': groupName,
      'groupId': groupId,
      'groupPhotoUrl': groupPhotoUrl,
      'groupUsers': groupUsers,
      'groupManagerId': user.id
    });
    await currentUser.addUserToGroup(groupId);
    return Group._privateConstructor(
        groupId: groupId,
        groupName: groupName,
        groupPhotoUrl: groupPhotoUrl,
        groupUsers: groupUsers,
        groupManagerId: user.id);
  }

  //Function to create new group- the user that created is ADMIN
  void createGroup(MyUser user, String groupName, String groupPhotoUrl) async {
    await Group.createAsync(user, groupName, groupPhotoUrl);
  }

  //Function to add user to existing group - ONLY ADMIN!
  Future addUser(String userIdAdd) async {
    late var users;
    //ADD HERE IF TO CHECK IF THE USER IS ADMIN!!!!!!!!!!
    await collectionRef.doc(groupId).get().then(
      (DocumentSnapshot docSnapshot) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        if (data['groupUsers'][userIdAdd] == null) {
          data['groupUsers'][userIdAdd] = 0;
        }
        var updateUsers = parseMap(data['groupUsers'].toString());
        collectionRef.doc(groupId).update({'groupUsers': updateUsers});
        if (currentUser.id == userIdAdd) {
          currentUser.addUserToGroup(groupId);
        }
      },
      onError: (e) => print('error!'),
    );
    //UPDATE HERE THE USER GROUPS LIST WITH THE USER METHOD!!!!!!!!!
  }

  Map<String, int> parseMap(String mapString) {
    //function that  get the Map as string and return Map object
    Map<String, int> toReturn = {};
    List<String> entities = mapString.split(',');
    entities.forEach((element) {
      String userId = element.split(':')[0].substring(1);
      String pointsStr = element.split(':')[1].trim().replaceAll('}', "");
      int points = int.parse(pointsStr);
      toReturn.addAll({userId: points});
    });
    return toReturn;
  }

  //Function to leave group
  Future leaveGroup(MyUser user, String groupId) async {
    Map<String, int> usersMap = {};
    //delete the user from the groupUsers List
    await collectionRef.doc(groupId).get().then((DocumentSnapshot docSnapshot) {
      var data = docSnapshot.data() as Map<String, dynamic>;
      usersMap = parseMap(data['groupUsers'].toString());
      if (usersMap.containsKey(user.id)) {
        //users exist in group need to delete him
        usersMap.remove(user.id);
        //update the map on the database
        collectionRef.doc(groupId).update({'groupUsers': usersMap});
      }
    });
  }

  //Function to kick someone from group - ONLY ADMIN!
  Future kickFromGroup(MyUser userToKick, String groupId) async {
    //ADD HERE CHECK IF THE USER THAT RUN THIS FUNCTION IS ADMIN!!!!!!!!
    await leaveGroup(userToKick, groupId);
    //IF THE USER IS NOT ADMIN SEND MASSAGE ONLY ANDIM CAN KICK
    print('You need to be Admin to kick some one from the group!');
  }
}
