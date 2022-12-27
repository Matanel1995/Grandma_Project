import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/my_groups_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 5),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => MyGroupsScreen())));
  // }

  final controllerGroupName = TextEditingController();
  final controllerGroupPhoto = TextEditingController();
  String groupName = '';
  String photoURL = '';
  bool isCreated = false;

  Widget showError() {
    return Expanded(
      child: Center(
          child: Text(
        'congratulations!!\nThe group $groupName has been created! \nYou can go back now.',
        style: const TextStyle(color: Colors.black, fontSize: 20),
      )),
    );
  }

  Widget show() {
    if (isCreated) {
      //display text
      return Expanded(
        child: Center(
            child: Text(
          'congratulations!!\nThe group $groupName has been created! \nYou can go back now.',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        )),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controllerGroupName,
          decoration: InputDecoration(
              hintText: 'Please provide a group name?',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // clear what's currently in the textfield
                  controllerGroupName.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        Divider(
          height: 20,
        ),
        TextField(
          controller: controllerGroupPhoto,
          decoration: InputDecoration(
              hintText: 'Please provide a photo URL',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // clear what's currently in the textfield
                  controllerGroupPhoto.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        MaterialButton(
          // update the group name
          onPressed: () {
            setState(() {
              groupName = controllerGroupName.text;
              photoURL = controllerGroupPhoto.text;
            });
            if (groupName != '' && photoURL != '') {
              Group.createAsync(currentUser, groupName, photoURL);
              // auto switching page after 5 seconds
              Timer(
                  const Duration(seconds: 5),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyGroupsScreen())));
              isCreated = true;
            } else {
              showError();
            }
          },
          color: Colors.blue,
          child: const Text(
            'Create',
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          // update the group name
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => MyGroupsScreen())),
          color: Colors.purple,
          child: const Text(
            'Back To My Groups',
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
          'Create Group',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            show(),
          ],
        ),
      ),
    );
  }
}
