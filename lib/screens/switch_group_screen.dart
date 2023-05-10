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
  bool isLoading = false;

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
        Container(
          padding: const EdgeInsets.all(20),
          child: buildText(
              context, 'Are you sure you want to switch to this group?'),
        ),
        MaterialButton(
          // update the group name
          onPressed: () {
            () async {
              await currentUser.SetCurrentGroup(widget.currGroup.groupId);
            }.call();
            setState(() {
              switched = true;
            });
            setState(() {
              isLoading =
                  true; // set isLoading to true when the button is pressed
            });
          },
          color: Theme.of(context).cardColor,
          child: buildText(context, 'Yes'),
        ),
        Visibility(
            visible:
                isLoading, // show CircularProgressIndicator when isLoading is true
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).cardColor),
                  ),
                ),
              ),
            )),
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
