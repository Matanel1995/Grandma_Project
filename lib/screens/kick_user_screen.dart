import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';

class kickUserScreen extends StatefulWidget {
  const kickUserScreen({super.key});

  @override
  State<kickUserScreen> createState() => _kickUserScreen();
}

class _kickUserScreen extends State<kickUserScreen> {
  final conteollerKickUser = TextEditingController();
  String kickUser = '';
  bool isKicked = false;

  Widget show() {
    if (isKicked) {
      return const Expanded(
        child: Center(
            child: Text(
          'The user XXXXXXXX has been kicked. \nYou can go back now.',
          style: TextStyle(color: Colors.black, fontSize: 20),
        )),
      );
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
              // createGroup(MyUser user, String groupName, String groupPhotoUrl)
              // createGroup(currentUser, groupName, photoURL);
              isKicked = true;
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
          'Kick User',
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
