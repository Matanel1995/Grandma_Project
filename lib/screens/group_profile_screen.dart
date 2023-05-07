import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/add_user_screen.dart';
import 'package:google_signin/screens/kick_user_screen.dart';
import 'package:google_signin/screens/leave_group_screen.dart';
import 'package:google_signin/screens/switch_group_screen.dart';
import 'package:google_signin/main.dart';
import '../models/Group.dart';

class GroupProfileScreen extends StatelessWidget {
  final Group currGroup;

  const GroupProfileScreen({
    super.key,
    required this.currGroup,
  });

  Widget buildListTile(BuildContext context, String title, IconData iconData,
      VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: tapHandler,
    );
  }

  Widget adminCanAddKick(BuildContext context) {
    if (currentUser.id == currGroup.groupManagerId) {
      return Column(
        children: [
          buildListTile(context, 'Add User', Icons.add_road, () {
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
          buildListTile(context, 'Kick User', Icons.no_accounts, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return kickUserScreen(
                    currGroup: currGroup,
                  );
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: buildTitle(context, 'Group Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              child: AspectRatio(
                aspectRatio: 2.62 / 3,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(currGroup.groupPhotoUrl)),
                  ),
                  child: Container(
                    width: double.infinity,
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
            buildListTile(context, 'Group ID : ${currGroup.getGroupId}',
                Icons.group, () {}),
            buildListTile(
                context,
                'Group Admin ID : ${currGroup.getGroupManagerId}',
                Icons.man,
                () {}),
            buildListTile(
                context,
                'Number Of Users : ${(currGroup.getGroupUsers).length}',
                Icons.numbers,
                () {}),
            adminCanAddKick(context),
            buildListTile(
                context, 'Switch To This Group', Icons.switch_access_shortcut,
                () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return SwitchGroupScreen(
                      currGroup: currGroup,
                    );
                  },
                ),
              );
            }),
            buildListTile(context, 'Leave Group', Icons.exit_to_app, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return LeaveGroupScreen(
                      currGroup: currGroup,
                    );
                  },
                ),
              );
            }),
          ],
        ));
  }
}
