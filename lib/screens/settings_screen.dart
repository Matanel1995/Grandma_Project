import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';
import 'package:google_signin/screens/welcome_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return WelcomeScreen();
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
            child: Text(
              'Adjust your view type',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                    title: const Text('Grandma View'),
                    value: currentUser.isViewer,
                    subtitle: const Text(
                        'Only shows the gallery, very simple for grandma.'),
                    onChanged: (newValue) {
                      setState(() {
                        currentUser.changeViewMode(newValue);
                      });
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
