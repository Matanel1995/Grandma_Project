import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';

class kickUserScreen extends StatefulWidget {
  const kickUserScreen({super.key});

  @override
  State<kickUserScreen> createState() => _kickUserScreen();
}

class _kickUserScreen extends State<kickUserScreen> {
  final conteollerKickUser = TextEditingController();
  String kickUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kick User',
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
              controller: conteollerKickUser,
              decoration: InputDecoration(
                  hintText: 'Please provide a user to kick',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // clear what's currently in the textfield
                      conteollerKickUser.clear();
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
            MaterialButton(
              // update the group name
              onPressed: () {
                setState(() {
                  kickUser = conteollerKickUser.text;
                });
                if (kickUser != '') {
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
