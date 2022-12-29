import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';

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
      id: snapshot['userId'],
      userName: snapshot['userName'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
      currentGroupId: snapshot['currentGroupId'],
      groupsList: snapshot['groupList'],
      isViewer: snapshot['isViewer'],
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
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    await docRef.get().then(
        (doc) => {
              if (doc.exists &&
                  groupsList.contains(
                      groupId)) //if group exist and user is part of it
                {
                  docRef.update({'currentGroupId': groupId}),
                  currentUser.currentGroupId = groupId,
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
    print("in add user to group");
    //Get doc referance
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Group').doc(groupId);
    //check if document exist
    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              print('Doc Exist!'),
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
    print("AFTER add user to group");
  }

  //Function to add user to a group, the group id added to users list
  Future addUserOnCreation(String groupId) async {
    print("in add user to group");
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
    print("AFTER add user to group");
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
    print(usersList.length);
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
    print(groupsListToReturn.elementAt(0).getGroupName);
    return groupsListToReturn;
  }
}
