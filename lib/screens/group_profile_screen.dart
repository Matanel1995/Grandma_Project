import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/add_user_screen.dart';
import 'package:google_signin/screens/kick_user_screen.dart';
import 'package:google_signin/screens/leave_group_screen.dart';

import '../models/Group.dart';

class GroupProfileScreen extends StatelessWidget {
  final Group currGroup;
  // const GroupProfileScreen({super.key, this.groupId});

  const GroupProfileScreen({
    super.key,
    required this.currGroup,
  });

  Widget buildListTile(
      String title, IconData iconData, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  Widget adminCanAddKick(BuildContext context) {
    if (currentUser.id == currGroup.groupManagerId) {
      return Column(
        children: [
          buildListTile('Add User', Icons.add_road, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return AddUserScreen(
                    currGroup: currGroup,
                  );
                },
              ),
            );
          }),
          buildListTile('Kick User', Icons.no_accounts, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return kickUserScreen();
                },
              ),
            );
          }),
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Group Profile',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   children: [
            //     Text(
            //       'Group Name : ${currGroup.groupName}',
            //       style: const TextStyle(
            //         fontFamily: 'RobotoCondensed',
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              height: 200,
              width: 1000,
              padding: const EdgeInsets.all(4),
              child: AspectRatio(
                aspectRatio: 2.62 / 3,
                child: Container(
                  margin: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(currGroup.groupPhotoUrl)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            stops: const [
                              0.1,
                              0.9
                            ],
                            colors: [
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.1)
                            ])),
                    child: Align(
                      alignment: const Alignment(-0.8, 0.77),
                      child: Text(
                        currGroup.groupName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            buildListTile(
                'Group ID : ${currGroup.getGroupId}', Icons.group, () {}),
            buildListTile('Group Admin ID : ${currGroup.getGroupManagerId}',
                Icons.man, () {}),
            buildListTile(
                'Number Of Users : ${(currGroup.getGroupUsers).length}',
                Icons.numbers,
                () {}),
            adminCanAddKick(context),
            buildListTile(
                'Switch To This Group', Icons.switch_access_shortcut, () {}),
            buildListTile('Leave Group', Icons.exit_to_app, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return LeaveGroupScreen();
                  },
                ),
              );
            }),
          ],
        ));
  }
}
