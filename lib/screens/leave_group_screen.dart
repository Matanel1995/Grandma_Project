import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';

class LeaveGroupScreen extends StatefulWidget {
  const LeaveGroupScreen({super.key});

  @override
  State<LeaveGroupScreen> createState() => _LeaveGroupScreen();
}

class _LeaveGroupScreen extends State<LeaveGroupScreen> {
  final controllerLeaveGroup = TextEditingController();
  String leaveGroup = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Group',
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
              controller: controllerLeaveGroup,
              decoration: InputDecoration(
                  hintText: '"yes" to confirm',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // clear what's currently in the textfield
                      controllerLeaveGroup.clear();
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
            MaterialButton(
              // update the group name
              onPressed: () {
                setState(() {
                  leaveGroup = controllerLeaveGroup.text;
                });
                if (leaveGroup != '') {
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
