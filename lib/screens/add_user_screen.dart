import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final controllerAddUser = TextEditingController();
  String addUser = '';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //display text
            // Expanded(
            //   child: Container(
            //       child: Center(
            //     child: Text(groupName),
            //   )),
            // ),
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
                  // createGroup(MyUser user, String groupName, String groupPhotoUrl)
                  // createGroup(currentUser, groupName, photoURL);
                }
              },
              color: Colors.blue,
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
