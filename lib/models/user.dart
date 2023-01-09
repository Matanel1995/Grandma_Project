import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:http/http.dart' as http;

final userRef = FirebaseFirestore.instance.collection('User');
//Get doc referance
CollectionReference collectionRef =
    FirebaseFirestore.instance.collection('Group');

class MyUser {
  final String id;
  final String userName;
  String photoUrl;
  final String email;
  bool isViewer;
  List<dynamic> groupsList = [];
  late String currentGroupId = "this is not changed";

  /// **********************Construtctors - Start*****************************/
  //MyUser Constructor
  MyUser(
      {required this.id,
      required this.userName,
      required this.photoUrl,
      required this.email,
      required this.currentGroupId,
      required this.groupsList,
      required this.isViewer});

  //MyUser Consturctor for MyUserWidget
  //Input : User id, User name , PhotoUrl, User email
  //Output : MyUser object
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

  //MyUsr Constructor from Firebase
  //Input: Map<String,dynamic> can get with firestore functions
  //Output: MyUser object (Data from DB)
  factory MyUser.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return MyUser(
      id: snapshot['userId'] == Null ? '0' : snapshot['userId'],
      userName: snapshot['userName'] == Null ? '' : snapshot['userName'],
      photoUrl: snapshot['photoUrl'] == Null ? '' : snapshot['photoUrl'],
      email: snapshot['email'] == Null ? '' : snapshot['email'],
      currentGroupId:
          snapshot['currentGroupId'] == Null ? '' : snapshot['currentGroupId'],
      groupsList: snapshot['groupList'] == Null ? [] : snapshot['groupList'],
      isViewer: snapshot['isViewer'] == Null ? false : snapshot['isViewer'],
    );
  }

  /// **********************Construtctors - End*****************************/

  /// *******************Getters & Setters -Start***************************/

  //get currentGruopId
  get getCurrentGroupId {
    return currentGroupId;
  }

  //get email
  get getEmail {
    return email;
  }

  //get groupList
  get getGroupList {
    return groupsList;
  }

  //get isViwer
  get getIsViewer {
    return isViewer;
  }

  //get photoUrl
  get getPhotoUrl {
    return photoUrl;
  }

  //get userId
  get userId {
    return userId;
  }

  //get userName
  get getUserName {
    return userName;
  }

  //set currentGruopId
  Future SetCurrentGroup(String groupId) async {
    DocumentReference userDocRef;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    print(groupId);
    print(currentUser.currentGroupId);
    print(currentUser.email);
    //check if document exist
    await docRef.get().then(
        (doc) => {
              if (doc.exists &&
                  groupsList.contains(
                      groupId)) //if group exist and user is part of it
                {
                  userDocRef = userRef.doc(currentUser.id),
                  userDocRef.update({'currentGroupId': groupId}),
                  currentUser.currentGroupId = groupId,
                  print(currentUser.currentGroupId),
                }
              else
                {print("DOC NOT FOUND!")}
            },
        onError: (e) => print("Failed to change current Group" + e.toString()));
  }

  //set isViwer
  Future SetViewMode(bool isViewer) async {
    DocumentReference docRef = userRef.doc(currentUser.id);
    //check if document exist
    await docRef.get().then(
      (doc) {
        if (doc.exists) {
          docRef.update({'isViewer': isViewer});
        }
      },
      onError: (e) => print("Error in setView! " + e.toString()),
    );
    currentUser.isViewer = isViewer;
  }

  /// *******************Getters & Setters -End***************************/

  /// *******************Other functions -Start***************************/

  //Function to add user to a group, the group id added to users list
  Future addUserToGroup(String groupId, MyUser userToAdd) async {
    //Get doc referance
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              userToAdd.groupsList.add(groupId),
              userRef.doc(userToAdd.id).update(
                {
                  'groupList': FieldValue.arrayUnion(userToAdd.groupsList),
                },
              ),
            }
          else
            {print('No such Document!')}
        });
  }

  //Function to add user to a group, the group id added to users list
  Future addUserOnCreation(String groupId) async {
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

  //Input: list of users Id
  //Output: List of MyUser objects
  Future getUsers(List<String> usersId) async {
    for (String userId in usersId) {
      await userRef.doc(userId).get().then((user) {
        if (user.exists) {
          // create new User Object and add to a list
          MyUser tempUser =
              MyUser.fromFirestore(user.data() as Map<String, dynamic>);
          usersList.add(tempUser);
        }
      });
    }
    return usersList;
  }

  //Input: list of users Id
  //Output: List of MyUser objects
  Future getUsersUsingServer(List<String> usersId) async {
    usersList = [];
    for (String userId in usersId) {
      var tempUserJson = await fetchDataFromNode(userId);
      MyUser userToAdd = MyUser.fromFirestore(tempUserJson);
      usersList.add(userToAdd);
    }
    return usersList;
  }

//Input: list of users Id
//Output: List of MyUser objects
  Future getGroups(List<String> groupId) async {
    for (String groupId in groupId) {
      await collectionRef.doc(groupId).get().then((group) {
        if (group.exists) {
          // create new User Object and add to a list
          Group tempGroup =
              Group.fromFirestore(group.data() as Map<String, dynamic>);
          groupsListToReturn.add(tempGroup);
        }
      });
    }
    return groupsListToReturn;
  }

  //Function to leave group
  Future leaveGroup(MyUser user, String groupId) async {
    //get user group list
    await userRef.doc(user.id).get().then((doc) {
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        List<String> temp = parseGroupList(data['groupList'].toString());
        if (temp.contains(groupId)) {
          //if user is in group
          temp.remove(groupId);
          //update DB about emoving user!
          userRef.doc(user.id).update({'groupList': temp});
        } else {
          print("You are not a member in this group!");
        }
      }
    });
  }

  List<String> parseGroupList(String groupsList) {
    print(groupsList);
    List<String> dataToReturn = [];
    List<String> Helper = [];
    Helper = groupsList.split(",");
    for (String groupId in Helper) {
      String groupid = groupId.trim().replaceAll(']', "");
      groupid = groupid.trim().replaceAll('[', "");
      dataToReturn.add(groupid);
    }
    return dataToReturn;
  }

  Future fetchDataFromNode(String userId) async {
    try {
      var url = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8080,
        path: '/getUser',
        queryParameters: {'id': userId},
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var tempString = response.body.substring(1, response.body.length - 1);
        final jsonObject = jsonDecode(tempString);
        return jsonObject;
      } else {
        print('Unable to fetch the data from the server!');
      }
    } catch (error) {
      print('The error is: ' + error.toString());
    }
  }

  // Map<String, dynamic> parseUserData(String userData) {
  //   //print(jsonDecode(userData));
  //   Map<String, dynamic> tempMap = {};
  //   String stringData;
  //   userData = userData.replaceAll('[', "");
  //   userData = userData.replaceAll(']', "");
  //   userData = userData.replaceAll('{', "");
  //   userData = userData.replaceAll('}', "");
  //   List<String> temp = userData.split(",");
  //   for (stringData in temp) {
  //     int idx = stringData.indexOf(":");
  //     List<String> tempString = [
  //       stringData.substring(0, idx),
  //       stringData.substring(idx + 1)
  //     ];
  //     tempMap[tempString[0].replaceAll('"', "")] = tempString[1];
  //   }
  //   if (tempMap['groupList'] == "") {
  //     tempMap['groupList'] = [];
  //   }
  //   return tempMap;
  // }
}
