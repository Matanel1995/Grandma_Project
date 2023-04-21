import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:google_signin/main.dart';
import '../models/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isViewer = currentUser.getIsViewer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'Settings'),
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: buildText(context, 'Adjust your view type'),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                    title: buildText(context, 'Grandma View'),
                    value: _isViewer,
                    subtitle: buildTextSmall(context,
                        'Only shows the gallery, very simple for grandma.'),
                    onChanged: (value) {
                      setState(() {
                        currentUser.SetViewMode(value);
                        _isViewer = value;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
