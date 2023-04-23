// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
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
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var userId = paresProvider(snapshot.data!.providerData.toString());
            () async {
              await initCurrentUser(userId);
            }.call();
            return HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: buildText(context, 'Somthing went wrong'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }

  Future initCurrentUser(String userId) async {
    usersList = await currentUser.getUsersUsingServer([userId]) as List<MyUser>;
    currentUser = usersList[0];
  }

  String paresProvider(String info) {
    List<String> data = info.split(",");
    String userId = data[data.length - 1];
    userId = userId.split(':')[1];
    userId = userId.trim();
    userId = userId.substring(0, userId.length - 2);
    return userId;
  }
}
