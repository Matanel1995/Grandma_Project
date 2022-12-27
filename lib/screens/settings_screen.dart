import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isGrandma = false;

  bool getViewMode() {
    return isGrandma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleMedium,
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
                    value: isGrandma,
                    subtitle: const Text(
                        'Only shows the gallery, very simple for grandma.'),
                    onChanged: (newValue) {
                      print(isGrandma);
                      setState(() {
                        isGrandma = newValue;
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
