import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';

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
          child: Text(
        'You switched to the ${widget.currGroup.getGroupName} group'
        '\nYou can go back now.',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ));
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
                      title: const Text('Wrong input'),
                      content: const Text('You didn\'t type "switch"'),
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Switch Group',
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
