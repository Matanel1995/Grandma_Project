import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';

//define global variables here
MyUser currentUser = MyUser(
    id: '0',
    userName: '0',
    photoUrl: '0',
    email: '0',
    currentGroupId: '0',
    groupsList: [],
    isViewer: false);

List<MyUser> usersList = [];

List<MyUser> usersListToAdd = [];

List<Group> groupsListToReturn = [];
