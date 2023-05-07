import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:google_signin/main.dart';

import '../models/user.dart';

class kickUserScreen extends StatefulWidget {
  final Group currGroup;

  const kickUserScreen({
    super.key,
    required this.currGroup,
  });

  @override
  State<kickUserScreen> createState() => _kickUserScreen();
}

class _kickUserScreen extends State<kickUserScreen> {
  final conteollerKickUser = TextEditingController();
  String kickUser = '';
  bool isKicked = false;

  Widget show() {
    if (isKicked) {
      return Center(
          child: buildText(
              context, 'The user has been kicked. \nYou can go back now.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: buildText(context, 'Enter the user Email')),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: conteollerKickUser,
          decoration: InputDecoration(
              hintText: 'Example@mail.com',
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
              () async {
                usersList = await currentUser.getUserByEmail([kickUser])
                    as List<MyUser>;
              }.call().then((value) {
                if (usersList.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: buildText(context, 'Error.'),
                          content: buildText(context,
                              'Email is not valid.\nTry again with a valid email.'),
                          actions: [
                            TextButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Text("Ok"))
                          ],
                        );
                      });
                } else {
                  widget.currGroup.kickFromGroup(
                      usersList.elementAt(0), currentUser.currentGroupId);
                  isKicked = true;
                }
              });
              usersList = [];
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
        title: Text(
          'Kick User',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isKicked) {
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
