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
              () async {
                await currentUser.getUsersUsingServer([kickUser])
                    as List<MyUser>;
              }.call().then((value) {
                if (usersList.isEmpty) {
                  print('NOT FOUND!');
                } else {
                  widget.currGroup.kickFromGroup(
                      usersList.elementAt(0), widget.currGroup.groupId);
                }
              });
              usersList = [];
              isKicked = true;
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
