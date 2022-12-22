import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'user.dart';

//Get doc referance
CollectionReference collectionRef =
    FirebaseFirestore.instance.collection('Group');

class Group {
  late String groupName;
  late String groupId;
  late Map<String, int> groupUsers = Map();
  late String groupPhotoUrl;
  late String groupManagerId;

  Group._privateConstructor(
      {required this.groupId,
      required this.groupName,
      required this.groupPhotoUrl,
      required this.groupUsers,
      required this.groupManagerId});

  static Future<Group> createAsync(
      //Function to create new group and store it in firebase
      MyUser user,
      String groupName,
      String groupPhotoUrl) async {
    //Create new document in Group collection
    DocumentReference docRef = collectionRef.doc();
    String groupId = docRef.id;
    Map<String, int> groupUsers = {user.id: 0};
    collectionRef.doc(groupId).set({
      'groupName': groupName,
      'groupId': groupId,
      'groupPhotoUrl': groupPhotoUrl,
      'groupUsers': groupUsers,
      'groupManagerId': user.id
    });
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
    //Get doc referance
    //CollectionReference docRef = FirebaseFirestore.instance.collection('Group');
    await collectionRef.doc(groupId).get().then(
      (DocumentSnapshot docSnapshot) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        if (data['groupUsers'][userIdAdd] == null) {
          data['groupUsers'][userIdAdd] = 0;
        }
        var updateUsers = parseMap(data['groupUsers'].toString());
        collectionRef.doc(groupId).update({'groupUsers': updateUsers});
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
