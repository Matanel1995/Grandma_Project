import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';

class AddUserScreen extends StatefulWidget {
  final Group currGroup;

  const AddUserScreen({
    super.key,
    required this.currGroup,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final controllerAddUser = TextEditingController();
  String addUser = '';
  bool isAdded = false;
  bool isLoading = false;
  Widget show() {
    if (isAdded) {
      return Center(
          child: buildText(
              context,
              'The user has been added to ${widget.currGroup.getGroupName}'
              '\nYou can go back now.'));
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
          controller: controllerAddUser,
          decoration: InputDecoration(
              hintText: 'Example@mail.com',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // clear what's currently in the textfield
                  controllerAddUser.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            MaterialButton(
              // update the group name
              onPressed: () async {
                setState(() {
                  addUser = controllerAddUser.text;
                });
                if (addUser != '') {
                  setState(() {
                    isLoading =
                        true; // set isLoading to true when the button is pressed
                  });
                  usersList = await currentUser.getUserByEmail([addUser])
                      as List<MyUser>;
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
                    widget.currGroup.addUser(usersList.elementAt(0));
                    setState(() {
                      isAdded = true;
                    });
                  }
                  setState(() {
                    isLoading =
                        false; // set isLoading to false when the function completes
                  });
                  usersList = [];
                }
              },
              color: Theme.of(context).cardColor,
              child: buildText(context, 'Confirm'),
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'Add User'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isAdded) {
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
