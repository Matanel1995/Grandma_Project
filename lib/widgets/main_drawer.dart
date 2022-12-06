import 'package:flutter/material.dart';
import 'package:google_signin/widgets/upload_photo.dart';
import 'package:provider/provider.dart';

import '../models/google_sign_in.dart';
import '../screens/ideas_screen.dart';
import '../screens/table_score.dart';

class MainDrawer extends StatelessWidget {
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

  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            'Menu',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildListTile('Home', Icons.house, () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile('Ideas', Icons.light, () {
          Navigator.of(context).pushReplacementNamed(IdeasScreen.routeName);
        }),
        buildListTile('Score Table', Icons.score, () {
          Navigator.of(context).pushReplacementNamed(TableScore.routeName);
        }),
        // maybe
        buildListTile('Upload Photo', Icons.add_a_photo, () {
          Navigator.of(context).pushReplacementNamed(UploadPhoto.routeName);
        }),
        buildListTile('My Groups', Icons.group, () {
          // Navigator.of(context).pushReplacementNamed(UploadPhoto.routeName);
        }),
        buildListTile('Settings', Icons.settings, () {
          // Navigator.of(context).pushReplacementNamed(UploadPhoto.routeName);
        }),
        buildListTile('Log Out', Icons.logout, () {
          final provider =
              Provider.of<GoogleSingInPovider>(context, listen: false);
          provider.logout();
        }),
      ],
    ));
  }
}
