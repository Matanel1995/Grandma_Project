import 'package:cloud_firestore/cloud_firestore.dart';
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

  ///*************************Constructors - Start************************* */

//Group Constructor
  Group(
      {required this.groupId,
      required this.groupName,
      required this.groupManagerId,
      required this.groupPhotoUrl,
      required this.groupUsers});

//Group Constractor fir GroupWidget
  Group.widgetConstructor({
    required this.groupName,
    required this.groupPhotoUrl,
    required this.groupId,
    required this.groupManagerId,
    required this.groupUsers,
  });
//Group Constructor from firebase
//Input: Map<String,dynamic>
//Putput : Group object
  factory Group.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return Group(
        groupName: snapshot['groupName'],
        groupId: snapshot['groupId'],
        groupUsers: snapshot['groupUsers'],
        groupPhotoUrl: snapshot['groupPhotoUrl'],
        groupManagerId: snapshot['groupManagerId']);
  }
//Group private consturctor (to use inside createAsync)
  Group._privateConstructor(
      {required this.groupId,
      required this.groupName,
      required this.groupPhotoUrl,
      required this.groupUsers,
      required this.groupManagerId});

  ///*************************Constructors - End***************************** */

  ///***********************Getter & Setters - Start************************* */
  get getGroupId {
    return groupId;
  }

  get getGroupManagerId {
    return groupManagerId;
  }

  get getGroupName {
    return groupName;
  }

  get getGroupPhotoUrl {
    return groupPhotoUrl;
  }

  get getGroupUsers {
    return groupUsers;
  }

  // adiel trying to add
  getGroupFromId(String groupId) {
    return this.getGroupName;
  }

  ///***********************Getter & Setters - End*************************** */

  ///***********************Other functions - Start**************************** */

//Function to create new group in firebase
//And set the user that creating it to its Admin field /
  static Future<Group> createAsync(
    //Function to create new group and store it in firebase
    MyUser user,
    String groupName, [
    String groupPhotoUrl =
        'https://st4.depositphotos.com/11634452/41441/v/600/depositphotos_414416674-stock-illustration-picture-profile-icon-male-icon.jpg',
  ]) async {
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
    await currentUser.addUserOnCreation(groupId);
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
  Future addUser(MyUser userToAdd) async {
    print("in add user funtion!!!!1");
    if (groupManagerId == currentUser.id) {
      await collectionRef.doc(groupId).get().then(
        (DocumentSnapshot docSnapshot) {
          var data = docSnapshot.data() as Map<String, dynamic>;
          if (data['groupUsers'][userToAdd.id] == null) {
            data['groupUsers'][userToAdd.id] = 0;
          }
          var updateUsers = parseMap(data['groupUsers'].toString());
          collectionRef.doc(groupId).update({'groupUsers': updateUsers});
          if (currentUser.id == userToAdd.id) {
            currentUser.addUserToGroup(groupId, userToAdd);
          }
          //UPDATE HERE THE USER GROUPS LIST WITH THE USER METHOD!!!!!!!!!
          userToAdd.addUserToGroup(groupId, userToAdd);
        },
        onError: (e) => print('Error in addUser! ' + e.toString()),
      );
    } else {
      //ADD HERE POP UP TO USER AND NOT JUST PRINT!!!!!!
      print('You need to be Admin to kick some one from the group!');
    }
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
        user.leaveGroup(user, groupId);
      }
    });
  }

  //Function to kick someone from group - ONLY ADMIN!
  Future kickFromGroup(MyUser userToKick, String groupId) async {
    if (groupManagerId == currentUser.id) {
      await leaveGroup(userToKick, groupId);
    } else {
      //ADD HERE POP UP TO USER AND NOT JUST PRINT!!!!
      print('You need to be Admin to kick some one from the group!');
    }
  }
}

///***********************Other functions - End**************************** */