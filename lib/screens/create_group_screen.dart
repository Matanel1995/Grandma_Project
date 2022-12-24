import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final controllerGroupName = TextEditingController();
  final controllerGroupPhoto = TextEditingController();
  String groupName = '';
  String photoURL = '';

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
            //display text
            // Expanded(
            //   child: Container(
            //       child: Center(
            //     child: Text(groupName),
            //   )),
            // ),
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
                  // createGroup(MyUser user, String groupName, String groupPhotoUrl)
                  // createGroup(currentUser, groupName, photoURL);
                }
              },
              color: Colors.blue,
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
