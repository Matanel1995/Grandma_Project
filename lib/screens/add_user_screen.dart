import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final controllerAddUser = TextEditingController();
  String addUser = '';
  bool isAdded = false;

  Widget show() {
    if (isAdded) {
      return const Expanded(
        child: Center(
            child: Text(
          'The user XXXXXXXX has been added. \nYou can go back now.',
          style: TextStyle(color: Colors.black, fontSize: 20),
        )),
      );
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
              // late Group currGroup;
              // FirebaseFirestore.instance
              //     .collection('Group')
              //     .doc(currentUser.currentGroupId)
              //     .get()
              //     .then((value) {
              //   currGroup = Group.fromFirestore(value as Map<String, dynamic>);
              // });
              isAdded = true;
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: show(),
      ),
    );
  }
}
