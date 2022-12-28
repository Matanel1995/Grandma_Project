// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/my_groups_screen.dart';
import 'package:google_signin/screens/settings_screen.dart';
import 'package:google_signin/widgets/upload_photo.dart';
import 'package:provider/provider.dart';

import '../models/google_sign_in.dart';
import '../screens/ideas_screen.dart';
import '../screens/table_score.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final settings = new SettingsScreen();

  Column viewType() {
    if (!currentUser.isViewer) {
      return Column(
        children: <Widget>[
          buildListTile('Home', Icons.house, () {
            Navigator.of(context).pushReplacementNamed('/');
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
          // maybe
          buildListTile('Upload Photo', Icons.add_a_photo, () {
            // Navigator.of(context).pushReplacementNamed(UploadPhoto.routeName);
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
            Navigator.of(context).pushReplacementNamed('/');
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
        ],
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(currentUser.photoUrl),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: Text(
                  currentUser.userName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        viewType()
      ],
    ));
  }
}
