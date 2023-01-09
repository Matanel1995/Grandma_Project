import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';

class LeaveGroupScreen extends StatefulWidget {
  final Group currGroup;

  const LeaveGroupScreen({
    super.key,
    required this.currGroup,
  });

  @override
  State<LeaveGroupScreen> createState() => _LeaveGroupScreen();
}

class _LeaveGroupScreen extends State<LeaveGroupScreen> {
  final controllerLeaveGroup = TextEditingController();
  String leaveGroup = '';
  bool left = false;

  Widget show() {
    if (left) {
      return Center(
          child: Text(
        'You left the ${widget.currGroup.getGroupName} group'
        '\nYou can go back now.',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
            if (leaveGroup.toLowerCase() == 'yes') {
              setState(() {
                left = true;
              });
              // createGroup(MyUser user, String groupName, String groupPhotoUrl)
              // createGroup(currentUser, groupName, photoURL);
              () async {
                await widget.currGroup
                    .leaveGroup(currentUser, widget.currGroup.groupId);
              }.call();
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Wrong input'),
                      content: const Text('You didn\'t type "yes"'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return LeaveGroupScreen(
                                      currGroup: widget.currGroup,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text('OK'))
                      ],
                    );
                  });
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
          'Leave Group',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (left) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const WelcomeScreen();
                  },
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
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
