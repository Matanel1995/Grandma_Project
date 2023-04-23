import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:google_signin/main.dart';

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
          child: buildText(
              context,
              'You left the ${widget.currGroup.getGroupName} group'
              '\nYou can go back now.'));
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
                      title: buildText(context, 'Wrong Input'),
                      content: buildText(context, 'You didn\'t type "yes"'),
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
                            child: buildText(context, 'OK'))
                      ],
                    );
                  });
            }
          },
          color: Theme.of(context).cardColor,
          child: buildText(context, 'Confirm'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'Leave Group'),
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
