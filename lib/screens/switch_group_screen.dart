import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:google_signin/main.dart';

class SwitchGroupScreen extends StatefulWidget {
  final Group currGroup;

  const SwitchGroupScreen({
    super.key,
    required this.currGroup,
  });

  @override
  State<SwitchGroupScreen> createState() => _SwitchGroupScreen();
}

class _SwitchGroupScreen extends State<SwitchGroupScreen> {
  final controllerSwitchGroup = TextEditingController();
  String switchGroup = '';
  bool switched = false;

  Widget show() {
    if (switched) {
      return Center(
          child: buildText(
              context,
              'You switched to the ${widget.currGroup.getGroupName} group'
              '\nYou can go back now.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controllerSwitchGroup,
          decoration: InputDecoration(
              hintText: '"switch" to confirm',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // clear what's currently in the textfield
                  controllerSwitchGroup.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        MaterialButton(
          // update the group name
          onPressed: () {
            setState(() {
              switchGroup = controllerSwitchGroup.text;
            });
            if (switchGroup.toLowerCase() == 'switch') {
              //ADD HRER CHANGE CURRENT GROUP FUNCTION
              () async {
                await currentUser.SetCurrentGroup(widget.currGroup.groupId);
              }.call();
              setState(() {
                switched = true;
              });
              // createGroup(MyUser user, String groupName, String groupPhotoUrl)
              // createGroup(currentUser, groupName, photoURL);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: buildTitle(context, 'Wrong input'),
                      content: buildText(context, 'You didn\'t type "switch"'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return SwitchGroupScreen(
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
        title: buildTitle(context, 'Switch Group'),
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
