import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';

class AddUserScreen extends StatefulWidget {
  final Group currGroup;

  const AddUserScreen({
    super.key,
    required this.currGroup,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final controllerAddUser = TextEditingController();
  String addUser = '';
  bool isAdded = false;

  Widget show() {
    if (isAdded) {
      return Center(
          child: Text(
        'The user has been added to ${widget.currGroup.getGroupName}'
        '\nYou can go back now.',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controllerAddUser,
          decoration: InputDecoration(
              hintText: 'Please provide a user to add',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // clear what's currently in the textfield
                  controllerAddUser.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        MaterialButton(
          // update the group name
          onPressed: () {
            setState(() {
              addUser = controllerAddUser.text;
            });
            if (addUser != '') {
              print(addUser);
              print(currentUser.currentGroupId);
              () async {
                usersList =
                    await currentUser.getUsers([addUser]) as List<MyUser>;
              }.call().then((value) {
                //print(usersList.length);
                if (usersList.isEmpty) {
                  print("NOT FOUND");
                } else {
                  widget.currGroup.addUser(usersList.elementAt(0));
                  print('AFTER ADD USER');
                }
              });
              // FutureBuilder(
              //   future: widget.currGroup.addUser(usersList.elementAt(0)),
              //   builder: (context, snapshot) {
              //     print('INSIDE FUTURE BUILDER');
              //     // groupsListToReturn = snapshot.data as List<Group>;
              //     // print(groupsListToReturn.elementAt(0).getGroupId.toString());
              //     return Container();
              //   },
              // );
              isAdded = true;
              print('after isADDED = TRUE');
            }
          },
          color: Colors.blue,
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return const WelcomeScreen();
                },
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: show(),
      ),
    );
  }
}
