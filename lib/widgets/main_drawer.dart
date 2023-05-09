// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';
import 'package:google_signin/screens/my_groups_screen.dart';
import 'package:google_signin/screens/notifications_screen.dart';
import 'package:google_signin/screens/settings_screen.dart';
import 'package:google_signin/widgets/upload_photo.dart';
import 'package:provider/provider.dart';

import '../models/google_sign_in.dart';

import '../screens/table_score.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final settings = SettingsScreen();

  Widget buildListTile(
      String title, IconData iconData, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
        color: Theme.of(context).focusColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: tapHandler,
    );
  }

  Column _getViewType() {
    if (!currentUser.isViewer) {
      return Column(
        children: <Widget>[
          buildListTile('Home', Icons.house, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return HomeScreen();
                },
              ),
            );
          }),
          buildListTile('Score Table', Icons.score, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return TableScore();
                },
              ),
            );
          }),
          buildListTile('Upload Photo', Icons.add_a_photo, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return UploadPhoto();
                },
              ),
            );
          }),
          buildListTile('My Groups', Icons.group, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return MyGroupsScreen();
                },
              ),
            );
          }),
          buildListTile('Notifications', Icons.notifications, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return NotificationScreen();
                },
              ),
            );
          }),
          buildListTile('Settings', Icons.settings, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return SettingsScreen();
                },
              ),
            );
          }),
          buildListTile('Log Out', Icons.logout, () {
            final provider =
                Provider.of<GoogleSingInPovider>(context, listen: false);
            provider.logout();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          }),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          buildListTile('Home', Icons.house, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return HomeScreen();
                },
              ),
            );
          }),
          buildListTile('My Groups', Icons.group, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return MyGroupsScreen();
                },
              ),
            );
          }),
          buildListTile('Settings', Icons.settings, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return SettingsScreen();
                },
              ),
            );
          }),
          buildListTile('Log Out', Icons.logout, () {
            final provider =
                Provider.of<GoogleSingInPovider>(context, listen: false);
            provider.logout();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          })
        ],
      );
    }
  }

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding:
                const EdgeInsets.fromLTRB(20, 30, 20, 10), // add top padding
            alignment: Alignment.centerLeft,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(currentUser.photoUrl),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Container(
                    child: Text(
                      currentUser.userName,
                      maxLines: 10,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              // add SingleChildScrollView around ListView
              child: _getViewType(),
            ),
          ),
        ],
      ),
    );
  }
}
