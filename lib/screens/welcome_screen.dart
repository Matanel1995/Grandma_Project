// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';

import '../models/user.dart';
import 'Login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var userId = parseProvider(snapshot.data!.providerData.toString());
            return FutureBuilder<void>(
              future: _initializeCurrentUser(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return HomeScreen();
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }

  Future<void> _initializeCurrentUser(String userId) async {
    usersList = [];
    usersList = await currentUser.getUsers([userId]) as List<MyUser>;

    print("############### Before changing currentUser ################");
    print(currentUser.email);

    currentUser = usersList[0];

    print("############### After changing currentUser ################");
    print(currentUser.email);
  }

  String parseProvider(String info) {
    List<String> data = info.split(",");
    String userId = data[data.length - 1];
    userId = userId.split(':')[1];
    userId = userId.trim();
    userId = userId.substring(0, userId.length - 2);
    return userId;
  }
}
